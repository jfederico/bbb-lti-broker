# frozen_string_literal: true

# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.

# Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).

# This program is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; either version 3.0 of the License, or (at your option) any later
# version.

# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.

require 'uri'
require 'net/http'
require 'ims/lti'
require 'securerandom'
require 'faraday'
require 'oauthenticator'
require 'oauth'
require 'yaml'
require 'addressable/uri'
require 'oauth/request_proxy/action_controller_request'

class ApplicationController < ActionController::Base
  include AppsValidator

  before_action :allow_iframe_requests

  protect_from_forgery with: :exception
  # CSRF stuff ^

  @build_number = Rails.configuration.build_number

  rescue_from ActionController::InvalidAuthenticityToken do |_exception|
    flash[:alert] = 'Can\'t verify CSRF token authenticity'
    @error = 'Third party cookies are disabled'
    redirect_to(errors_path(406))
  end

  private

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

  protected

  def print_parameters
    logger.debug(params.to_unsafe_h.sort.to_h.to_yaml)
  end
end
