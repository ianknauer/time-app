defmodule TimeAppWeb.Router do
  use TimeAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TimeAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :graphql do
    plug CORSPlug
    plug AshGraphql.Plug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through [:graphql]

    forward "/gql", Absinthe.Plug,
      schema: Module.concat(["TimeApp.GraphqlSchema"]),
      socket: TimeAppWeb.SessionSocket

    forward "/playground", Absinthe.Plug.GraphiQL,
      schema: Module.concat(["TimeApp.GraphqlSchema"]),
      interface: :playground,
      socket: TimeAppWeb.SessionSocket
  end

  # Other scopes may use custom stacks.
  # scope "/api", TimeAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:time_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TimeAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
