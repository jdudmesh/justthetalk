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

import org.apache.commons.lang.math.NumberUtils

@Mixin(ProxyAwareControllerMixin)
class CannonicalController {

	def folderService

    def index() {

		def folderId = folderService.getIdForKey(params.folderKey)
		def discussionId = null
		def discussionHeader = null
		def postNum = null

		if(folderId) {

			//def folder = Folder.get(folderId)

			if(params.discussionId) {

				if(!NumberUtils.isNumber(params.discussionId)) {
					render status:400, text:"Invalid discussion id"
					return
				}

				discussionId = Long.parseLong(params.discussionId)
				if(discussionId) {

					discussionHeader = params.discussionHeader

					if(params.postNum) {
						postNum = Integer.parseInt(params.postNum)
					}

					def discussion = Discussion.get(discussionId)
					assert discussion

					if(discussion.folder.id != folderId) {
						def location = g.createLink(uri:discussion.canonicalUrl())
						redirect2 url:location
						//redirect url:discussion.canonicalUrl()
					}
					else {

						if(postNum) {

							if(discussion.postCount == 0) {
								redirect2 discussion.canonicalUrl()
							}
							else if(postNum > discussion.postCount) {
								def location = g.createLink(uri:discussion.canonicalUrl() + "/$discussion.postCount")
								redirect2 discussion.canonicalUrl() + "/$discussion.postCount"
							}
							else if(postNum < 1) {
								def location = g.createLink(uri:discussion.canonicalUrl())
								redirect2 discussion.canonicalUrl()
							}
							else {
								forward controller:"discussion", action:"list", id:discussionId, params:[start: postNum]
							}

						}
						else {

							if(discussion.folder.id == folderId) {
								switch(params.do) {
									case "check":
										forward controller:"discussion", action:"check", id:discussionId
										break;
									case "unread":
										forward controller:"discussion", action:"unread", id:discussionId
										break;
									case "all":
										forward controller:"discussion", action:"all", id:discussionId
										break;
									default:
										forward controller:"discussion", action:"list", id:discussionId
										break;
								}

							}
						}
					}
				}

			}
			else {
				switch(params.do) {
					case "add":
						forward(controller:"discussion", action:"add", id:folderId)
						break;
					case "subscribe":
						forward(controller:"folder", action:"subscribe", id:folderId)
						break;
					case "unsubscribe":
						forward(controller:"folder", action:"unsubscribe", id:folderId)
						break;
					default:
						if(params.page) {
							def page = params.int("page")
							forward(controller:"folder", action:"list", id:params.folderKey, params:[page:page])
						}
						else {
							forward(controller:"folder", action:"list", id:params.folderKey)
						}
						break;
				}
			}


		}
		else {
			response.sendError(404)
		}

		//def folder = Folder.get(folderId)
		//def user = springSecurityService.currentUser


	}
}
