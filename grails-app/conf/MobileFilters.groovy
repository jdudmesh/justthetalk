/*
 * This file is part of the NOTtheTalk distribution (https://github.com/jdudmesh/notthetalk).
 * Copyright (c) 2011-2021 John Dudmesh.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

class MobileFilters {

	def deviceResolver

	def filters = {
		all(controller:'*', action:'*') {
			before = {

				def useNormalViewCookie = request.cookies.find { it.name == 'use_normal_view' }
				def device = deviceResolver.resolveDevice(request)

				def useNormalView = "no"
				if(useNormalViewCookie != null) {
					useNormalView = useNormalViewCookie.getValue()
				}

				flash.useNormalView = useNormalView
				if(device.isMobile()) {
					flash.device = "mobile"
				}
				else if(device.isTablet()) {
					flash.device = "tablet"
				}
				else {
					flash.device = "normal"
				}

			}
			after = { Map model ->

			}
		}
	}
}
