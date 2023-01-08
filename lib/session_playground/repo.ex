defmodule SessionPlayground.Repo do
  use Ecto.Repo,
    otp_app: :session_playground,
    adapter: Ecto.Adapters.Postgres
end
