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

		<div class="bordered threadnav">

			<div class="pull-right">
				<g:displayPages max="${nav.maxPage}" page="${nav.pageSize}" start="${nav.start}" cur="${nav.curPage}" discussionid="${discussion.id}" />
			</div>

			<div>
				<g:if test="${nav.start > 1}">
					<g:link uri="${discussion.canonicalUrl()}/${Math.max(nav.start - 20, 1)}">Previous</g:link>
				</g:if>
				<g:else>
					Previous
				</g:else>
				<div class="linkspacer">|</div>
				<g:if test="${!nav.isLastPage}">
					<g:link uri="${discussion.canonicalUrl()}/${Math.min(nav.start + 20, discussion.postCount)}">Next</g:link>
				</g:if>
				<g:else>
					Next
				</g:else>

				<div class="linkspacer">|</div>

				<g:if test="${discussion.id && discussion.postCount > 0}">
					<g:link uri="${discussion.canonicalUrl()}/1">Top</g:link>
				</g:if>
				<g:else>
					Top
				</g:else>

				<div class="linkspacer">|</div>

				<g:if test="${discussion.id && discussion.postCount > 0}">
					<g:link uri="${discussion.canonicalUrl()}/${Math.max(discussion.postCount - 19, 1)}#last">Bottom</g:link>
				</g:if>
				<g:else>
					Bottom
				</g:else>

				<sec:ifLoggedIn>
					<div class="linkspacer">|</div>
					<g:if test="${discussion.id}">
						<g:link uri="${discussion.canonicalUrl([do:'unread'])}">Unread</g:link>
					</g:if>
					<g:else>
						| Unread
					</g:else>
				</sec:ifLoggedIn>

				<sec:ifLoggedIn>
					<g:if test="${discussion.id}">
						<div class="linkspacer">|</div>
						<g:if test="${nav.subscribed}">
							<g:link action="unsubscribe" controller="subscriptions" id="${discussion.id}" params="[return: returnURLBottom]" rel="nofollow">Unsubscribe</g:link>
						</g:if>
						<g:else>
							<g:link action="subscribe" controller="subscriptions" id="${discussion.id}" params="[return: returnURLBottom]" rel="nofollow">Subscribe</g:link>
						</g:else>
					</g:if>
				</sec:ifLoggedIn>

			</div>

		</div>
