defmodule TwitterApiWeb.AccountView do
  use TwitterApiWeb, :view
  alias TwitterApiWeb.AccountView

  def render("sign_up.json", %{account: %{email: email}, token: token}) do
    %{data: %{email: email, token: token}}
  end
end
