class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!

  def generate_random_colors
    @random_colors ||= []
    10.times { @random_colors << format('%06x', (rand * 0xffffff)) }
    @random_colors
  end
end
