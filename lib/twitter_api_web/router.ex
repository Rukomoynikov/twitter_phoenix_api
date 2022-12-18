defmodule TwitterApiWeb.Router do
  alias TwitterApiWeb.AccountController
  alias TwitterApiWeb.TwitController
  use TwitterApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug TwitterApiWeb.Authenticate
  end

  scope "/api", TwitterApiWeb do
    pipe_through :api
  end

  scope "/api/accounts" do
    pipe_through([:api])

    post("sign_up", AccountController, :sign_up)
    get("sign_in", AccountController, :sign_in)
  end

  scope "/api/twits" do
    pipe_through [:api, :authenticated]

    post("/", TwitController, :create)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TwitterApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
