class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def home
  end

  def about_us
  end

  def contact_us
  end

  def press
  end

  def blog
  end

  def faqs
  end

  def careers
  end

  def terms
  end

  def premium
  end
end
