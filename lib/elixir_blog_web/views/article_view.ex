defmodule ElixirBlogWeb.ArticleView do
  use ElixirBlogWeb, :view
  alias ElixirBlog.{Comments, Comments.Comment}

  def comment_changeset(article) do
    %Comment{article_id: article.id}
    |> Comments.change_comment
  end
end
