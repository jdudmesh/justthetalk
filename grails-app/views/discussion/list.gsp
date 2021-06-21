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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<html>
<head>
	<meta name="layout" content="main"/>
	<meta name="description" content="${discussion.title}">

	<title>JUSTtheTalk - ${raw(discussion.title)} (${discussion.folder.description})</title>

<g:if test="${nav.sourcetype != com.notthetalk.Folder.TYPE_HEADLINES }">
	<g:if test="${nav.postCount == 0 || posts.size() == 0}">
		<link rel="canonical" href="${createLink(uri:discussion.canonicalUrl(), absolute:true)}" />
	</g:if>
	<g:else>
		<link rel="canonical" href="${createLink(uri:discussion.canonicalUrl())}, absolute:true)/${posts[0].postNum}" />
	</g:else>
</g:if>

</head>
<body>

	<g:if test="${user?.hasFacebook()}">
		<div id="fb-root"></div>
		<script src="http://connect.facebook.net/en_US/all.js"></script>
		<script>
		  FB.init({
		    appId  : '135030003232702',
		    status : true, // check login status
		    cookie : true, // enable cookies to allow the server to access the session
		    xfbml  : true  // parse XFBML
		  });
		</script>
	</g:if>

	<g:set var="d_id" value="${discussion.id}" />
	<g:set var="returnURLTop" value="${URLEncoder.encode(createLink(controller: controllerName, action: actionName, params: params).toString())}" />
	<g:set var="returnURLBottom" value="${URLEncoder.encode(createLink(controller: controllerName, action: actionName, params: params, fragment: 'last').toString())}" />

<sec:ifLoggedIn>
	<g:if test="${discussion && nav.isLastPage}">
		<script type="text/javascript">

			var discussionId = "${discussion.id}";
			var lastPostId = ${discussion.lastPostId ?: 0};
			var lastPostCount = ${discussion.postCount};
			var newPostsIndicatorVisible = false;
			var newPostsVisible = false;
			var socket = null;

			<g:if test="${!iphone}">

			function closeSocket() {
				socket.disconnect();
			}

			$(document).ready(function() {

				socket = io.connect("${flash.proto == "HTTP" ? grailsApplication.config.notthetalk.eventsUrl : grailsApplication.config.notthetalk.eventsUrlSecure}");

				socket.on('connect', function (data) {
					socket.emit('subscribe', {topic: "discussion_" + discussionId} );
				});

				  socket.on('update', function (msg) {
					if(msg.postCount > lastPostCount) {

						if(newPostsVisible) {
							$("#newpostsindicator").html("<span>There are " + (msg.postCount - lastPostCount).toString() + " new post(s).</span>");
						}
						else {
							$("#newpostsindicator").html("<span>There are " + (msg.postCount - lastPostCount).toString() + " new post(s). Click to display...</span>");
						}

						if(!newPostsIndicatorVisible) {
							$("#newpostsborder").css("display", "");
							$("#newpostsindicator").css("display", "");

							newPostsIndicatorVisible = true;
						}

						if(newPostsVisible) {
							getLatestPosts();
						}

					}
				  });

			});

			$(window).unload(function() {
				closeSocket();
			});

			</g:if>

			function getLatestPosts() {

				$.get("${createLink(controller:'discussion', action:'getpostsafter', id:discussion.id)}?lastPostId=" + lastPostId, function(data) {
					$("#newpostshere").html(data);
					$("#newpostshere").css("display", "");
					newPostsVisible = true;
				});
			}

		</script>
	</g:if>
<sec:ifAnyGranted roles="ROLE_ADMIN">

	<script type="text/javascript">

		function adminDelete(postId) {
			$.post("${createLink(controller:'post', action:'adminDelete')}/" + postId, {}, function(data) {
				if(data == "OK") {
					window.location.reload();
				}
				else {
					alert("An error occurred!");
				}
			});
		}

		function adminUndelete(postId) {
			$.post("${createLink(controller:'post',action:'adminUndelete')}/" + postId, {}, function(data) {
				if(data == "OK") {
					window.location.reload();
				}
				else {
					alert("An error occurred!");
				}
			});
		}

		function blockUserFromThread(userId) {
			$.post("${createLink(controller:'discussion',action:'blockUserFromDiscussion')}/" + discussionId.toString(), {userId: userId}, function(data) {
				if(data == "OK") {
					window.location.reload();
				}
				else {
					alert("An error occurred!");
				}
			});
		}

		function unblockUserFromThread(userId) {
			$.post("${createLink(controller:'discussion',action:'unblockUserFromDiscussion')}/" + discussionId.toString() , {userId: userId}, function(data) {
				if(data == "OK") {
					window.location.reload();
				}
				else {
					alert("An error occurred!");
				}
			});
		}

		function deleteDiscussion() {

			BootstrapDialog.show({
	            title: 'Delete Discussion',
	            message: "Are you sure you want to delete this discussion?",
	            cssClass: "confirm-dialog",
	            buttons: [
					{
	                	label: 'Delete',
	                	cssClass: 'btn-primary',
	                	action: function(){
	                		window.location.href = "${createLink(controller:'discussion', action:'admindelete')}/${discussion.id}";
	                	}
	            	},
	            	{
	                	label: 'Close',
	                	action: function(self){
	                    	self.close();
	                	}
	            	}]
	        });

		}

		function undeleteDiscussion() {

			BootstrapDialog.show({
	            title: 'Un-delete Discussion',
	            message: "Are you sure you want to un-delete this discussion?",
	            cssClass: "confirm-dialog",
	            buttons: [
					{
	                	label: 'Un-delete',
	                	cssClass: 'btn-primary',
	                	action: function(){
	                		window.location.href = "${createLink(controller:'discussion', action:'adminundelete')}/${discussion.id}";
	                	}
	            	},
	            	{
	                	label: 'Close',
	                	action: function(self){
	                    	self.close();
	                	}
	            	}]
	        });
		}

		function moveDiscussionToPersonal() {

			BootstrapDialog.show({
	            title: 'Move Discussion',
	            message: "Are you sure you want to move this discussion to the personal folder?",
	            cssClass: "confirm-dialog",
	            buttons: [
					{
	                	label: 'Move',
	                	cssClass: 'btn-primary',
	                	action: function(){
	                		window.location.href = "${createLink(controller:'discussion', action:'moveToPersonal')}/${discussion.id}";
	                	}
	            	},
	            	{
	                	label: 'Close',
	                	action: function(self){
	                    	self.close();
	                	}
	            	}]
	        });
		}

	</script>

