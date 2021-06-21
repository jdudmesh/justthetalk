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

import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils;
import grails.util.Mixin
import org.apache.commons.lang.math.NumberUtils

@Mixin(ProxyAwareControllerMixin)
class DiscussionController {

	public static final Integer MAX_POSTS = 20I
	public static final Integer ALL_POSTS = 1000I

	def springSecurityService
	def discussionService
	def postService
	def postTagLib

	def top = {
		forward action: "list", id: params.id, params:[start: 0]
	}

	def bottom = {

		cache false

		def discussion = Discussion.get(params.id)
		def start = discussion.postCount - MAX_POSTS

		start = start < 0 ? 0 : start

		forward action: "list", id: params.id, params:[start: start], fragment: "last"
	}

	def next = {

		cache false

		def discussion = Discussion.get(params.id)
		def last = params.last == null ? 0 : params.last.toInteger()

		assert discussion

		def start = last + MAX_POSTS

		start = start > discussion.postCount ? discussion.postCount : start

		forward action: "list", id: params.id, params:[start: start]
	}

	def prev = {

		cache false

		def discussion = Discussion.get(params.id)
		def last = params.last == null ? 0 : params.last.toInteger()
		def start = last - MAX_POSTS

		start = start < 0 ? 0 : start

		forward action: "list", id: params.id, params:[start: start]
	}

	def check = {

		cache false

		def start = 0
		def discussion = Discussion.get(params.id)

		if(springSecurityService.isLoggedIn()) {
			def user = springSecurityService.currentUser
			def bookmark = UserDiscussion.findByUserAndDiscussion(user, discussion)

			if(bookmark) {
				start = Math.max(1, bookmark.lastPostCount)
			}
		}

		def location = "/"
		if(flash.fragment) {
			location = discussion.canonicalUrl() + "/$start#$flash.fragment"
		}
		else if(start > 0) {
			location = discussion.canonicalUrl() + "/$start"
		}
		else {
			location  = discussion.canonicalUrl()
		}

		redirect2 location


	}

	def list = {

		cache false

		if(!NumberUtils.isNumber(params.id)) {
			render status:400, text:"Invalid discussion id"
			return
		}

		def user = springSecurityService.currentUser
		def discussion =  Discussion.get(Long.parseLong(params.id))
		def subscribed = false
		def isBlocked = false
		def blockedUsers = null
		def iphone = false

		if(!discussion) {
			render status:404, text:"Invalid discussion"
			return
		}

		def agent = request.getHeader("User-Agent")
		if(agent =~ /iPhone/) {
			iphone = true
		}

		if(user) {
			isBlocked = discussionService.userIsBlockedFromDiscussion(discussion, user)
		}

		if(discussion.status != Discussion.STATUS_OK && !SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")) {
			redirect2 discussion.folder.canonicalUrl()
			return
		}

		if(discussion.folder.type == Folder.TYPE_ADMIN && !SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN,ROLE_MODERATOR")) {
			redirect2 controller: "home", action: "index"
			return
		}

		if(SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN,ROLE_MODERATOR")) {
			blockedUsers = DiscussionUser.findAllByDiscussion(discussion)
		}

		def startParam = params.int("start")
		def start = startParam ? startParam : 1
		def pageSize = params.int("pageSize") ?: MAX_POSTS
		def headerText = discussion.folder.description

		def maxPage = (int)Math.ceil(discussion.postCount / pageSize) - 1
		maxPage = maxPage < 0 ? 0 : maxPage

		def curPage = (int)Math.floor(start / pageSize)

		if(flash.pagehint) {

			if(flash.pagehint == "ADD") {
				start = maxPage * pageSize
				curPage = (int)Math.floor(start / pageSize)
			}
			else if(flash.pagehint == "DELETE") {
				if(curPage > maxPage) {
					start = maxPage * pageSize
				}
			}
		}
		else {
			if(start > (discussion.postCount)) {
				start = discussion.postCount
			}
		}

		def posts = postService.getPostsFrom(discussion, start - 1, pageSize)

		if(springSecurityService.isLoggedIn()) {

			//HellBan.stickItToEm(user)

			//def bookmark = UserDiscussion.findByUserAndDiscussion(user, discussion) ?: new UserDiscussion(user:user, discussion:discussion, lastUpdated: new Date())

			if(posts.size() > 0) {
				def lastPost = posts[posts.size() - 1]
				discussionService.updateBookmark(lastPost, discussion)
			}
			else {
				// set up a dummy record
				discussionService.updateBookmark(null, discussion)
			}

			subscribed = discussionService.userIsSubscribed(discussion, user)

		}

		def nav = [:]

		if(!flash.postid) {
			flash.postid = "NEW"
		}

		nav.pageSize = pageSize
		nav.curPage = curPage
		nav.maxPage = maxPage
		nav.isLastPage = (start + pageSize > discussion.postCount)
		nav.numPosts = posts.size()
		nav.subscribed = subscribed
		nav.isBlocked = isBlocked
		nav.start = start
		nav.breadcrumbs = [ [link:true, controller:"folder", action:"list", id:discussion.folder.folderKey, text:discussion.folder.description] ]
		nav.showfolders = false

		render	view: "list",
				model:[
					headerText: headerText,
					discussion: discussion,
					posts: posts,
					user: user,
					nav: nav,
					iphone: iphone,
					blockedUsers: blockedUsers,
					folders: Folder.listOrderByDescription() ]

	}

