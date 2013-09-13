class Admin::AdminController < ApplicationController
  def index
  	@users = (current_user.blank? ? User.all : User.find(:all, :conditions => ["id != ?", current_user.id]))
  	@latest_comments = Comment.latest_comment
  end

  def plans
  	@plans = BraintreeRails::Plan.all
  end
end
