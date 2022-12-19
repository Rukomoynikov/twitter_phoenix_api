defmodule TwitterApiWeb.TwitController do
  use TwitterApiWeb, :controller

  alias TwitterApi.Content
  alias TwitterApi.Content.Twit

  action_fallback TwitterApiWeb.FallbackController

  def create(%{assigns: %{current_user: current_user}} = conn, %{"twit" => twit_params}) do
    twit_params = Map.put(twit_params, "account_id", current_user.id)

    with {:ok, %Twit{} = twit} <- Content.create_twit(twit_params) do
      conn
      |> put_status(:created)
      |> render("show.json", twit: twit)
    end
  end

  def show(conn, %{"id" => id}) do
    twit = Content.get_twit!(id)
    render(conn, "show.json", twit: twit)
  end

  def update(conn, %{"id" => id, "twit" => twit_params}) do
    twit = Content.get_twit!(id)

    with {:ok, %Twit{} = twit} <- Content.update_twit(twit, twit_params) do
      render(conn, "show.json", twit: twit)
    end
  end

  def delete(%{assigns: %{current_user: current_user}} = conn, %{"id" => id}) do
    twit = Content.get_twit!(id)

    cond do
      twit.account_id == current_user.id ->
        with {:ok, %Twit{}} <- Content.delete_twit(twit) do
          send_resp(conn, :no_content, "")
        end

      true ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, Jason.encode!("Not Authorized"))
        |> halt()
    end
  end
end
