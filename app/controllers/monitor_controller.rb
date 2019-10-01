class MonitorController < ApplicationController
  def ping
    render status: 200, json: {}
  end
end
