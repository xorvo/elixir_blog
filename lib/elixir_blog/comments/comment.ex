defmodule ElixirBlog.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirBlog.Comments.Comment


  schema "comments" do
    field :body, :string
    field :title, :string
    field :user_id, :integer
    belongs_to :article, ElixirBlog.Posts.Article

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:title, :body, :article_id, :user_id])
    |> validate_required([:title, :body, :article_id])
  end
end