</sec:ifAnyGranted>

</sec:ifLoggedIn>

   	<div id="discussionsidebar" class="col-sm-3">
		<sec:ifLoggedIn>
			<ul class="list-unstyled flowlist">
	   		<li>
   				<g:link action="bottom" controller="discussion" id="${discussion.id}" fragment="post">Post a message</g:link>
   			</li>
   			<li>
   				<g:if test="${discussion.status == 0}">
					<g:if test="${nav.subscribed}">
						<g:link action="unsubscribe" controller="subscriptions" id="${discussion.id}" params="[return: returnURLTop]" rel="nofollow">Unsubscribe</g:link>
					</g:if>
					<g:else>
						<g:link action="subscribe" controller="subscriptions" id="${discussion.id}" params="[return: returnURLTop]" rel="nofollow">Subscribe</g:link>
					</g:else>
				</g:if>
			</li>
	   		<sec:ifAnyGranted roles="ROLE_ADMIN">
	   			<li>&nbsp;</li>
	   			<li>
	   				<g:if test="${discussion.locked}">
	   					<g:link action="unlock" controller="discussion" id="${discussion.id}" params="[return: returnURLTop]" rel="nofollow">Unlock</g:link>
	   				</g:if>
	   				<g:else>
	   					<g:link action="lock" controller="discussion" id="${discussion.id}" params="[return: returnURLTop]" rel="nofollow">Lock</g:link>
	   				</g:else>
	   			</li>
	   			<li>
	   				<g:if test="${discussion.premoderate}">
	   					<g:link action="unpremoderate" controller="discussion" id="${discussion.id}" params="[return: returnURLTop]" rel="nofollow">Stop Pre-moderating</g:link>
	   				</g:if>
	   				<g:else>
	   					<g:link action="premoderate" controller="discussion" id="${discussion.id}" params="[return: returnURLTop]" rel="nofollow">Pre-moderate</g:link>
	   				</g:else>
	   			</li>
   				<li>
	   				<g:if test="${discussion.status == com.notthetalk.Discussion.STATUS_DELETED_BY_ADMIN}">
	   					<a href="javascript:undeleteDiscussion();" rel="nofollow">Undelete discussion</a>
	   				</g:if>
	   				<g:else>
	   					<a href="javascript:deleteDiscussion();" rel="nofollow">Delete discussion</a>
	   				</g:else>
   				</li>
   				<li>
   					<g:link action="edit" controller="discussion" id="${d_id}" rel="nofollow">Edit discussion</g:link>
   				</li>
   				<li>
   					<a href="javascript:moveDiscussionToPersonal();" rel="nofollow">Move to Personal Folder</a>
   				</li>
	   		</sec:ifAnyGranted>
	   		</ul>

   			<sec:ifAnyGranted roles="ROLE_ADMIN">
				<h4>Blocked Users</h4>
				<ul class="list-unstyled flowlist">
					<g:if test="${blockedUsers && blockedUsers.size() > 0}">
						<g:each var="blocked" in="${blockedUsers}">
							<li>${blocked.user.username} <input type="button" class="btn btn-warning btn-xs" onclick="unblockUserFromThread(${blocked.user.id});" value="Unblock" /></li>
						</g:each>
					</g:if>
					<g:else>
						<li>No blocked users</li>
					</g:else>
				</ul>
   			</sec:ifAnyGranted>

   		</sec:ifLoggedIn>

	</div>


	<div id="maincontent" class="col-sm-6">

		<div class="threadouterheader">

			<div id="threadtop" class="well well-sm">

				<div class="threadheadingdesc">
					Started by <span class="bold"><g:link controller="home" action="user" id="${discussion.user.username.encodeAsURL() }" rel="nofollow">${discussion.user.username}</g:link></span> on <g:formatDate date="${discussion.createdDate}" type="datetime" style="MEDIUM"/>
				</div>

				<div class="threadheadingdiscussionheader">
					<g:renderDiscussionHeader text="${discussion.title}" max="40"/>
				</div>

			</div>

			<div class="headertext">
				<g:formatPost text="${discussion.header}" />
		  	</div>

			<g:if test="${discussion.locked}"><div class="alert alert-warning">[This thread is now closed to further comments]</div></g:if>

		</div>

		<g:if test="${discussion.id}">
			<sec:ifLoggedIn>

				<g:if test="${user.hasFacebook()}">
					<fb:like href="${createLink(controller:'discussion',action:'list',id:discussion.id,absolute:true) }" show_faces="false" width="416" font="">
					</fb:like>
				</g:if>

				<g:if test="${discussion.canEdit(user.id)}">
					<div id="margin12">
				   		<g:link action="edit" controller="discussion" id="${d_id}" rel="nofollow">Edit discussion</g:link> |
				   		<g:link action="delete" controller="discussion" id="${d_id}" rel="nofollow">Delete discussion</g:link>
				   		<br/><br/>
				   	</div>
				</g:if>
			</sec:ifLoggedIn>
		</g:if>

		<g:if test="${nav.numPosts >= 1 }">
			<g:render template="/common/threadnav" bean="${discussion }"/>
		</g:if>
		<g:else>
			<div class="bordered">&nbsp;</div>
		</g:else>


		<g:render template="/common/postlist" model="[posts:posts]" />

		<div id="newpostsborder" class="bordered" style="clear: both; display: none;"></div>
		<div id="newpostsindicator" style="display:none" onclick="getLatestPosts();" class="alert alert-info"></div>
		<div id="newpostshere"></div>


		<g:render template="/common/threadnav" bean="${discussion}"/>

		<div style="margin-bottom:12px;">
			<g:link controller="subscriptions" action="check">Check Subscriptions</g:link>
			<div class="linkspacer">|</div>
			<g:link controller="home" action="index" class="headerTextLink">Home</g:link>
			&raquo;
			<g:link uri="${discussion.folder.canonicalUrl()}" class="headerTextLink">${discussion.folder.description}</g:link>

		</div>


		<g:if test="${(nav.isLastPage || flash.postid != 'NEW') && !discussion.locked && !nav.isBlocked }">

			<sec:ifLoggedIn>
				<g:form name="post" controller="post" action="save" class="bordered" useToken="true" onsubmit="closeSocket();">

					<p>
						Write your reply here...
					</p>


					<div>
						<g:textArea name="reply" class="posttextarea">${flash.messagetext}</g:textArea>
						<g:if test="${flash.posterror != null && flash.posterror.length() > 0}">
							<div class="alert alert-danger" style="margin-top: 12px;">${flash.posterror}</div>
						</g:if>
					</div>
					<sec:ifAnyGranted roles="ROLE_ADMIN">
						<br/>
						<div><g:checkBox name="postasadmin" value="${flash.postAsNotTheTalk}" /> Post as 'NOTtheTalk'</div>
					</sec:ifAnyGranted>

					<g:hiddenField name="discussionid" value="${discussion.id}"></g:hiddenField>
					<g:hiddenField name="postid" value="${flash.postid}"></g:hiddenField>
					<g:hiddenField name="folderid" value="${discussion.folder.id}"></g:hiddenField>
					<g:hiddenField name="start" value="${nav.start}"></g:hiddenField>
					<g:hiddenField name="sourceid" value="${nav.sourceid}"></g:hiddenField>
					<g:hiddenField name="sourcetype" value="${nav.sourcetype}"></g:hiddenField>

					<div>
						<br/>
						<g:if test="${discussion.folder.type == com.notthetalk.Folder.TYPE_NORMAL || discussion.folder.type == com.notthetalk.Folder.TYPE_ADMIN}">
							<g:submitButton name="submit" value="Post Reply" class="btn btn-primary"/>
						</g:if>
						<g:else>
							<div class="btn-group">
								<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
									Post to folder... <span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu">
									<g:each  var="f" in="${folders}">
										<li><a onclick="postToFolder(${f.id})">${f.description}</a></li>
									</g:each>
								</ul>
							</div>
							<script type="text/javascript">
								function postToFolder(folderId) {
									$("#folderid").val(folderId);
									$("#post").submit();
								}
							</script>
						</g:else>
					</div>

					<br/>

				</g:form>

				<div class="bordered">
				You cannot rewrite history, but you will have 30 minutes to make any
				changes or fixes after you post a message. Just click on Edit in the
				drop down which appears in your message after you post it.
				</div>

			</sec:ifLoggedIn>
		</g:if>
		<g:if test="${nav.isBlocked}">
			<div class="alert alert-danger">You have been blocked from posting on this thread.</div>
		</g:if>

	</div>

</body>
</html>
