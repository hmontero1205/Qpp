# frozen_string_literal: true

require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end


RSpec.describe OfficeHoursController, :type => :controller do
  describe "Basic Routes" do
    it 'renders the home page' do
      get :index
      expect(response).to render_template("office_hours/index")
    end

    it 'renders the new page' do
      get :new
      expect(response).to render_template("office_hours/new")
    end

    it 'renders the show page' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_oh = OfficeHour.create!(host: "Hans", class_name: "PLT", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", zoom_info: "zoooom", meeting_id: "1", meeting_passcode: "1", "user_id": test_user.id)
      get :show, params: { id: test_oh.id }
      expect(response).to render_template("office_hours/show")
    end

    it 'creates a new OH' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      allow(controller).to receive(:current_user).and_return(test_user) 
      post :create, params: {"office_hour": {host: "Hans", class_name: "OS", starts_on: "2021-03-14 10:50 PM", ends_on: "2021-03-14 11:40 PM", meeting_id: "1", meeting_passcode: "1", zoom_info: "zoooom"}}
      expect(response).to redirect_to(:action => :index)
      expect(OfficeHour.where(class_name: "OS").length).to eq 1
    end

   it 'doesnt create a new bad OH' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      allow(controller).to receive(:current_user).and_return(test_user) 
      post :create, params: {"office_hour": {host: " ", class_name: "OS", starts_on: "yyyy-mm-dd 10:50 PM", ends_on: "2021-03-14 11:40 PM", meeting_id: "1", meeting_passcode: "1", zoom_info: "zoooom"}}
      expect(response).to render_template("office_hours/new")
      expect(OfficeHour.all.length).to eq 0
      expect(flash[:notice]).to match(/Host can't be blank/)
    end

    it 'deletes an OH, correct user' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      test_oh = OfficeHour.create!(host: "Hans", class_name: "PLT", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", zoom_info: "zoooom", meeting_id: "1", meeting_passcode: "1", "user_id": test_user.id)
      allow(controller).to receive(:current_user).and_return(test_user) 
      post :destroy, params: { id: test_oh.id }
      expect(response).to redirect_to(:action => :index)
      expect(OfficeHour.all.length).to eq 0
    end

  it 'deletes an OH, wrong user' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      test_user2 = User.new(email: "hans2@mail", name: "Hans2", surname: "Montero2")
      test_user2.save!(validate: false)
      test_oh = OfficeHour.create!(host: "Hans", class_name: "PLT", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", zoom_info: "zoooom", meeting_id: "1", meeting_passcode: "1", "user_id": test_user.id)
      allow(controller).to receive(:current_user).and_return(test_user2) 
      post :destroy, params: { id: test_oh.id }
      expect(response).to redirect_to(:action => :index)
      expect(flash[:notice]).to match(/You cannot delete this OH since you did not create it./)
      expect(OfficeHour.all.length).to eq 1
    end
  end

  it 'renders the edit page, correct user' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      test_oh = OfficeHour.create!(host: "Hans", class_name: "PLT", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", zoom_info: "zoooom", meeting_id: "1", meeting_passcode: "1", "user_id": test_user.id)

      allow(controller).to receive(:current_user).and_return(test_user) 
      get :edit, params: { id: test_oh.id }
      expect(response).to render_template("office_hours/edit")
  end

  it 'renders the edit page, wrong user' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      test_user2 = User.new(email: "hans2@mail", name: "Hans2", surname: "Montero2")
      test_user2.save!(validate: false)
      test_oh = OfficeHour.create!(host: "Hans", class_name: "PLT", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", zoom_info: "zoooom", meeting_id: "1", meeting_passcode: "1", "user_id": test_user.id)

      allow(controller).to receive(:current_user).and_return(test_user2) 
      get :edit, params: { id: test_oh.id }
      expect(response).to redirect_to(:action => :index)
      expect(flash[:notice]).to match(/You cannot edit this OH since you did not create it./)
  end

  it 'updates the OH, correct user' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      test_oh = OfficeHour.create!(host: "Hans", class_name: "PLT", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", zoom_info: "zoooom", meeting_id: "1", meeting_passcode: "1", "user_id": test_user.id)

      allow(controller).to receive(:current_user).and_return(test_user) 
      post :update, params: { id: test_oh.id, "office_hour": {host: "Hans", class_name: "OS", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", meeting_id: "1", meeting_passcode: "1", zoom_info: "zoooom"} }
      expect(response).to redirect_to(:action => :show, :id => test_oh.id)
      expect(OfficeHour.find(test_oh.id).class_name).to eq "OS"
  end

  it 'updates the OH, wrong user' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      test_user2 = User.new(email: "hans2@mail", name: "Hans2", surname: "Montero2")
      test_user2.save!(validate: false)
      test_oh = OfficeHour.create!(host: "Hans", class_name: "PLT", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", zoom_info: "zoooom", meeting_id: "1", meeting_passcode: "1", "user_id": test_user.id)

      allow(controller).to receive(:current_user).and_return(test_user2) 
      post :update, params: { id: test_oh.id, "office_hour": {host: "Hans", class_name: "OS", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", meeting_id: "1", meeting_passcode: "1", zoom_info: "zoooom"} }
      expect(flash[:notice]).to match(/You cannot edit this OH since you did not create it./)
      expect(response).to redirect_to(:action => :index)
      expect(OfficeHour.find(test_oh.id).class_name).to eq "PLT"
  end

  it 'activates an OH' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      test_oh = OfficeHour.create!(host: "Hans", class_name: "PLT", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 11:40 PM", zoom_info: "zoooom", meeting_id: "1", meeting_passcode: "1", "user_id": test_user.id)

      expect(test_oh.active).to eq false
      allow(controller).to receive(:current_user).and_return(test_user) 
      post :activate, params: {id: test_oh.id, format: :js}

      expect(OfficeHour.find(test_oh.id).active).to eq true
  end

  it 'deactivates an OH' do
      test_user = User.new(email: "hans@mail", name: "Hans", surname: "Montero")
      test_user.save!(validate: false)
      test_oh = OfficeHour.create!(host: "Hans", class_name: "PLT", starts_on: "2021-03-14 9:40 PM", ends_on: "2021-03-14 9:40 PM", zoom_info: "zoooom", meeting_id: "1", meeting_passcode: "1", "user_id": test_user.id)
      QueueEntry.create!(student: "Matt", office_hour_id: test_oh.id)

      expect(test_oh.active).to eq false
      allow(controller).to receive(:current_user).and_return(test_user) 
      post :activate, params: {id: test_oh.id, format: :js}

      expect(OfficeHour.find(test_oh.id).active).to eq true

      post :deactivate, params: {id: test_oh.id, format: :js}
      expect(OfficeHour.find(test_oh.id).active).to eq false
      expect(QueueEntry.where(office_hour_id: test_oh.id).length).to eq 0
  end
end
