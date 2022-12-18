defmodule TwitterApi.Repo.Migrations.CreateTwits do
  use Ecto.Migration

  def change do
    create table(:twits) do
      add :content, :string
      add :account_id, references(:accounts, on_delete: :delete_all)

      timestamps()
    end

    create index(:twits, [:account_id])
  end
end
