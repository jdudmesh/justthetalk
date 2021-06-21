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
	<meta name="layout" content="main"/>
	<title>JUSTtheTalk</title>

</head>
<body>
		<sec:ifLoggedIn>
			<script type="text/javascript">

				var subsUpdatesVisible = false;

				jQuery.fn.doesExist = function(){
			        return jQuery(this).length > 0;
			 	};

				function closeSocket() {
					socket.disconnect();
				}

				$(document).ready(function(){

					// ${grailsApplication.config.notthetalk.eventsUrlSecure}
					// ${grailsApplication.config.notthetalk.eventsUrl}
					var userId = "${user.id}";
					var socket = io.connect("${flash.proto == "HTTP" ? grailsApplication.config.notthetalk.eventsUrl : grailsApplication.config.notthetalk.eventsUrlSecure}");

					socket.on('connect', function (data) {
						socket.emit('subscribe', { topic: "front_page_" + userId } );
					});

					socket.on('update', function (msg) {
						getSubsUpdates()
					});

				});

				$(window).unload(function() {
					closeSocket();
				});

				function getSubsUpdates() {

					$.get("${createLink(controller:'subscriptions', action:'checkAjax')}", function(data) {
						if(data && $("#subsupdates").doesExist()) {
							$("#subsupdates").html(data);
							$("#subsupdates").css("display", "");
						}
					});

				}

			</script>
		</sec:ifLoggedIn>

   		<g:if test="${flash.errorMessage}">
   			<div class="alert alert-danger">${flash.errorMessage}</div>
   		</g:if>

		<g:render template="/common/folderbar" bean="${folders}" />

    	<div id="posts" class="col-sm-6">

    		<g:if test="${!updates?.size()}">
	    		<div id="subsupdatesouter" style="display: none;">
	    			<h2 class="margin12">Subscriptions</h2>
	    			<div id="subsupdates">
	    				<ul class="list-unstyled"></ul>
	    			</div>
	    		</div>
    		</g:if>
    		<g:else>
	    		<div id="subsupdatesouter">
	    			<h4>Subscriptions</h4>
	    			<ul id="subsupdates" class="list-unstyled">
						<g:each var="d" in="${updates}">
							<g:discussionTitle header="${d}" max="50" showfolders="${nav.showfolders}" />
						</g:each>
	    			</ul>
	    		</div>
    		</g:else>

    		<h4>Discussions</h4>
    		<ul class="list-unstyled">
				<g:each var="d" in="${discussions}">
					<g:discussionTitle header="${d}" max="50" showfolders="${nav.showfolders}" />
				</g:each>
			</ul>

    	</div>


</body>
</html>