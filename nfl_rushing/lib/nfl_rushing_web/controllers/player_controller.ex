defmodule NflRushingWeb.PlayerController do
  use NflRushingWeb, :controller

  alias NflRushing.Players
  alias NflRushing.Players.Player

  action_fallback NflRushingWeb.FallbackController

  def index(conn, _params) do
    players = Players.list_players(_params)
    render(conn, "index.json", players: players)
  end

end
