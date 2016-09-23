# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  creator_id     :integer
#  action         :string
#  eventable_id   :integer
#  eventable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ownerable_id   :integer
#  ownerable_type :string
#  team_id        :integer
#
# Indexes
#
#  index_events_on_eventable_id_and_eventable_type  (eventable_id,eventable_type)
#  index_events_on_ownerable_id_and_ownerable_type  (ownerable_id,ownerable_type)
#

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET index" do

    let(:user) { FactoryGirl.create(:user) }
    let(:team) { FactoryGirl.create(:team) }

    context "when user login " do

      before do
        sign_in user
        get :index, params:{team_id: team.id}
      end

      it "assigns a team" do
        expect(assigns[:team]).to eq(team)
      end

      it "assigns project_permissions" do
        expect(assigns[:project_permissions]).to eq(user.project_permissions.select("project_id"))
      end

      it "assigns events" do
        expect(assigns[:events]).to eq(team.events.where( ownerable_id: user.project_permissions.select("project_id") ).recent)
      end

      it "assigns group_events" do
        expect(assigns[:group_events]).to eq(team.events.where( ownerable_id: user.project_permissions.select("project_id") ).recent.group_by{|e| e.created_at.to_date})
      end

      it "assigns events_size" do
        expect(assigns[:events_size]).to eq(team.events.where( ownerable_id: user.project_permissions.select("project_id") ).recent.group_by{|e| e.created_at.to_date}.size)
      end

      it "render template" do
        expect(response).to render_template("index")
      end
    end

    context "when user not login" do
      it "redirect_to new_user_session_path" do
        get :index, params:{team_id: team.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

  end
end
