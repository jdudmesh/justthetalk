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

		<h2>Your Timeline</h2>
		<p style="font-style: italic;">Create a discussion about one of your tweets by clicking
		on it below. You'll be prompted to move it to a more relevant folder.</p>

		<g:if test="${tweets?.size()==0}">
			<p style="font-style: italic;">
				You don't have any tweets. This may be because you have not connected your JUSTtheTalk account to your
				Twitter account. Visit your profile page to connect both accounts.
			</p>
		</g:if>


		<ul class="list-unstyled">
   	   	<g:each var="tweet" in="${tweets}">

   			<g:set var="tweetText" value="From Twitter: ${tweet.user.screenName} - ${tweet.text}" />
   			<g:set var="tweetParam" value="${tweetText.encodeAsURL()}" />

   			<li class="discussionlistitem">
   				<div>
   					<g:link controller="discussion" action="add" id="${folder.id}" params="[title:tweetParam]"><span style="font-weight:bold;">${tweet.user.screenName}</span> - ${tweet.text}</g:link>
   				</div>
   			</li>

   		</g:each>
   		</ul>

   	</div>

</body>
</html>