	def listfrom = {
		// list a thread from a specific post

		cache false

		def post = Post.get(params.int("id"))
		if(post) {
			forward action: "list", id: post.discussion.id, params:[start: post.postNum]
		}
		else {
			redirect2 controller: "home", action: "index"
		}


	}

	def all = {
		cache false

		forward action: "list", id: params.id, params:[start: 1, pageSize: ALL_POSTS]

	}

	@Secured(['ROLE_USER'])
	def unread = {
		cache false

		def user = springSecurityService.currentUser
		def discussion = Discussion.get(params.id)
		def bookmark = UserDiscussion.findByUserAndDiscussion(user, discussion)

		assert bookmark

		def start = Math.max(bookmark.lastPostCount, 1)

		forward action: "list", id: params.id, params:[start: start, pageSize: ALL_POSTS]

	}

	@Secured(['ROLE_USER'])
	def add = {

		def user = springSecurityService.currentUser
		def folder = Folder.get(params.id)

		if(folder.type == Folder.TYPE_ADMIN && !SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN,ROLE_MODERATOR")) {
			redirect2 controller: "home", action: "index"
			return
		}


		def headerText = "New Discussion"
		def nav = [:]

		nav.discussionid = "NEW"
		nav.edit = false
		nav.title = params.title ? params.title.decodeURL() : ""
		nav.header = params.header ? params.header.decodeURL() : ""

		nav.breadcrumbs = [ [link:true, controller:"folder", action:"list", id:folder.folderKey, text:folder.description] ]
		render 	view: "add",
				model:[	headerText:headerText,
						nav: nav,
						folder:folder,
						folders: Folder.listOrderByDescription()]
	}

