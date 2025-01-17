defmodule TimeApp.Repo.Migrations.InitialMigration do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:sessions, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true

      add :inserted_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :what, :text
      add :why, :text
      add :success_criteria, :text
      add :risks, :text
      add :measurable, :text
      add :other, :text
      add :cycle_count, :bigint
      add :start_time, :utc_datetime
      add :cycle_length, :bigint
      add :break_length, :bigint
      add :accomplishments, :text
      add :compared_to_normal, :text
      add :difficult_areas, :text
      add :how_to_replicate, :text
      add :other_takeways, :text
    end
  end

  def down do
    drop table(:sessions)
  end
end
