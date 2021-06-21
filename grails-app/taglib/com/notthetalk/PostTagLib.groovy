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

import grails.web.JSONBuilder
import groovy.xml.MarkupBuilder
import java.text.DecimalFormat
import java.text.NumberFormat
import java.text.SimpleDateFormat
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib

class PostTagLib {

	def ONE_HOUR = 3600

	def markdownService
	def redisService
	def userService
	def springSecurityService

	/*
	def renderPostFromId = { attrs, body ->

		def post = Post.get(attrs.postId)
		def user = springSecurityService.currentUser

		def postItem = new PostListItem(id: post.id,
			userId: post.userId,
			showModerationReport: (post.status == 1 || post.status == 4 || post.moderationScore > 0),
			isLastPost : true,
			postNum: post.postNum,
			createdDate: post.createdDate,
			status: post.status)

		buildPost(postItem, user, post)

	}
	*/
	/*
	def renderPost = { attrs, body ->

		def post = attrs.post
		def user = springSecurityService.currentUser

		def postItem = new PostListItem(id: post.id,
			userId: post.userId,
			showModerationReport: (post.status == 1 || post.status == 4 || post.moderationScore > 0),
			isLastPost : true,
			postNum: post.postNum,
			createdDate: post.createdDate,
			status: post.status)

		buildPost(postItem, user, post)

	}
	*/
	def renderPostCached = { attrs, body ->

		def postItem = attrs.postItem
		def postCount = attrs.postCount
		def user = springSecurityService.currentUser

		out << buildCachedPost(postItem,
			user,
			postCount,
			null)

	}

	def formatPost = { attrs, body ->
		out << TextFormatter.formatText(attrs.text)
	}

	def renderLineBreaks = { attrs, body ->
		TextFormatter.renderLineBreaks attrs.text, attrs.int('max'), out
	}

	def renderSearchResult = { attrs, body ->

		def post = Post.get(attrs.postId)
		def user = springSecurityService.currentUser

		if(post) {

			out << "<div id='post_$post.id' class='postouter'>"

			def postUri = g.createLink(uri:post.canonicalUrl(), fragment: "post_$post.id")
			out << "<div class='postheader'>"
			out << "<a href='$postUri'>$post.discussion.title - $post.discussion.folder.description</a>"
			out << "</div>"

			if(user && userService.userIgnoresUserId(user, post.userId) && post.status != Post.STATUS_POSTED_BY_NOTTHETALK) {
				out << "<div class='post-ignored'>Post by ignored user</div>"
			}
			else {

				out << "<div>"
				out << buildTopLine(post)
				out << "</div>"

				if(!post.isOk()) {
					out << "<div class='alert alert-info'>"
					out << post.statusText()
				}
				else {
					out << buildPostBody(post)
				}
			}


			out << "</div>"

		}
		else {

			log?.error("Post not found: $attrs.postId")

			out << "<div class='postouter'>"
			out << "<div class='alert alert-danger'"
			out << "Post not found"
			out << "</div>"
			out << "</div>"

		}

	}

	def buildCachedPost(postItem, user, postCount, post) {

		def markup = buildPost(postItem, user, post)

		/*
		if(postCount) {
			markup = (markup =~ /<span class='POSTCOUNT'>\d+<\/span>/).replaceFirst("<span>$postCount</span>")
		}
		*/

		return markup
	}

	def buildPost(postItem, user, post) {

		def w = new StringWriter()

		post = post ?: Post.get(postItem.id)

 		w << "<div class='postouter' id='post_$postItem.id'>"

			if(postItem.isLastPost) {
				w << "<div id='last' class='postouter'><!-- this is the last post --></div>"
			}

			if(SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN,ROLE_MODERATOR")) {

				w << "<div class='postheader'>"
				w << buildMenu(postItem, user)
				w << buildTopLine(post)
				w << "</div>"

				if(user && userService.userIgnoresUserId(user, postItem.userId) && postItem.status != Post.STATUS_POSTED_BY_NOTTHETALK) {
					w << "<div class='post-ignored'>Post by ignored user</div>"
				}

				if(post.status == Post.STATUS_POSTED_BY_NOTTHETALK) {
					w << "<div class='alert alert-info'>Posted by: $post.user.username</div>"
				}

				if(!post.isOk()) {
					w << "<div class='alert alert-info'>${post.statusText()}</div>"
				}

				w << buildPostBody(post)

				if(postItem.showModerationReport) {
					w << buildModerationReport(post, user)
				}

			}
			else {

				if(user && userService.userIgnoresUserId(user, postItem.userId) && postItem.status != Post.STATUS_POSTED_BY_NOTTHETALK) {
					w << "<div class='postheader'>"
					w << "<div class='alert alert-warning'>Post by ignored user</div>"
					w << "</div>"
				}
				else {

					w << "<div class='postheader'>"

					if(post.isOk()) {
						w << buildMenu(postItem, user)
						w << buildTopLine(post)
					}
					else {
						w << "<div class='alert alert-info'>${post.statusText()}</div>"
					}

					w << "</div>"

					if(post.isOk()) {
						w << buildPostBody(post)
					}

				}

			}

		w << "</div>"

		return w.toString()

	}

