defmodule TimeApp.GraphqlSchema do
  use Absinthe.Schema

  use AshGraphql, domains: [TimeApp.Tracker]
  require Ash.Query
  require IEx

  query do
  end

  mutation do
  end

  subscription do
    field :session_updated, :session do
      config(fn _args, _info ->
        {:ok, topic: "session"}
      end)

      resolve(fn args, _, resolution ->
        query =
          AshGraphql.Subscription.query_for_subscription(
            TimeApp.Tracker.Session,
            TimeApp.Tracker,
            resolution
          )

        IEx.pry()

        # query
        # |> Ash.Query.filter(id == ^args.id)
        # |> Ash.read()
      end)
    end
  end
end
