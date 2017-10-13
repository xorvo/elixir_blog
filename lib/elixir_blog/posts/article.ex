defmodule ElixirBlog.Posts.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirBlog.Posts.Article


  schema "articles" do
    field :author_id, :integer
    field :body, :string
    field :tags, {:array, :string}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Article{} = article, attrs) do
    article
    |> cast(attrs, [:title, :body, :author_id, :tags])
    |> validate_required([:title, :body, :author_id, :tags])
  end
end
