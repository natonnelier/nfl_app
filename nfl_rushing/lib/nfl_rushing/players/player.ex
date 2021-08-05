defmodule NflRushing.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :attempts, :integer
    field :attempts_avg, :float
    field :forty_yards, :integer
    field :fumbles, :integer
    field :longest_rush, :integer
    field :name, :string
    field :position, :string
    field :rushing_first, :integer
    field :rushing_first_percentage, :float
    field :team, :string
    field :touchdowns, :integer
    field :twenty_yards, :integer
    field :yards_avg, :float
    field :yards_per_game, :float
    field :yards_total, :float

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :team, :position, :attempts, :attempts_avg, :yards_total, :yards_avg, :yards_per_game, :touchdowns, :longest_rush, :rushing_first, :rushing_first_percentage, :twenty_yards, :forty_yards, :fumbles])
    |> validate_required([:name, :team, :position, :attempts, :attempts_avg, :yards_total, :yards_avg, :yards_per_game, :touchdowns, :longest_rush, :rushing_first, :rushing_first_percentage, :twenty_yards, :forty_yards, :fumbles])
  end
end
