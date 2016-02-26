class YamlDbBackupController < ApplicationController
  before_filter :authenticate_user!

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
