defmodule ElixirBlogWeb.CommentControllerTest do
  use ElixirBlogWeb.ConnCase

  alias ElixirBlog.Comments

  @create_attrs %{article_id: 42, body: "some body", title: "some title", user_id: 42}
  @update_attrs %{article_id: 43, body: "some updated body", title: "some updated title", user_id: 43}
  @invalid_attrs %{article_id: nil, body: nil, title: nil, user_id: nil}

  def fixture(:comment) do
    {:ok, comment} = Comments.create_comment(@create_attrs)
    comment
  end

  describe "index" do
    test "lists all comments", %{conn: conn} do
      conn = get conn, comment_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Comments"
    end
  end

  describe "new comment" do
    test "renders form", %{conn: conn} do
      conn = get conn, comment_path(conn, :new)
      assert html_response(conn, 200) =~ "New Comment"
    end
  end

  describe "create comment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, comment_path(conn, :create), comment: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == comment_path(conn, :show, id)

      conn = get conn, comment_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Comment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, comment_path(conn, :create), comment: @invalid_attrs
      assert html_response(conn, 200) =~ "New Comment"
    end
  end

  describe "edit comment" do
    setup [:create_comment]

    test "renders form for editing chosen comment", %{conn: conn, comment: comment} do
      conn = get conn, comment_path(conn, :edit, comment)
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "update comment" do
    setup [:create_comment]

    test "redirects when data is valid", %{conn: conn, comment: comment} do
      conn = put conn, comment_path(conn, :update, comment), comment: @update_attrs
      assert redirected_to(conn) == comment_path(conn, :show, comment)

      conn = get conn, comment_path(conn, :show, comment)
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, comment: comment} do
      conn = put conn, comment_path(conn, :update, comment), comment: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "delete comment" do
    setup [:create_comment]

    test "deletes chosen comment", %{conn: conn, comment: comment} do
      conn = delete conn, comment_path(conn, :delete, comment)
      assert redirected_to(conn) == comment_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, comment_path(conn, :show, comment)
      end
    end
  end

  defp create_comment(_) do
    comment = fixture(:comment)
    {:ok, comment: comment}
  end
end
