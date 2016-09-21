module CommentsHelper

  def render_comment_content(comment)
    simple_format(comment.content)
  end

  def render_coment_creator(comment)
    link_to comment.user.user_name, "#"
  end

  def render_created_at_for_comment(comment)
    comment.created_at.strftime("%Y-%m-%d %H:%M")
  end


end
