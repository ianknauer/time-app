defmodule TimeApp.Tracker.Session do
  use Ash.Resource,
    domain: TimeApp.Tracker,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshGraphql.Resource
    ],
    notifiers: [TimeApp.Tracker.SessionNotifier]

  graphql do
    type :session
  end

  postgres do
    table "sessions"
    repo TimeApp.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:what]
    end

    update :update do
      accept [:what]
    end

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end
  end

  attributes do
    uuid_primary_key :id
    create_timestamp :inserted_at
    update_timestamp :updated_at

    attribute :what, :string do
      public? true
    end

    attribute :why, :string do
      public? true
    end

    attribute :success_criteria, :string do
      public? true
    end

    attribute :risks, :string do
      public? true
    end

    attribute :measurable, :string do
      public? true
    end

    attribute :other, :string do
      public? true
    end

    attribute :cycle_count, :integer
    attribute :start_time, :utc_datetime
    attribute :cycle_length, :integer
    attribute :break_length, :integer
    attribute :accomplishments, :string
    attribute :compared_to_normal, :string
    attribute :difficult_areas, :string
    attribute :how_to_replicate, :string
    attribute :other_takeways, :string
  end
end
