defmodule Chavez.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :name, :string
    field :score, :integer
    field :time, :integer
    field :tries, :integer

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:name, :tries, :time, :score])
    |> validate_required([:name, :tries, :time, :score])
  end
end
