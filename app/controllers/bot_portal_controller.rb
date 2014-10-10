class BotPortalController < ApplicationController
  def bot_checkpoint
    #Get the time
    today = Time.now
    scrum_time = today.strftime("%Y-%m-%d")

    @unreported = []

    #Pull down all users, and initially populate the list with everone.
    #The Reported ones will be poped out of the array later.
    @users = User.select(:id)
    @users.each do |user|
      @unreported << user
    end

    #Find users who have not filed a bug report
    #if not, pop off of the array
    @reported = DailyScrum.select("scrum_user").where("scrum_date"=>scrum_time)

    @reported.each do |report|
      if @unreported.include? report
          @unreported.delete(report)
      end
    end
  end
end
