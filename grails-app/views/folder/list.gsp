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
<link rel="canonical" href="${createLink(folder.canonicalUrl(), absolute:true)}" />
<meta name="ROBOTS" content="NOINDEX, FOLLOW">

</head>
<body>

   	<div id="folders" class="col-sm-3">
		<sec:ifLoggedIn>
	   		<ul class="list-unstyled flowlist">

	   			<g:if test="${folder.type == com.notthetalk.Folder.TYPE_NORMAL || folder.type == com.notthetalk.Folder.TYPE_ADMIN}">
   					<li><g:link uri="${folder.canonicalUrl([do:'add'])}" rel="nofollow">Start a discussion</g:link></li>
   				</g:if>
   				<g:if test="${nav.userIsSubscribed}">
   					<li><g:link uri="${folder.canonicalUrl([do:'unsubscribe'])}" rel="nofollow">Unsubscribe</g:link></li>
   				</g:if>
   				<g:else>
   					<li><g:link uri="${folder.canonicalUrl([do:'subscribe'])}" rel="nofollow">Subscribe to folder</g:link></li>
   				</g:else>

   			</ul>
   		</sec:ifLoggedIn>
	</div>

   	<div class="col-sm-6">

		<h4>Discussions</h4>


		<ul class="list-unstyled">
			<g:each var="d" in="${discussions}">
				<g:discussionTitle header="${d}" max="50" showfolders="${nav.showfolders}" />
			</g:each>
		</ul>

		<div class="bordered">
			<g:paginateFolderList total="${numdiscussions}" id="${folder.folderKey}" max="30" page="1"/>
		</div>

   	</div>

</body>
</html>