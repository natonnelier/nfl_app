defmodule NflRushing.PlayersTest do
  use NflRushing.DataCase

  alias NflRushing.Players

  describe "players" do
    alias NflRushing.Players.Player

    @valid_attrs %{attempts: 42, attempts_avg: 120.5, forty_yards: 42, fumbles: 42, longest_rush: 42, name: "Larry", position: "some position", rushing_first: 42, rushing_first_percentage: 120.5, team: "Lary's team", touchdowns: 12, twenty_yards: 42, yards_avg: 120.5, yards_per_game: 120.5, yards_total: 110.1}
    @valid_attrs_2 %{attempts: 42, attempts_avg: 120.5, forty_yards: 42, fumbles: 42, longest_rush: 40, name: "Moe", position: "some position", rushing_first: 42, rushing_first_percentage: 120.5, team: "Moe's team", touchdowns: 42, twenty_yards: 42, yards_avg: 120.5, yards_per_game: 120.5, yards_total: 120.5}
    @valid_attrs_3 %{attempts: 42, attempts_avg: 120.5, forty_yards: 42, fumbles: 42, longest_rush: 52, name: "Curly", position: "some position", rushing_first: 42, rushing_first_percentage: 120.5, team: "Curly's team", touchdowns: 2, twenty_yards: 42, yards_avg: 120.5, yards_per_game: 120.5, yards_total: 30.5}
    @invalid_attrs %{attempts: nil, attempts_avg: nil, forty_yards: nil, fumbles: nil, longest_rush: nil, name: nil, position: nil, rushing_first: nil, rushing_first_percentage: nil, team: nil, touchdowns: nil, twenty_yards: nil, yards_avg: nil, yards_per_game: nil, yards_total: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Players.create_player()

      player
    end

    test "list_players/0 returns all players" do
      populate()
      players = Players.list_players()
      assert length(players) == 3
    end

    test "list_players(%{sort_by: touchdowns}) returns ordered players' list" do
      populate()
      params = %{"sort_by" => "yards_total"}
      players = Players.list_players(params)
      [first | tail] = players
      [second | _tail] = tail

      assert first.yards_total == 120.5
      assert second.yards_total == 110.1
    end

    test "list_players(%{name: name_str}) returns filtered players' list" do
      populate()
      params = %{"name" => "Larry"}
      players = Players.list_players(params)
      assert length(players) == 1
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Players.create_player(@valid_attrs)
      assert player.attempts == 42
      assert player.attempts_avg == 120.5
      assert player.forty_yards == 42
      assert player.fumbles == 42
      assert player.longest_rush == 42
      assert player.name == "Larry"
      assert player.position == "some position"
      assert player.rushing_first == 42
      assert player.rushing_first_percentage == 120.5
      assert player.team == "Lary's team"
      assert player.touchdowns == 12
      assert player.twenty_yards == 42
      assert player.yards_avg == 120.5
      assert player.yards_per_game == 120.5
      assert player.yards_total ==110.1
    end

    defp populate() do
      Enum.each([@valid_attrs, @valid_attrs_2, @valid_attrs_3], fn attr -> Players.create_player(attr) end)
    end
  end
end
