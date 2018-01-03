defmodule CountdownWeb.AuthController do
  use CountdownWeb, :controller

  alias Auth0Ex.Authentication
  alias CountdownWeb.Router.Helpers

  def index(conn, _params) do
    case auth_code(conn) do
      {:ok, response} -> conn
        |> put_resp_cookie("jwt", response["id_token"])
        |> redirect(to: redirect_uri(conn))
      {:error} -> conn
        |> redirect(to: "/")
      {:error, _errors, 400} -> conn
        |> redirect(to: "/")
    end
  end

  def login(conn, _params) do
    conn
      |> redirect(external: auth0_uri(conn))
      |> halt
  end

  def logout(conn, _params) do
    conn
      |> delete_resp_cookie("jwt")
      |> redirect(to: "/")
  end

  def auth_code(conn) do
    Authentication.Token.auth_code(
      Application.get_env(:auth0_ex, :mgmt_client_id),
      Application.get_env(:auth0_ex, :mgmt_client_secret),
      conn.query_params["code"],
      Helpers.url(conn) <> "/auth"
    )
  end

  def redirect_uri(conn) do
    if conn.params["redirect"], do: conn.params["redirect"], else: "/"
  end

  def auth0_uri(conn) do
    "https://"
      <> Application.get_env(:auth0_ex, :domain)
      <> "/login?client="
      <> Application.get_env(:auth0_ex, :mgmt_client_id)
      <> "&redirect_uri="
      <> Helpers.url(conn)
      <> "/auth?redirect="
      <> redirect_uri(conn)
  end
end