	def buildPostBody(post) {

		def w = new StringWriter()

		w << "<div class='postbody'>"
		if(post.markdown) {
			w << markdownService.markdown(post.text)
		}
		else {
			w << TextFormatter.formatText(post.text, post)
		}
		w << "</div>"

		return w.toString()

	}

	def buildTopLine(post) {

		def w = new StringWriter()

		def g = new ApplicationTagLib()
		def username = post.status == Post.STATUS_POSTED_BY_NOTTHETALK ? "NOTtheTalk" : userService.getUsername(post.userId)
		def userlink = g.createLink(controller: "home", action: "user", id: username);

		def fmt = new SimpleDateFormat("dd MMM yyyy HH:mm:ss")
		def postDate = fmt.format(post.createdDate)

		w << "<div class='posttitle'>"
		w << "<span class='bold'><a href='$userlink'>$username</a></span> - $postDate (#"
		w << "<a href='${post.canonicalUrl()}'>$post.postNum</a> of "
		w << "<span class='POSTCOUNT'>${post.discussion.postCount}</span>)"
		w << "</div>"

		return w.toString()

	}

	def buildMenu(postItem, user) {

		def w = new StringWriter()

		w << "<div class='btn-group pull-right'>"
		w << "<button class='btn btn-default btn-xs dropdown-toggle' type='button' data-toggle='dropdown'><b class='caret'></b></button>"

		w << "<ul class='dropdown-menu' role='menu'>"

		if(user && user.id != postItem.userId) {
			w << "<li><a href='javascript:ignorePoster($postItem.id);'>Ignore this poster</a></li>"
		}

		w << "<li><a href='javascript:reportPost($postItem.id);'>Report this post</a></li>"

		if(user && postItem.userId == user?.id) {

			w << "<li class='divider'></li>"

			def age = new Date().getTime() - postItem.createdDate.getTime()
			if(age < 3600000) {
				w << "<li><a href='javascript:editPost($postItem.id);'>Edit</a></li>"
			}

			w << "<li><a href='javascript:deletePost($postItem.id);'>Delete</a></li>"

			w << "<li class='divider'></li>"

			w << "<li><a href='javascript:shareFacebook($postItem.id);'>Share</a></li>"
			w << "<li><a href='javascript:shareTwitter($postItem.id);'>Tweet</a></li>"

		}

		if(SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")) {

			w << "<li class='divider'></li>"

			w << "<li>"
			if(postItem.status == Post.STATUS_DELETED_BY_ADMIN) {
				w << "<a href='javascript:adminUndelete($postItem.id);'>Admin Un-delete</a>"
			}
			else {
				w << "<a href='javascript:adminDelete($postItem.id);'>Admin Delete</a>"
			}
			w << "</li>"

			w << "<li class='divider'></li>"

			w << "<li><a href='javascript:blockUserFromThread($postItem.userId);'>Block User</a></li>"

		}

		w << "</ul>"
		w << "</div>"

		return w.toString()

	}

	def buildModActions(post) {

		def w = new StringWriter()

		w << "<div class='moderation-actions'>"

		w << "<div id='moderate_action1_$post.id' class='btn-group'>"
		w << "<button class='btn btn-primary dropdown-toggle' type='button' data-toggle='dropdown'><span>Vote Keep</span><b class='caret'></b></button>"
		w << "<ul class='dropdown-menu' role='menu'>"
		w << "<li style='padding:4px'>"
		w << "<div><label for='comment'>Comment</label></div>"
		w << "<div><input type='text' id='keep_$post.id' name='comment' style='width:320px;margin-bottom:4px;' /></div>"
		w << "<div><button type='button' onClick='submitModerationResult(\"MOD_KEEP\", $post.id);' class='btn btn-primary'>Save</button></div>"
		w << "</li>"
		w << "</div>"

		w << "<div id='moderate_action2_$post.id' class='btn-group'>"
		w << "<button class='btn btn-primary dropdown-toggle' type='button' data-toggle='dropdown'><span>Vote Delete</span><b class='caret'></b></button>"
		w << "<ul class='dropdown-menu' role='menu'>"
		w << "<li style='padding:4px'>"
		w << "<div><label for='comment'>Comment</label></div>"
		w << "<div><input type='text' id='delete_$post.id' name='comment' style='width:320px;margin-bottom:4px;' /></div>"
		w << "<div><button type='button' onClick='submitModerationResult(\"MOD_DELETE\", $post.id);' class='btn btn-primary'>Save</button></div>"
		w << "</li>"
		w << "</div>"

		w << "</div>"

		return w.toString()

	}

