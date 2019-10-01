class HomeController < ApplicationController
  def index
    render status: 200, json: { message: 'Hello Rails' }
  end
end
