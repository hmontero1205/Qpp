require "base64"
require "openssl"

module Zoom
  class SignatureGenerator
    def initialize(meeting_number)
      @meeting_number = meeting_number
      @api_key = ENV['ZOOM_API_KEY']
      @api_secret = ENV['ZOOM_API_SECRET']
      @role = "0" # for attendee
    end

    def encode64s(value)
      Base64.strict_encode64(value)
    end

    def signature
      ts = (Time.now.to_f * 1000).round(0) - 30000
      msg = encode64s(@api_key + @meeting_number + ts.to_s + @role)

      hash = encode64s(OpenSSL::HMAC.digest("sha256", @api_secret, msg))
      encode64s("#{@api_key}.#{@meeting_number}.#{ts.to_s}.#{@role}.#{hash}")
    end
  end
end

class ZoomController < ApplicationController
  # TODO:
  # - Meeting host will join as a regular old user
  # - Users have NO CHOICE! They must join the meeting and will
  #   be forced to rejoin if they leave
  # - The CSS for our OH page is bad
  #
  # - Add an intersticial page where the user can enter their name and choose to join the meeting
  # - in office_hours#show don't render the zoom meeting if no meeting ID is provided
  # - confirm that everything works properly if there's no meeting passcode
  # - Don't load the zoom meeting for inactive OH
  #
  def show
    @oh_id = params[:id]
    unless @oh_id != nil
      raise ActionController::RoutingError.new("Missing Office Hour ID!")
    end
    @oh = OfficeHour.find(@oh_id)
    @api_key = ENV['ZOOM_API_KEY']
    @meeting_number = @oh.meeting_id
    @password = @oh.meeting_passcode
    if current_user
      @display_name = current_user.name
    else
      @display_name = session[:displayName]
    end

    @siggy = Zoom::SignatureGenerator.new(@meeting_number).signature
    render layout: false
  end

  def join
    @oh_id = params[:id]
    render layout: false
  end
end
