class YamlDbBackupController < ApplicationController
  before_filter :authenticate

  #Heavily borrowed from:
  #https://coderwall.com/p/9nib6w/rails-devise-and-basic-http-auth-oh-my
  def authenticate
    authenticate_or_request_with_http_basic do |email, password|
      user = User.where(email: email).first
      !user.nil? && user.valid_password?(password)
    end
    warden.custom_failure! if performed?
  end

  #Display the yaml file to the user, after auth
  def render_yaml
    #The dbdump_yaml folder below is created by the daily cron job
    #found in .openshift/cron/daily/dbdump. If not using openshift,
    #please change the below line  in lieu of 'OPENSHIFT_DATA_DIR/dbdump_yaml'
    latest_backup = Dir["#{ENV['OPENSHIFT_DATA_DIR']}/dbdump_yaml"].sort_by{ |f| File.mtime(f) }.last
    require 'pry-byebug'
    binding.pry
    send_file(
      "#{ENV['OPENSHIFT_DATA_DIR']}/dbdump_yaml/#{latest_backup}",
      filename: "dump.tar.bz2",
      type: "application/x-bzip2"
    )
  end

  #List all of the current backups
  def list_backups
    #Dir.glob('#{ENV['OPENSHIFT_DATA_DIR']}/dumps/**/*')
    #return array of files
    #filenames.sort_by {|filename| File.mtime(filename) }
  end
end
