class SubscriptionsController < ApplicationController
  def new
    plan = Plan.find(params[:plan_id])
  end
  
end