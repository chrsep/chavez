defmodule Chavez.Game.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :name, :string
    field :time, :integer
    field :tries, :integer
    field :score, :integer, virtual: true

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:name, :tries, :time])
    |> validate_required([:name, :tries, :time])
  end
end
