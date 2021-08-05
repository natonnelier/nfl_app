defmodule NflRushingWeb.PlayerView do
  use NflRushingWeb, :view
  alias NflRushingWeb.PlayerView

  def render("index.json", %{players: players}) do
    %{data: render_many(players, PlayerView, "player.json")}
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, PlayerView, "player.json")}
  end

  def render("player.json", %{player: player}) do
    %{id: player.id,
      name: player.name,
      team: player.team,
      position: player.position,
      attempts: player.attempts,
      attempts_avg: player.attempts_avg,
      yards_total: player.yards_total,
      yards_avg: player.yards_avg,
      yards_per_game: player.yards_per_game,
      touchdowns: player.touchdowns,
      longest_rush: player.longest_rush,
      rushing_first: player.rushing_first,
      rushing_first_percentage: player.rushing_first_percentage,
      twenty_yards: player.twenty_yards,
      forty_yards: player.forty_yards,
      fumbles: player.fumbles}
  end
end
