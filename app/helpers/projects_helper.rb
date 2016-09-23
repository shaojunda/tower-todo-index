module ProjectsHelper

  def render_project_name(project)
    link_to project.name, team_project_path(project.team, project)
  end

  def render_created_at_for_project(project)
    project.created_at.strftime("%Y年%-m月%d日")
  end
end
