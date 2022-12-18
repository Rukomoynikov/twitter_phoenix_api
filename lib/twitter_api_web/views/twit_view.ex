defmodule TwitterApiWeb.TwitView do
  use TwitterApiWeb, :view
  alias TwitterApiWeb.TwitView

  def render("index.json", %{twits: twits}) do
    %{data: render_many(twits, TwitView, "twit.json")}
  end

  def render("show.json", %{twit: twit}) do
    %{data: render_one(twit, TwitView, "twit.json")}
  end

  def render("twit.json", %{twit: twit}) do
    %{
      id: twit.id,
      content: twit.content
    }
  end
end
