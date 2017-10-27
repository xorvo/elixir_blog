defmodule ElixirBlog.Repo.Migrations.ModifyUserRelation do
  use Ecto.Migration

  def change do
    alter table("users") do
      modify :username, :string, unique: true, null: false
      add :password_hash, :string, null: false, default: ""
    end
  end
end
