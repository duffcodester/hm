class StaticPagesController < ApplicationController
  def home
    @latest_members = Parent.order("created_at").limit(5)
  end
end
