class StaticPagesController < ApplicationController
  def home
    properties = signed_in? ? {'distinct_id' => current_user.id} : {}
  	Mixpanel.simple_track('Visit home page', properties)

    @latest_members = Parent.order("created_at").limit(5)
  end
end
