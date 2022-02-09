# frozen_string_literal: true

# override Devise parent controller
class TurboDeviseController < ApplicationController
  # override responder controller to respond to turbo_stream
  # so that, if there is validation error, we return 422 unprocessable_entity
  # which will allow turbo_stream to re-render the form with errors
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => e
      raise e if get?

      if has_errors? && default_action
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        redirect_to navigation_location
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end
