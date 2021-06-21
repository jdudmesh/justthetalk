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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<title>JUSTtheTalk - ${headerText}</title>
</head>
<body>

   	<div id="folders" class="col-sm-3">
		<sec:ifLoggedIn>
	   		<div>
	   			<g:if test="${folder.type == 0}">
   					<g:link action="add" controller="discussion" id="${folder.id}">Start a discussion</g:link>
   				</g:if>
   			</div>
   		</sec:ifLoggedIn>
   		<div>&nbsp;</div>
	</div>

   	<div class="col-sm-6">

		<h4>Headlines</h4>
		<p style="font-style: italic;">To start discussing one of the headlines below, click on it and add your comment.
		You'll be prompted to move it to the relevant folder.</p>


		<ul class="list-unstyled">
	   	   	<g:each var="headline" in="${headlines}">
				<li class="discussionlistitem">
	   				<div>
	   					<g:link action="fromheadline" controller="discussion" id="${headline.id}">From The Guardian: ${headline.headline}</g:link>
	   				</div>
	   				<div>
	   					<g:formatDate date="${headline.publicationDate}" type="datetime" style="MEDIUM"/>
	   				</div>
				</li>
	   		</g:each>
		</ul>

   	</div>

</body>
</html>