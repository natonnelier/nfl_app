defmodule NflRushing.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :team, :string
      add :position, :string
      add :attempts, :integer
      add :attempts_avg, :float
      add :yards_total, :float
      add :yards_avg, :float
      add :yards_per_game, :float
      add :touchdowns, :integer
      add :longest_rush, :integer
      add :rushing_first, :integer
      add :rushing_first_percentage, :float
      add :twenty_yards, :integer
      add :forty_yards, :integer
      add :fumbles, :integer

      timestamps()
    end

    create index(:players, :name)
  end
end
