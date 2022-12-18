defmodule TwitterApi.Content do
  alias TwitterApi.Content.Twit
  alias TwitterApi.Repo

  def list_twits do
    Repo.all(Twit)
  end

  def get_twit!(id), do: Repo.get!(Twit, id)

  def create_twit(attrs \\ %{}) do
    %Twit{}
    |> Twit.changeset(attrs)
    |> Repo.insert()
  end

  def update_twit(%Twit{} = twit, attrs) do
    twit
    |> Twit.changeset(attrs)
    |> Repo.update()
  end

  def delete_twit(%Twit{} = twit) do
    Repo.delete(twit)
  end

  def change_twit(%Twit{} = twit, attrs \\ %{}) do
    Twit.changeset(twit, attrs)
  end
end
