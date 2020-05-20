defmodule Chavez.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :name, :string
      add :tries, :integer
      add :time, :integer
      add :score, :integer

      timestamps()
    end
  end
end
