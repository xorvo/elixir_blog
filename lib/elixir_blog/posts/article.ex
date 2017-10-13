defmodule ElixirBlog.Posts.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirBlog.Posts.Article


  schema "articles" do
    field :body, :string
    field :tags, {:array, :string}
    field :title, :string
    belongs_to :user, ElixirBlog.Accounts.User, foreign_key: :author_id
    has_many :comment, ElixirBlog.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(%Article{} = article, attrs) do
    article
    |> cast(attrs, [:title, :body, :author_id, :tags])
    |> validate_required([:title, :body])
  end
end
