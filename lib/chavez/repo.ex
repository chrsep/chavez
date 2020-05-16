defmodule Chavez.Repo do
  use Ecto.Repo,
    otp_app: :chavez,
    adapter: Ecto.Adapters.Postgres
end
