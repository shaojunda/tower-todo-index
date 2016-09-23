require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET index" do

    

    context "when user login " do

      it "assigns a team" do
        user = FactoryGirl.create(:user)
        sign_in user
        team = FactoryGirl.create(:team)
        get :index, params:{team_id: team.id}
        expect(assigns[:team]).to eq(team)
      end

      it "assigns project_permissions" do
        user = FactoryGirl.create(:user)
        sign_in user
        team = FactoryGirl.create(:team)
        project = FactoryGirl.create(:project)
        get :index, params:{team_id: team.id}
        expect(assigns[:project_permissions]).to eq(user.project_permissions.select("project_id"))
      end

      it "assigns events" do
        user = FactoryGirl.create(:user)
        sign_in user
        team = FactoryGirl.create(:team)
        project = FactoryGirl.create(:project)

        get :index, params:{team_id: team.id}
        expect(assigns[:events]).to eq(team.events.where( ownerable_id: user.project_permissions.select("project_id") ).recent)

      end

      it "assigns group_events" do
        user = FactoryGirl.create(:user)
        sign_in user
        team = FactoryGirl.create(:team)
        project = FactoryGirl.create(:project)

        get :index, params:{team_id: team.id}

        expect(assigns[:group_events]).to eq(team.events.where( ownerable_id: user.project_permissions.select("project_id") ).recent.group_by{|e| e.created_at.to_date})

      end

      it "assigns events_size" do
        user = FactoryGirl.create(:user)
        sign_in user
        team = FactoryGirl.create(:team)
        project = FactoryGirl.create(:project)

        get :index, params:{team_id: team.id}

        expect(assigns[:events_size]).to eq(team.events.where( ownerable_id: user.project_permissions.select("project_id") ).recent.group_by{|e| e.created_at.to_date}.size)
      end

      it "render template" do
        user = FactoryGirl.create(:user)
        sign_in user
        team = FactoryGirl.create(:team)

        get :index, params:{team_id: team.id}
        expect(response).to render_template("index")
      end

    end

    context "when user not login" do
      it "redirect_to new_user_session_path" do
        user = FactoryGirl.create(:user)
        team = FactoryGirl.create(:team)
        get :index, params:{team_id: team.id}
        expect(response).to redirect_to new_user_session_path
      end
    end




    end
end
