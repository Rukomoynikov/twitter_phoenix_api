defmodule TwitterApi.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TwitterApi.Content` context.
  """

  @doc """
  Generate a twit.
  """
  def twit_fixture(attrs \\ %{}) do
    {:ok, twit} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> TwitterApi.Content.create_twit()

    twit
  end
end
