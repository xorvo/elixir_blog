defmodule ElixirBlog.CommentsTest do
  use ElixirBlog.DataCase

  alias ElixirBlog.Comments

  describe "comments" do
    alias ElixirBlog.Comments.Comment

    @valid_attrs %{article_id: 42, body: "some body", title: "some title", user_id: 42}
    @update_attrs %{article_id: 43, body: "some updated body", title: "some updated title", user_id: 43}
    @invalid_attrs %{article_id: nil, body: nil, title: nil, user_id: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Comments.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Comments.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Comments.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Comments.create_comment(@valid_attrs)
      assert comment.article_id == 42
      assert comment.body == "some body"
      assert comment.title == "some title"
      assert comment.user_id == 42
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comments.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Comments.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.article_id == 43
      assert comment.body == "some updated body"
      assert comment.title == "some updated title"
      assert comment.user_id == 43
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Comments.update_comment(comment, @invalid_attrs)
      assert comment == Comments.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Comments.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Comments.change_comment(comment)
    end
  end
end
