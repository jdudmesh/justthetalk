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

		<div id="postlist">

			<g:set var="counter" value="${1 }" />
			<g:set var="now" value="${new Date()}" />

			<g:if test="${posts.size() == 0}">
				<div class="alert alert-warning">Nobody has posted on this thread yet</div>
			</g:if>

			<!--  actually render each post -->
			<div>
				<g:each var="post" in="${posts}">
					<g:renderPostCached postItem="${post}" postCount="${discussion?.postCount}" />
				</g:each>
			</div>

		</div>

<g:set var="returnURL" value="${URLEncoder.encode(createLink(controller: controllerName, action: actionName, params: params).toString())}" />

<script type="text/javascript">
	$(function(){
		// Fix input element click problem
		$('.dropdown-menu input, .dropdown-menu label').click(function(e) {
			e.stopPropagation();
		});
	});
<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MODERATOR">

		function submitModerationResult(action, postId) {

			var comment = "";
			if(action == "MOD_KEEP") {
				comment = $("#keep_" + postId.toString()).val();
			}
			else {
				comment = $("#delete_" + postId.toString()).val();
			}

			if(comment.length == 0) {
				alert("You must enter a comment");
			}
			else {

				$.post("${createLink(controller:'post',action:'submitmoderation')}", {comment: comment, id: postId, mod_action: action}, function(data) {
					if(data) {
						$("#post_" + postId.toString()).html(data);
					}
					else {
						alert("Error!");
					}
				});

			}
		}

</sec:ifAnyGranted>

	function reportPost(postId) {
		window.location.href = "${createLink(controller:'post',action:'report')}/" + postId;
	}

	function ignorePoster(postId) {

		BootstrapDialog.show({
            title: 'Ignore Poster',
            message: "Are you sure you want to ignore this poster?",
            cssClass: "confirm-dialog",
            buttons: [
				{
                	label: 'Ignore',
                	cssClass: 'btn-primary',
                	action: function(){
                		window.location.href = "${createLink(controller:'post',action:'ignore')}/" + postId + "?return=${returnURL}";
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

	function editPost(postId) {
		window.location.href = "${createLink(controller:'post',action:'edit')}/" + postId + "?start=${nav.start}";
	}

	function deletePost(postId) {

		BootstrapDialog.show({
            title: 'Delete Post',
            message: "Are you sure you want to delete this post?",
            cssClass: "confirm-dialog",
            buttons: [
				{
                	label: 'Delete',
                	cssClass: 'btn-primary',
                	action: function(){
                		window.location.href = "${createLink(controller:'post',action:'delete')}/" + postId + "?start=${nav.start}";
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

	function shareFacebook(postId) {
		$.post("${createLink(controller:'facebook',action:'share')}/" + postId, {postId: postId}, function(data) {
			if(data != "OK") {
				alert("Doh! Something went wrong sending this to Facebook")
			}
		});
	}

	function shareTwitter(postId) {
		$.post("${createLink(controller:'twitter',action:'tweet')}/" + postId, {postId: postId}, function(data) {
			if(data != "OK") {
				alert("Doh! Something went wrong sending this to Twitter")
			}
		});
	}
</script>
