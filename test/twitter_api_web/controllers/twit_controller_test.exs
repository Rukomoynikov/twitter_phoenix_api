defmodule TwitterApiWeb.TwitControllerTest do
  use TwitterApiWeb.ConnCase

  import TwitterApi.ContentFixtures

  alias TwitterApiWeb.Auth.Guardian
  alias TwitterApi.Accounts
  alias TwitterApi.Content.Twit

  @create_attrs %{
    content: "some content"
  }
  @update_attrs %{
    content: "some updated content"
  }
  @invalid_attrs %{content: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create twit" do
    test "when authorized", %{conn: conn} do
      {:ok, account} = Accounts.create_account(%{"email" => "1@1.ru", "password" => "lkdjagag"})
      {:ok, account, token} = Guardian.create_token(account)
      conn = put_req_header(conn, "authorization", "Bearer " <> token)
      conn = post(conn, Routes.twit_path(conn, :create), twit: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end
  end

  # describe "index" do
  #   test "lists all twits by one user", %{conn: conn} do
  #     account = Accounts.create_account(email: "1@1.ru", password: "lkdjagag")
  #     {:ok, account, token} = Guardian.create_token(account)
  #
  #     conn = get(conn, Routes.twit_path(conn, :index))
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end
  #
  # describe "create twit" do
  #   test "renders twit when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.twit_path(conn, :create), twit: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]
  #
  #     conn = get(conn, Routes.twit_path(conn, :show, id))
  #
  #     assert %{
  #              "id" => ^id,
  #              "content" => "some content"
  #            } = json_response(conn, 200)["data"]
  #   end
  #
  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.twit_path(conn, :create), twit: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update twit" do
  #   setup [:create_twit]
  #
  #   test "renders twit when data is valid", %{conn: conn, twit: %Twit{id: id} = twit} do
  #     conn = put(conn, Routes.twit_path(conn, :update, twit), twit: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]
  #
  #     conn = get(conn, Routes.twit_path(conn, :show, id))
  #
  #     assert %{
  #              "id" => ^id,
  #              "content" => "some updated content"
  #            } = json_response(conn, 200)["data"]
  #   end
  #
  #   test "renders errors when data is invalid", %{conn: conn, twit: twit} do
  #     conn = put(conn, Routes.twit_path(conn, :update, twit), twit: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end
  #
  # describe "delete twit" do
  #   setup [:create_twit]
  #
  #   test "deletes chosen twit", %{conn: conn, twit: twit} do
  #     conn = delete(conn, Routes.twit_path(conn, :delete, twit))
  #     assert response(conn, 204)
  #
  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.twit_path(conn, :show, twit))
  #     end
  #   end
  # end
  #
  defp create_twit(_) do
    twit = twit_fixture()
    %{twit: twit}
  end
end
