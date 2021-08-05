defmodule NflRushingWeb.PlayerControllerTest do
  use NflRushingWeb.ConnCase

  alias NflRushing.Players
  alias NflRushing.Players.Player

  @create_attrs %{
    attempts: 42,
    attempts_avg: 120.5,
    forty_yards: 42,
    fumbles: 42,
    longest_rush: 42,
    name: "some name",
    position: "some position",
    rushing_first: 42,
    rushing_first_percentage: 120.5,
    team: "some team",
    touchdowns: 42,
    twenty_yards: 42,
    yards_avg: 120.5,
    yards_per_game: 120.5,
    yards_total: 120.5
  }
  @update_attrs %{
    attempts: 43,
    attempts_avg: 456.7,
    forty_yards: 43,
    fumbles: 43,
    longest_rush: 43,
    name: "some updated name",
    position: "some updated position",
    rushing_first: 43,
    rushing_first_percentage: 456.7,
    team: "some updated team",
    touchdowns: 43,
    twenty_yards: 43,
    yards_avg: 456.7,
    yards_per_game: 456.7,
    yards_total: 456.7
  }
  @invalid_attrs %{attempts: nil, attempts_avg: nil, forty_yards: nil, fumbles: nil, longest_rush: nil, name: nil, position: nil, rushing_first: nil, rushing_first_percentage: nil, team: nil, touchdowns: nil, twenty_yards: nil, yards_avg: nil, yards_per_game: nil, yards_total: nil}

  def fixture(:player) do
    {:ok, player} = Players.create_player(@create_attrs)
    player
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all players", %{conn: conn} do
      conn = get(conn, Routes.player_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_player(_) do
    player = fixture(:player)
    %{player: player}
  end
end
