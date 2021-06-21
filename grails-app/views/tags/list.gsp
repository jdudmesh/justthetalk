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

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<title>JUSTtheTalk - ${tag}</title>
</head>
<body>

   	<div class="col-sm-6 offset-sm-3">

		<h4>Discussions for ${tag}</h4>

    	<ul class="list-unstyled">
			<g:each var="d" in="${discussions}">
				<g:discussionTitle header="${d}" max="50" showfolders="${nav.showfolders}" />
			</g:each>
		</ul>

   	</div>

</body>
</html>