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

<h4>Current Discussion Subscriptions</h4>
<g:if test="${discussionSubs == null || discussionSubs.size() == 0}">
	You don't have any discussion subscriptions at the moment<br/>
</g:if>
<g:else>
	<p style="font-style:italic;">
		To unsubscribe tick the appropriate discussions and click the "Unsubscribe" button at the bottom of the list.
	</p>


	<g:form name="unsubscribe" controller="subscriptions" action="unsubselected" useToken="true">
		<ul class="list-unstyled">
			<g:each var="sub" in="${discussionSubs}">
				<li>
					<g:discussionTitle header="${sub}" max="1000" showfolders="${true}" showUnsub="${true}" />
				</li>
			</g:each>
		</ul>
		<g:submitButton name="submit" value="Unsubscribe Selected Subscriptions" class="btn btn-primary" />
	</g:form>

	<br/>
	<div>
	Sort by:<br/>
	<g:link controller="subscriptions" action="sort" params="[order:0]">Folder</g:link>
	| <g:link controller="subscriptions" action="sort" params="[order:1]">Discussion Title</g:link>
	| <g:link controller="subscriptions" action="sort" params="[order:2]">Discussion Created</g:link>
	| <g:link controller="subscriptions" action="sort" params="[order:3]">Most Recent</g:link>
	</div>


</g:else>
<br/>
<h3>Current Folder Subscriptions</h3>
<g:if test="${folderSubs == null || folderSubs.size() == 0}">
	You don't have any discussion subscriptions at the moment
</g:if>
<g:else>
	<ul class="list-unstyled">
		<g:each var="sub" in="${folderSubs}">
			<li class="discussionlistitem">
				<g:set var="fid" value="${sub.folderId}" />
				<g:link uri="/${sub.folder.folderKey}">
					${sub.folder.description}
				</g:link>
				 <g:link controller="folder" action="unsubscribe" id="${fid}" class="btn btn-xs btn-primary">Unsubscribe</g:link>
			</li>
		</g:each>
	</ul>
</g:else>
