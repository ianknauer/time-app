defmodule TimeApp.Tracker do
  use Ash.Domain,
    extensions: [
      AshGraphql.Domain
    ]

  graphql do
    authorize? false

    queries do
      list(TimeApp.Tracker.Session, :list_sessions, :read)
      read_one(TimeApp.Tracker.Session, :get_session, :by_id)
    end

    mutations do
      create(TimeApp.Tracker.Session, :create_session, :create)
      update(TimeApp.Tracker.Session, :update_session, :update)
    end
  end

  resources do
    resource TimeApp.Tracker.Session
  end
end
