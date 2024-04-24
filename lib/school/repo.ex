defmodule School.Repo do
  use Ecto.Repo,
    otp_app: :school_project,
    adapter: Ecto.Adapters.SQLite3
end
