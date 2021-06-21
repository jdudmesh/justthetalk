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

import grails.converters.JSON

class ProxyFilters {

	def rabbitService

	def filters = {
		all(controller:'*', action:'*') {
			before = {

				flash.proto = "HTTP"
				def proto = request.getHeader("X-Forwarded-Proto")
				if(proto) {
					flash.proto = proto.toUpperCase()
				}

			}
			after = {

				def location = response.getHeader("Location")
				if(location) {
					def proto = request.getHeader("X-Forwarded-Proto")
					if(proto == "https") {
						def uri = location.replaceFirst(/^(?i)http\:/, "https:")
					}
				}

				def geo = request.getHeader("X-Geo-Location")
				def lat = request.getHeader("X-Geo-Lat")
				def lon = request.getHeader("X-Geo-Lon")

				def message = [
					location: geo,
					lat: lat,
					lon: lon
				]

				rabbitService.send(new JSON(message).toString(), "ntt.hit")

			}
		}
	}
}
