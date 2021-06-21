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

<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"/>
	<title>Moderate Posts</title>
</head>
<body>

	<div class="col-sm-6 col-sm-offset-3">
		<h4>${pageTitle}</h4>
		<g:render template="/common/postlist" model="[posts:posts]" />
	</div>

</body>
</html>