	def buildModSummary(post) {

		def w = new StringWriter()

		NumberFormat formatter = new DecimalFormat("#0.00");

		w << "<p style='text-decoration: underline; font-weight: bold;'>Summary</p>"
		w << "<div>Number of reports: ${post.reports?.size().toString()}</div>"
		w << "<div>Moderation Score: ${formatter.format(post.moderationScore)}</div>"

		return w.toString()
	}

	def buildModResult(post) {

		def w = new StringWriter()

		w << "<div>"
		w << "Moderation Result: "
		if(post.moderationResult < 0) {
			w << "Delete"
		}
		else if(post.moderationResult > 0) {
			w << "Keep"
		}
		else {
			w << "Pending"
		}
		w << "</div>"

		return w.toString()

	}

	def buildModReports(post) {

		def w = new StringWriter()
		def g = new ApplicationTagLib()

		w << "<div>"
		w << "<h5>Reports</h5>"
		post.reports.each {
			def report = it
			w << "<div>"

			w << "<div style='text-decoration: underline;'>"
			w << g.formatDate(date:report.createdDate, type:"datetime", format:"dd/MMM/yyyy HH:mm")
			w << " - "
			if(report.user) {
				w << report.user.username
			}
			else {
				w << "Anonymous"
			}
			w << "</div>"

			w << "<div>($report.email)</div>"
			w << "<div>$report.comment)</div>"

			w << "</div>"
		}
		w << "</div>"

		return w.toString()
	}

	def buildModComments(post) {

		def w = new StringWriter()
		def g = new ApplicationTagLib()

		w << "<div>"
		w << "<p style='text-decoration: underline; font-weight: bold;'>Moderator Comments</p>"


		post.moderatorComments.each {
			def comment = it
			w << "<div>"
			w << "<div style='text-decoration: underline;'>"
			w << g.formatDate(date:comment.createdDate, type:"datetime", format:"dd/MMM/yyyy HH:mm")
			w << " - $comment.user.username ("
			switch(comment.result) {
				case -1:
					w << "Delete"
					break
				case 0:
					w << "No Action"
					break
				case 1:
					w << "Keep"
					break
			}
			w << ")"
			w << "</div>"

			w << "<div>$comment.comment</div>"

			w << "</div>"
		}
		w << "</div>"

		return w.toString()

	}

	def buildModerationReport(post, user) {

		def w = new StringWriter()
		String cssClass = "post-moderated"

		switch(post.status) {
			case Post.STATUS_SUSPENDED_BY_ADMIN:
				cssClass = "post-moderated-suspended"
				break
			case Post.STATUS_DELETED_BY_ADMIN:
				cssClass = "post-moderated-deleted"
				break
			case Post.STATUS_POSTED_BY_NOTTHETALK:
				cssClass = "post-moderated-deleted"
				break
			case Post.STATUS_WATCH:
				cssClass = "post-moderated-watch"
				break
			case Post.STATUS_DELETED_BY_USER:
				cssClass = "post-moderated-deletedbyuser"
				break
		}

		w << "<div class='$cssClass' id='moderate_$post.id'>"

		def comment = ModeratorComment.findByUserAndPost(user, post)
		if(!comment) {
			w << buildModActions(post)
		}

		w << "<div class='moderation-report'>"

		/*
		if(post.status > 0 && post.status != Post.STATUS_WATCH) {
			w << "<div style='margin-bottom: 24px; width: 66%;' id='post_${post.id}'>"
			w << buildPostBody(post)
			w << "</div>"
		}
		*/
		w << "<div>"

		w << buildModSummary(post)

		w << buildModResult(post)

		w << buildModReports(post)

		w << buildModComments(post)


		w << "</div>"
		w << "</div>"

		w << "</div>"

		return w.toString()

	}

}
