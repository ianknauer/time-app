defmodule TimeApp.Tracker.SessionNotifier do
  use Ash.Notifier
  require IEx

  def notify(
        %Ash.Notifier.Notification{resource: resource, data: session, action: %{type: :create}} =
          params
      ) do
    Absinthe.Subscription.publish(
      TimeAppWeb.Endpoint,
      session,
      session_updated: "session"
    )
  end
end
