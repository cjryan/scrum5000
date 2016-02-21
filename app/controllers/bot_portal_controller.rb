class BotPortalController < ApplicationController
  #This line bypasses CSRF token authenticity checks for the bot_filed_scrum
  skip_before_filter :verify_authenticity_token, :only => [:bot_filed_scrum]

  def bot_checkpoint
    #Get the time
    today = Time.now
    scrum_time = today.strftime("%Y-%m-%d")

    @unreported = []

    #Pull down all users, and initially populate the list with everone.
    #The Reported ones will be poped out of the array later.
    @users = User.select(:id).where("is_active"=>"true")
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
    @laggards = {}
    @unreported.each do |laggard|
      irc_nick = User.find_by(:id=>laggard).user_irc_nick
      tz = User.find_by(:id=>laggard).user_tz
      @laggards[laggard.to_s] = [irc_nick, tz]
    end
    @response = JSON.generate(@laggards)
  end

  def bot_filed_scrum
    #The params variable below are the values that comes in from the route.
    #Strong Parameters are used in the bot_params.permit method, new in Rails 4.
    #This whitelists the acceptable parameters to be passed to the model.

    bot_params = params

    #Catch any errors to report to the bot
    @errors = []

    #The DailyScrum model needs a sprint_id to commit; therefore
    #get the sprint_id.
    #Did the user supply a sprint number? Otherwise use the current one.
    if bot_params.key? "sprint_number"
      begin
        bot_params["sprint_id"] = Sprint.find_by(sprint_number: params["sprint_number"]).id
      rescue
        @errors << "Unable to find sprint."
      end
    else
      bot_params["sprint_id"] = Sprint.last.id
    end

    #Similarly for user; get the id.
    if bot_params.key? "scrum_user"
      #Use fuzzy matching to check for a similar nick,
      #in case the user changed their nick to _afk, _mtg, etc.
      user_query_result = User.select("user_irc_nick").where("is_active"=>"t")
      user_list = []
      user_query_result.each{|u| user_list << u.user_irc_nick}
      fuzz = FuzzyMatch.new(user_list)
      fuzz_find = fuzz.find(bot_params["scrum_user"])
      begin
        bot_params["scrum_user"] = User.find_by(user_irc_nick: fuzz_find).id
      rescue
        @errors << "Unable to find user."
      end
    end

    #Get today's date in the user's TZ- pick today if not specified
    #TODO: verify date is a valid date, see:
    #https://github.com/adzap/validates_timeliness
    if not bot_params.key? "scrum_date"
      begin
        tz = User.find_by(:id=>bot_params["scrum_user"]).user_tz
        user_zone = ActiveSupport::TimeZone[tz]
        user_zone_time = user_zone.at(Time.now).strftime("%Y-%m-%d")
        bot_params["scrum_date"] = user_zone_time
      rescue
        @errors << "Unable to locate user timezone."
      end
    end

    #Remove the sprint_number param as it's no longer necessary; the DailyScrum
    #model doesn't have a sprint_number field, only sprint_id, which we generate
    #above.
    bot_params = bot_params.except("sprint_number")

    @query_result = DailyScrum.create(bot_params.permit(:scrum_date, :sprint_id, :scrum_yesterday, :scrum_today, :scrum_blockers, :scrum_user))

    #Send a response back to the bot, either the errors or a success message
    if not @query_result.errors.full_messages.empty?
      @query_result.errors.full_messages.each do |err|
        @errors << err
      end
      respond_to do |format|
        format.json { render :text => @errors }
      end
    else
      respond_to do |format|
        format.json { render :text => "Scrum successfully saved." }
      end
    end
  end
end
