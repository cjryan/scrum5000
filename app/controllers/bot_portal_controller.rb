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
      @unreported << user.id
    end

    #Find users who have not filed a bug report
    #if not, pop them off of the array
    @reported = DailyScrum.select("scrum_user").where("scrum_date"=>scrum_time)
    @reported.each do |report|
      if @unreported.include? report[:scrum_user]
        @unreported.delete(report[:scrum_user])
      end
    end

    #Send a JSON response with those that did not fill out a scrum
    laggards = {}
    @unreported.each do |laggard|
      User.find_by(:id=>laggard).email
      laggards[laggard.to_s] = User.find_by(:id=>laggard).email
    end
    @response = JSON.generate(laggards)
  end
end
