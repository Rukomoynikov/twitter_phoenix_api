defmodule TwitterApi.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :email, :string
    field :hashed_password, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    IO.inspect(Map.get(attrs, "email"))

    account
    |> cast(%{email: Map.get(attrs, "email"), hashed_password: Map.get(attrs, "password")}, [
      :email,
      :hashed_password
    ])
    |> validate_required([:email, :hashed_password])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/,
      message: "please provide correct email address"
    )
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email)
    |> put_password()
  end

  defp put_password(
         %Ecto.Changeset{valid?: true, changes: %{hashed_password: hashed_password}} = changeset
       ) do
    change(changeset, hashed_password: Bcrypt.hash_pwd_salt(hashed_password))
  end

  defp put_password(changeset), do: changeset
end
