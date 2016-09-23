module TeamsHelper

  def render_team_name(team)
    link_to team.name, team_path(team)
  end

  def render_team_admin(team)
    link_to team.user.user_name, "#"
  end

  def render_created_at_for_team(team)
    team.created_at.strftime("%Y年%-m月%d日")
  end

end
