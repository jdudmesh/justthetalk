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

class FolderTagLib {

	def folderService

	def getFoldersJSON = { attrs, body ->

			def builder = new JSONBuilder()
			def folders = attrs.folders

			def result = builder.build {
				array {
					folders.each {
						def f = it
						if(f.type == 0) {
							folder = {
								id = f.id
								description = f.description
							}
						}
					}
				}
			}

			out << "<script type=\"text/javascript\">\r\n"
			out << "var folders = " << result.toString() << "\r\n"
			out << "</script>\r\n"


		}


	def paginateFolderList = { attrs, body ->

		def w = new StringWriter()
		def b = new MarkupBuilder(new IndentPrinter(w, "", false))
		b.setDoubleQuotes(true)


		def total = attrs.int("total")
		def id = attrs.id
		def max = attrs.int("max")
		def startPage = attrs.int("page")
		def totalPages = total.intdiv(max)

		def folderId = folderService.getIdForKey(id)
		def folder = Folder.get(folderId)

		def i = 0
		def page = startPage
		def curPage = startPage

		if(params.page) {
			curPage = Integer.parseInt(params.page)
		}

		if(curPage > startPage + 3) {
			page = curPage - 3
		}
		else {
			page = startPage
		}

		b.ul(class:"pagination pagination-sm") {
			if(totalPages > 10 && page > 1) {
				b.li {
					b.a(href:g.createLink(uri:folder.canonicalUrl([page:1])), 1)
				}
				b.li {
					b.span() {
						mkp.yieldUnescaped("&hellip;")
					}
				}
			}
			while(i < 5 && page <= totalPages) {

				b.li {
					if(page == curPage) {
						b.span(page)
					}
					else {0
						b.a(href:g.createLink(uri:folder.canonicalUrl([page:page])), page)
					}
				}

				i += 1
				page += 1
			}
			if(i < total) {
				b.li {
					b.span() {
						mkp.yieldUnescaped("&hellip;")
					}
				}
				b.li {
					b.a(href:g.createLink(uri:folder.canonicalUrl([page:totalPages])), totalPages)
				}
			}
		}

		out << w.toString()
	}
}