	@Secured(['ROLE_USER'])
	def edit = {

		def user = springSecurityService.currentUser
		def discussion = Discussion.get(params.id)

		if(discussion.folder.type == Folder.TYPE_ADMIN && !SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN,ROLE_MODERATOR")) {
			redirect2 controller: "home", action: "index"
			return
		}

		if(discussion && ((discussion.user.id == user.id && discussion.posts.size() == 0) || SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")))
		{
			def headerText = "Edit Discussion"
			def nav = [:]

			nav.discussionid = discussion.id
			nav.edit = true
			nav.title = discussion.title.decodeHTML()
			nav.header = discussion.header.decodeHTML()

			render view: "add", model:[headerText:headerText, nav: nav, folder:discussion.folder]
		}
	}

	@Secured(['ROLE_USER'])
	def save = {

		def user = springSecurityService.currentUser
		def discussion = null
		def nav = [:]

		def id = params.discussionid
		def title = params.threadtitle?.encodeAsHTML()
		def header = params.threadheader?.encodeAsHTML()
		def folderId = params.folderid.toInteger()

		withForm {

			try {


				if(id != "NEW") {
					discussion = Discussion.get(id)
					if(!(discussion != null && ((discussion.user.id == user.id && discussion.posts.size() == 0) || SpringSecurityUtils.ifAnyGranted("ROLE_ADMIN")))) {
						throw new InvalidUserException()
					}
				}


				discussion = discussionService.save(id, title, header, folderId)
				if(!discussion.hasErrors()) {
					redirect2 url:discussion.canonicalUrl()
				}
				else {

					nav.breadcrumbs = [ [link:true, controller:"folder", action:"list", id:discussion.folder.folderKey, text:discussion.folder.description] ]
					nav.title = discussion.title?.decodeHTML()
					nav.header = discussion.header?.decodeHTML()
					nav.discussionid = "NEW"

					render view: "add", model:[headerText:"New Discussion", folder:discussion.folder, discussion:discussion, nav: nav]

				}

			}
			catch(InvalidUserException badUser) {
				nav.errorMessage = badUser.reason
				redirect2 controller: "home", view: "index"
			}
			catch(Exception any) {
				nav.errorMessage = "An error occurred"
				redirect2 controller: "home", view: "index"
			}

		}
		.invalidToken {

			def folder = Folder.get(folderId)

			flash.errorMessage = "Hmm, this looks like a duplicate submission. Have you clicked the \"Start Discusison\" button twice?"

			nav.breadcrumbs = [ [link:true, controller:"folder", action:"list", id:folder.folderKey, text:folder.description] ]
			nav.title = params.threadtitle
			nav.header = params.threadheader
			nav.discussionid = "NEW"

			render view: "add", model:[headerText:"New Discussion", folder:folder, discussion:null, nav: nav]
		}
	}

	@Secured(['ROLE_USER'])
	def delete = {

		def discussion = Discussion.get(params.id)

		discussionService.delete(discussion)

		redirect2 discussion.folder.canonicalUrl()

	}

	@Secured(['ROLE_ADMIN'])
	def admindelete = {

		def discussion = Discussion.get(params.id)

		discussionService.adminDelete(discussion)
		redirect2 discussion.folder.canonicalUrl()

	}

	@Secured(['ROLE_ADMIN'])
	def adminundelete = {

		def discussion = Discussion.get(params.id)

		discussionService.adminUndelete(discussion)
		redirect2 discussion.folder.canonicalUrl()

	}


	@Secured(['ROLE_USER'])
	def fromheadline = {

		def headerText = "New Discussion"
		def user = User.get(1)
		def headline = GuardianHeadline.get(params.id)

		assert headline

		def folder = Folder.findByType(Folder.TYPE_HEADLINES)

		def discussion = new Discussion(
			title: "$headline.section: $headline.headline",
			header: "The Guardian::$headline.section\r\n\r\n$headline.trailText\r\n\r\n$headline.url",
			createdDate: headline.publicationDate,
			folder: folder,
			user: user,
			postCount: 0)

		def posts =  []
		def nav = [:]

		flash.postid = "NEW"

		nav.sourceid = headline.id
		nav.sourcetype = Folder.TYPE_HEADLINES
		nav.pageSize = MAX_POSTS
		nav.curPage = 0
		nav.maxPage = 0
		nav.isLastPage = true
		nav.numPosts = 0
		nav.subscribed = false
		nav.start = 0
		nav.breadcrumbs = [ [link:true, controller:"folder", action:"list", id:discussion.folder.folderKey, text:discussion.folder.description] ]
		nav.showfolders = false

		render 	view: "list",
				model:[
					headerText: headerText,
					discussion: discussion,
					posts: posts,
					user: user,
					nav: nav,
					folders: Folder.listOrderByDescription()]

	}

	@Secured(['ROLE_ADMIN'])
	def lock = {

		def discussion = Discussion.get(params.id)
		discussion.locked = true
		discussion.save(flush: true)

		if(params.return) {
			redirect2 url: URLDecoder.decode(params.return)
		}
		else {
			redirect2 controller: "discussion", action: "list", id: discussion.id, params: [start: params.start], fragment: params.frag
		}

	}

	@Secured(['ROLE_ADMIN'])
	def unlock = {

		def discussion = Discussion.get(params.id)
		discussion.locked = false
		discussion.save(flush: true)

		if(params.return) {
			redirect2 url: URLDecoder.decode(params.return)
		}
		else {
			redirect2 controller: "discussion", action: "list", id: discussion.id, params: [start: params.start], fragment: params.frag
		}

	}

	@Secured(['ROLE_ADMIN'])
	def premoderate = {

		def discussion = Discussion.get(params.id)
		discussion.premoderate = true
		discussion.save(flush: true)

		if(params.return) {
			redirect2 url: URLDecoder.decode(params.return)
		}
		else {
			redirect2 controller: "discussion", action: "list", id: discussion.id, params: [start: params.start], fragment: params.frag
		}

	}

	@Secured(['ROLE_ADMIN'])
	def unpremoderate = {

		def discussion = Discussion.get(params.id)
		discussion.premoderate = false
		discussion.save(flush: true)

		if(params.return) {
			redirect2 url: URLDecoder.decode(params.return)
		}
		else {
			redirect2 controller: "discussion", action: "list", id: discussion.id, params: [start: params.start], fragment: params.frag
		}

	}

	@Secured(['ROLE_USER'])
	def getlastupdated = {
		def discussion = Discussion.get(params.id)
		render discussion.lastPost.getTime()
	}

	@Secured(['ROLE_USER'])
	def getpostssince = {

		def discussion = Discussion.get(params.id)
		def lastUpdated = new Date(params.long("lastUpdated"))
		def posts = Post.findAllByDiscussionAndCreatedDateGreaterThan(discussion, lastUpdated)

		def nav = [start: discussion.postCount - posts.size() + 1]
		def counter = 0

		if(posts.size()) {


			def user = springSecurityService.currentUser
			def bookmark = UserDiscussion.findByUserAndDiscussion(user, discussion) ?: new UserDiscussion(user:user, discussion:discussion, lastUpdated: new Date())

			bookmark.lastPost = discussion.lastPost
			bookmark.lastPostCount = discussion.postCount;

			bookmark.save(flush:true)

			posts.each {
				def post = it
				if(!post.user.isIgnoredBy(user)) {
					render template: "/common/postbody", model: [post: post, discussion: discussion, posts: posts, nav: nav, counter: counter]
					counter++
				}
			}
		}
		else {
			render "<div />"
		}

	}

	@Secured(['ROLE_USER'])
	def getnumpostssince = {

		def discussion = Discussion.get(params.id)
		def lastUpdated = new Date(params.long("lastUpdated"))
		def user = springSecurityService.currentUser

		def posts = Post.findAllByDiscussionAndCreatedDateGreaterThan(discussion, lastUpdated)
		def counter = 0
		posts.each {
			if(!it.user.isIgnoredBy(user)) {
				counter++
			}
		}

		render counter.toString()


	}

	@Secured(['ROLE_USER'])
	def getpostsafter = {

		def discussion = Discussion.get(params.id)
		def lastPostId = params.int("lastPostId")
		def posts = Post.findAllByDiscussionAndIdGreaterThan(discussion, lastPostId)

		if(posts.size()) {


			def user = springSecurityService.currentUser

			def lastPost = posts[posts.size() - 1]
			discussionService.updateBookmark(lastPost, discussion)

			posts.each {

				def post = it

				def postItem = new PostListItem(id: post.id,
					userId: post.user.id,
					showModerationReport: (post.status == 1 || post.status == 4 || post.moderationScore > 0),
					isLastPost : true,
					postNum: post.postNum,
					createdDate: post.createdDate,
					status: post.status)

				def markup = postTagLib.buildCachedPost(postItem, user, post.discussion.postCount, post).toString()
				render markup

			}
		}
		else {
			render "<div />"
		}

	}

	@Secured(['ROLE_ADMIN'])
	def blockUserFromDiscussion = {

		def discussion = Discussion.get(params.id)
		def user = User.get(params.userId)

		def discussionUser = DiscussionUser.findByDiscussionAndUser(discussion, user)
		if(discussionUser) {
			discussionUser.userStatus = DiscussionUser.STATUS_BLOCKED
		}
		else {
			discussionUser = new DiscussionUser(discussion: discussion, user:user, userStatus: DiscussionUser.STATUS_BLOCKED)
		}

		discussionUser.save(flush:true)

		render "OK"

	}

	@Secured(['ROLE_ADMIN'])
	def unblockUserFromDiscussion = {

		def discussion = Discussion.get(params.id)
		def user = User.get(params.userId)

		def discussionUser = DiscussionUser.findByDiscussionAndUser(discussion, user)
		if(discussionUser) {
			discussionUser.delete(flush:true)
		}

		render "OK"

	}

	@Secured(['ROLE_ADMIN'])
	def moveToPersonal = {

		def discussion = Discussion.get(params.id)

		def folder = Folder.get(34)
		discussion.folder = folder
		discussion.save(flush:true)

		def fp = FrontPageEntry.findByDiscussionId(discussion.id)
		fp.folderId = folder.id
		fp.folderKey = folder.folderKey
		fp.folderName = folder.description
		fp.save(flush:true)

		redirect2 url:discussion.canonicalUrl()

	}


}


