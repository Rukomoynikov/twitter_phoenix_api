defmodule TwitterApi.ContentTest do
  use TwitterApi.DataCase

  alias TwitterApi.Accounts
  alias TwitterApi.Content

  describe "twits" do
    alias TwitterApi.Content.Twit

    import TwitterApi.ContentFixtures

    @invalid_attrs %{content: nil}

    test "created twit has a connection with author" do
      {:ok, account} =
        Accounts.create_account(%{"email" => "email@rma.ru", "password" => "password"})

      assert {:ok, %Twit{} = twit} =
               Content.create_twit(%{content: "New content", account_id: account.id})
    end

    # test "list_twits/0 returns all twits" do
    #   twit = twit_fixture()
    #   assert Content.list_twits() == [twit]
    # end
    #
    # test "get_twit!/1 returns the twit with given id" do
    #   twit = twit_fixture()
    #   assert Content.get_twit!(twit.id) == twit
    # end
    #
    # test "create_twit/1 with valid data creates a twit" do
    #   valid_attrs = %{content: "some content"}
    #
    #   assert {:ok, %Twit{} = twit} = Content.create_twit(valid_attrs)
    #   assert twit.content == "some content"
    # end
    #
    # test "create_twit/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Content.create_twit(@invalid_attrs)
    # end
    #
    # test "update_twit/2 with valid data updates the twit" do
    #   twit = twit_fixture()
    #   update_attrs = %{content: "some updated content"}
    #
    #   assert {:ok, %Twit{} = twit} = Content.update_twit(twit, update_attrs)
    #   assert twit.content == "some updated content"
    # end
    #
    # test "update_twit/2 with invalid data returns error changeset" do
    #   twit = twit_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Content.update_twit(twit, @invalid_attrs)
    #   assert twit == Content.get_twit!(twit.id)
    # end
    #
    # test "delete_twit/1 deletes the twit" do
    #   twit = twit_fixture()
    #   assert {:ok, %Twit{}} = Content.delete_twit(twit)
    #   assert_raise Ecto.NoResultsError, fn -> Content.get_twit!(twit.id) end
    # end
    #
    # test "change_twit/1 returns a twit changeset" do
    #   twit = twit_fixture()
    #   assert %Ecto.Changeset{} = Content.change_twit(twit)
    # end
  end
end
