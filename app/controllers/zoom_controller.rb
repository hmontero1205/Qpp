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
  def show
    @api_key = ENV['ZOOM_API_KEY']
    @meeting_number = "94424410792"
    @password = "635627"
    if current_user && !current_user.name.blank?
      @username = current_user.name
    else
      @username = "marty"
    end
    @oh_id = params[:id]

    @siggy = Zoom::SignatureGenerator.new(@meeting_number).signature
    render layout: false
  end
end
