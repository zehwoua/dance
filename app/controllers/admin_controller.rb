class AdminController < ApplicationController
  def index
  	@users = (current_user.blank? ? User.all : User.find(:all, :conditions => ["id != ?", current_user.id]))
  end

  def plans
  	@plans = BraintreeRails::Plan.all
  end
end
