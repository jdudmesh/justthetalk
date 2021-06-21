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

package com.notthetalk

import org.codehaus.groovy.grails.plugins.springsecurity.AjaxAwareAuthenticationSuccessHandler

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;

class CustomAuthenticationSuccessHandler extends AjaxAwareAuthenticationSuccessHandler {

	def springSecurityService
	def userService

	@Override
	public void onAuthenticationSuccess(final HttpServletRequest request, final HttpServletResponse response, final Authentication authentication) throws ServletException, IOException {

		// create a login history record
		def user = springSecurityService.currentUser
		def ip = request.getHeader("x-forwarded-for") ?: request.getRemoteAddr()
		def geoLocation = request.getHeader("X-Geo-Location")
		userService.createUserHistory(user, ip, geoLocation)


		// redirect to the correct location
		def location = request.contextPath + '/'

		def proto = request.getParameter("proto")
		def host = request.getParameter("host")
		if(proto && proto == "HTTPS") {
			if(!host) {
				host = "justthetalk.com"
			}
			location = "https://${host}" + location
		}
		response.sendRedirect(location)

	}
}
