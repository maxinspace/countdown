defmodule CountdownWeb.PageController do
  use CountdownWeb, :controller
  alias Countdown.Events

  def index(conn, _params) do
    future_events = Events.list_future_events
    render conn, "index.html", events: future_events
  end
end
