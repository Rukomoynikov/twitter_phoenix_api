defmodule TwitterApiWeb.AccountControllerTest do
  use TwitterApiWeb.ConnCase

  import TwitterApi.AccountsFixtures

  alias TwitterApi.Accounts.Account

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "sign up" do
    test "renders account when data is valid", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.account_path(conn, :sign_up,
            account: %{email: "email@email.com", password: "Mld1"}
          )
        )

      assert %{"email" => email, "token" => token} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :sign_up), account: %{email: "1111"})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end
end
