defmodule NflRushing.Players do
  @moduledoc """
  The Players context.
  """

  import Ecto.Query, warn: false
  alias NflRushing.Repo

  alias NflRushing.Players.Player

  @sort_by_fields ["longest_rush", "touchdowns", "yards_total"]
  @filters ["name"]

  @doc """
  Returns the list of players with the options to filter by @filters and sort by @sort_by_fields (defaults to desc order).

  ## Examples

      iex> list_players()
      [%Player{}, ...]
      iex> list_players({sort_by: "touchdowns"})
      [%Player{}, ...]
      iex> list_players({sort_by: ["touchdowns", "yards_total"]})
      [%Player{}, ...]
      iex> list_players({sort_by: ["touchdowns", "yards_total"], sort_dir: "asc"})
      [%Player{}, ...]

  """
  def list_players(params \\ %{}) do

    sort_params = extract_sort_fields(params["sort_by"], params["sort_dir"])
    filter_params = extract_filter_fields(params)
  
    build_query(sort_params, filter_params)
    |> Repo.all()
  end

  @doc """
  Creates a player.
  ## Examples
      iex> create_player(%{field: value})
      {:ok, %Player{}}
      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  defp base_query() do
    from(players in Player)
  end

  @doc """
  Receives a map and filters key-value pairs to keep only those keys included in @filters.
  ## Examples
      iex> extract_filter_fields({sort_by: value, name: value})
      {name: value}
  """
  defp extract_filter_fields(params) do
    @filters |> Enum.into(%{}, fn key -> {key, params[key]} end)
  end

  @doc """
  Receives a string or array of strings with sortable fields, it matches it with @sort_by_fields, and returns
  an array to be used in order_by query statement. dir defaults to "desc"
  ## Examples
      iex> extract_sort_fields("touchdowns", "asc")
      [{:asc, :touchdowns}]
      iex> extract_sort_fields(["touchdowns", "yards_total"], "asc")
      [{:asc, :touchdowns},{:asc, :yards_total}]
  """
  defp extract_sort_fields(sort_params, dir_param) when is_binary(sort_params) do
    dir = if dir_param == "asc", do: "asc", else: "desc"
    case sort_params in @sort_by_fields do
      true -> [{String.to_existing_atom(dir), String.to_existing_atom(sort_params)}]
      false -> []
    end
  end
  defp extract_sort_fields(sort_params, dir_param) when is_list(sort_params) do
    dir = if dir_param == "asc", do: "asc", else: "desc"
    list = Enum.map(@sort_by_fields, fn field ->
      case field in sort_params do
        true  -> {String.to_existing_atom(dir), String.to_existing_atom(field)}
        false -> nil
      end
    end)

    Enum.reject(list, &is_nil/1)
  end
  defp extract_sort_fields(_,_), do: []

  @doc """
  Builds a query ready to be executed.
  ## Examples
      iex> build_query({}, {name: "This guy"})
      #Ecto.Query<from p0 in NflRushing.Players.Player, where: ilike(p0.name, ^"%This guy%")>
  """
  defp build_query(sort_params, filters) do
    query = base_query()

    query
    |> maybe_filter_by_name(filters["name"])
    |> maybe_sort_by(sort_params)
  end

  @doc """
  Builds query order_by statement according to sort params. 
  sort_params should be a list like:
    [{:asc, :touchdowns},{:desc, :yards_total}] or
    [asc: :touchdowns, desc: :yards_total]
  """
  defp maybe_sort_by(query, []), do: query
  defp maybe_sort_by(query, sort_params) do
    from(player in query, order_by: ^sort_params)
  end

  @doc """
  Builds query where statement according to sort params.
  name param is a string
  """
  defp maybe_filter_by_name(query, nil), do: query
  defp maybe_filter_by_name(query, name) do
    ilike_name = "%#{name}%"

    from(player in query,
      where: ilike(player.name, ^ilike_name)
    )
  end
end
