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
    #latest_backup = list_backups.last
    #add gzip support to shrink for transport and storage
    send_file(
      "#{ENV['OPENSHIFT_DATA_DIR']}/dumps/data.yml",
      filename: "test.yml",
      type: "text/plain"
    )
  end

  #List all of the current backups
  def list_backups
    Dir.glob('#{ENV['OPENSHIFT_DATA_DIR']}/dumps/**/*')
    #return array of files
    filenames.sort_by {|filename| File.mtime(filename) }
  end
end
