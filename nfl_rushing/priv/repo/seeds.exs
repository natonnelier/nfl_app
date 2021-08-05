alias NflRushing.Players


# Helper methods
defmodule Helper do

  def parse_json(filename) do
    case File.read(filename) do
      {:error, message} -> IO.puts("Error while trying to read #{filename}: #{message}"); []
      {:ok, body}       -> Poison.decode!(body)
    end
  end
  
  def int_to_float(num) when is_float(num), do: num
  def int_to_float(num) do
    case Float.parse(to_string(num)) do
      :error -> nil
      {float_num, _} -> float_num
    end
  end
  
  def str_to_float(num) when is_float(num), do: num
  def str_to_float(num) do
    case Float.parse(to_string(num)) do
      :error -> nil
      {float_num, _} -> float_num
    end
  end

  def get_longest_rush(str) when is_integer(str), do: str
  def get_longest_rush(str) do
    case Integer.parse(str) do
      {val, ""} -> val
      {val, "T"} -> val
    end
  end

end


# Parse Json
nfl_stats_file = "./priv/repo/rushing.json"
entries = Helper.parse_json(nfl_stats_file)


# Save data to DB
Enum.each(entries, fn entry ->

  attrs = %{
    name: entry["Player"],
    team: entry["Team"],
    position: entry["Pos"],
    attempts_avg: entry["Att/G"] |> Helper.int_to_float(),
    attempts: entry["Att"],
    yards_total: entry["Yds"] |> Helper.str_to_float(),
    yards_avg: entry["Avg"] |> Helper.int_to_float(),
    yards_per_game: entry["Yds/G"] |> Helper.int_to_float(),
    touchdowns: entry["TD"],
    longest_rush: entry["Lng"] |> Helper.get_longest_rush,
    rushing_first: entry["1st"],
    rushing_first_percentage: entry["1st%"] |> Helper.int_to_float(),
    twenty_yards: entry["20+"],
    forty_yards: entry["40+"],
    fumbles: entry["FUM"]
  }

  case Players.create_player(attrs) do
    {:ok, player}       -> IO.puts("Player created: #{player.name}")
    {:error, changeset} -> IO.inspect(changeset)
  end
end)
