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

  def render_yaml
    send_file(
      "#{ENV['OPENSHIFT_DATA_DIR']}/dumps/data.yml",
      filename: "test.yml",
      type: "text/plain"
    )
  end

  def list_backups
  end
end
