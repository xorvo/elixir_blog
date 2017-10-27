defmodule ElixirBlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirBlog.Accounts.User


  schema "users" do
    field :bio, :string
    field :display_name, :string
    field :password, :string
    field :password_hash, :string
    field :tags, {:array, :string}, default: []
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password, :display_name, :bio, :tags])
    |> validate_required([:username, :password_hash, :display_name, :bio, :tags])
  end
end
