class StaticPagesController < ApplicationController
  def home
  	Mixpanel.simple_track('Visit home page')

    @latest_members = Parent.order("created_at").limit(5)
  end

  def about
    Mixpanel.simple_track('Visit about page')
  end

  def legal
    Mixpanel.simple_track('Visit legal page')
  end

  def partners
    Mixpanel.simple_track('Visit partners page')
  end
end
