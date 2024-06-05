defmodule TimeApp.Repo do
  use AshPostgres.Repo, otp_app: :time_app

  def installed_extensions do
    ["ash-functions", "uuid-ossp", "citext"]
  end
end
