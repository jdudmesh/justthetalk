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

import groovy.xml.MarkupBuilder

class ThreadNavTagLib {

	def displayPages = { attrs, body ->

		def w = new StringWriter()
		def b = new MarkupBuilder(new IndentPrinter(w, "", false))
		b.setDoubleQuotes(true)

		def map = [:]
		def max = attrs.int("max")
		def start = attrs.int("start")
		def page = attrs.int("page")
		def discussionId = attrs.int("discussionid")

		def discussion = Discussion.get(discussionId)
		if(!discussion || discussion.postCount == 0) {
			return
		}

		for( i in 0..(max > 5 ? 5 : max) ) {
			map[i] = true
		}

		for( i in (max - 5)..max ) {
			map[i] = true
		}

		def mid = (max / 2).toInteger()
		for( i in (mid - 2)..(mid + 2) ) {
			map[i] = true
		}

		def cur = (start / page).toInteger()
		map[cur - 1] = true
		map[cur] = true
		map[cur + 1] = true

		def lasti = -1

		b.div(class:"btn-group") {
			b.button(class:"btn btn-default btn-xs dropdown-toggle", type:"button", "data-toggle":"dropdown") {
				b.span("Page... ")
				b.b(class:"caret","")
			}

			b.ul(class:"dropdown-menu", role:"menu", style:"min-width:320px") {
				b.li() {
					b.a(href:discussion.canonicalUrl([do:"all"]), class:"pageitem", "All ")

					for( i in 0..max) {

						if(map[i]) {

							def outpage = i * page + 1

							if(i != lasti + 1) {
								b.span{
									mkp.yieldUnescaped("&hellip;")
								}
							}

							if(cur >= i && cur < (i + 1) ) {
								b.span {
									mkp.yield(i + 1)
								}

							}
							else {
								b.a(href:discussion.canonicalUrl() + "/$outpage", class:"pageitem", i + 1)
							}

							mkp.yield(" ")
							lasti = i
						}

					}
				}
			}

		}

		out << w.toString()
	}

	def displayNav = { attrs, body ->

		out << "Page "

		def map = [:]
		def x = attrs.max

		for( i in 0..(attrs.max > 2 ? 2 : attrs.max) ) {
			map[i] = true
		}

		for( i in (attrs.max - 2)..attrs.max ) {
			map[i] = true
		}

		def cur = (attrs.curidx / attrs.page).toInteger()
		map[cur - 1] = true
		map[cur] = true
		map[cur + 1] = true

		def lasti = -1
		for( i in 0..attrs.max) {

			if(map[i]) {

				def page = i * attrs.page

				if(i != lasti + 1) {
					out << "&hellip; "
				}

				if(cur >= i && cur < (i + 1) ) {
					out << i + 1 << " "
				}
				else {
					out << link([action: "list", controller: "discussion", id: attrs.discussionid, params: ["start":page]],{ i + 1 })
					out << " "
				}

				lasti = i

			}

		}
		//<g:link action="list" controller="discussion" id="${discussion.id}" params="[start:page]">${i }</g:link>

	}
}
