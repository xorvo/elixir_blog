defmodule ElixirBlogWeb.CommentController do
  use ElixirBlogWeb, :controller

  alias ElixirBlog.Comments
  alias ElixirBlog.Comments.Comment

  def action(conn, _) do
    article = ElixirBlog.Posts.get_article!(conn.params["article_id"])
    args = [conn, conn.params, article]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, article) do
    comments = Comments.list_comments(article)
    render(conn, "index.html", comments: comments, article: article)
  end

  def new(conn, _params, article) do
    changeset =
    %Comment{article_id: article.id}
    |> Comments.change_comment
    render(conn, "new.html", changeset: changeset, article: article)
  end

  def create(conn, %{"comment" => comment_params}, article) do
    comment_params =
      comment_params
      |> Map.put("article_id", article.id)

    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: article_comment_path(conn, :show, article, comment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, article: article)
    end
  end

  def show(conn, %{"id" => id}, article) do
    comment = Comments.get_comment!(article, id)
    render(conn, "show.html", comment: comment, article: article)
  end

  def edit(conn, %{"id" => id}, article) do
    comment = Comments.get_comment!(article, id)
    changeset = Comments.change_comment(article, comment)
    render(conn, "edit.html", comment: comment, article: article, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}, article) do
    comment = Comments.get_comment!(article, id)

    case Comments.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: article_comment_path(conn, :show, article, comment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, article: article, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, article) do
    comment = Comments.get_comment!(article, id)
    {:ok, _comment} = Comments.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: article_path(conn, :show, article))
  end
end
