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

class Api::V1::TenantsController < ApplicationController
  before_action :doorkeeper_authorize!

  # GET /tenants
  def index
    tenants = RailsLti2Provider::Tenant.all
    if tenants
      render :json => tenants
    else
      render :json => '{}', :status => :not_found
    end
  end

  # GET /tenant/:uid
  def show
    tenant = RailsLti2Provider::Tenant.find_by(uid: params['uid'])
    if tenant
      render :json => tenant.settings.to_json
    else
      render :json => '{}', :status => :not_found
    end
  end
end
