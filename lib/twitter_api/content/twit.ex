defmodule TwitterApi.Content.Twit do
  use Ecto.Schema
  import Ecto.Changeset

  alias TwitterApi.Accounts.Account

  schema "twits" do
    field :content, :string
    belongs_to :account, Account

    timestamps()
  end

  def changeset(twit, attrs) do
    twit
    |> cast(attrs, [:content, :account_id])
    |> validate_required([:content, :account_id])
  end
end
