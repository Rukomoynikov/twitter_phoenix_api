defmodule TwitterApiWeb.AccountController do
  use TwitterApiWeb, :controller
  alias TwitterApiWeb.Auth.Guardian

  alias TwitterApi.Accounts
  alias TwitterApi.Accounts.Account

  action_fallback TwitterApiWeb.FallbackController

  def sign_up(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, _, token} <- Guardian.create_token(account) do
      conn
      |> put_status(:created)
      |> render("sign_up.json", account: account, token: token)
    end
  end

  def sign_in(conn, %{email: email, password: password}) do
    with {:ok, account, token} <- Guardian.authenticate(email, password) do
      conn
      |> render("sign_in.json", token: token, account: account)
    end
  end
end
