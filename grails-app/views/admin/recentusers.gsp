<%-- /*
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
 */ --%>

<%@ page contentType="text/html;charset=ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"></meta>
	<title>Recent Signups</title>
</head>
<body>

	<h4>Recent Signups</h4>
	<div class="col-sm-6 col-sm-offset-3">
		<ul class="list-unstyled">
			<g:each in="${users}" var="user">
				<li class="discussionlistitem">
					<div class="col-sm-3" style="display:inline;"><g:formatDate format="dd/MM/yyyy" date="${user.createdDate}"/></div>
					<g:link controller='home' action='user' id='${user.username}'>${user.username}</g:link>
				</li>
			</g:each>
		</ul>
	</div>

</body>
