defmodule TwitterApiWeb.Authenticate do
  import Plug.Conn
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <-
           get_req_header(conn, "authorization"),
         {:ok, data} <- TwitterApiWeb.Auth.Guardian.verify_token(token),
         {:ok, user} <- TwitterApiWeb.Auth.Guardian.resource_from_claims(data) do
      conn
      |> assign(:current_user, user)
    else
      error ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, Jason.encode!("Not Authorized"))
        |> halt()
    end
  end
end
