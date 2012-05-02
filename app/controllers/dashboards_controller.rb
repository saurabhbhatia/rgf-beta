class DashboardsController < ApplicationController

 def index
  @my_listings = Listing.where(:user_id => current_user).page(params[:page]).per(5)

  @event = Event.where(:user_id => current_user).page(params[:page]).per(5)

  @requested_event = MemberAttendingEventRegister.find_all_by_owner_id_and_state(current_user, 'request_sent')
  @group = Group.where(:user_id => current_user).page(params[:page]).per(5)
  @latest_event = Event.where(:created_at => 1.days.ago .. 1.days.from_now)
  @users = User.all  

 end

end
