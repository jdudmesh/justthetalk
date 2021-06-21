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

<g:if test="${(flash.device == 'mobile' && flash.useNormalView == 'no')}">
	<g:set var="classes" value="panel-collapse collapse" />
</g:if>
<g:else>
	<g:set var="classes" value="" />
</g:else>

<div id="folders" class="col-sm-3">

	<div class="" id="folder-accordion">
		<div>
			<div>
				<h4>
					<g:if test="${(flash.device == 'mobile' && flash.useNormalView == 'no')}">
						<a id="folder-accordian-heading1" data-toggle="collapse" data-parent="folder-accordion" href="#folder-accordion1"><span id="folder-collapse-icon1" class="glyphicon glyphicon-chevron-right"></span> Topics</a>
					</g:if>
					<g:else>Topics</g:else>
				</h4>
			</div>
			<div id="folder-accordion1" class="${classes}">
				<div class="">

					<sec:ifAnyGranted roles="ROLE_ADMIN">
						<ul class="list-unstyled flowlist">
							<li><g:link action="list" controller="folder" id="mod">Mod's Corner</g:link><br />
							</li>

							<sec:ifAnyGranted roles="ROLE_ADMIN">
								<li><g:link action="listdeleted" controller="folder">Deleted Threads</g:link><br />
								</li>
							</sec:ifAnyGranted>
						</ul>
					</sec:ifAnyGranted>

					<ul class="list-unstyled flowlist">
						<li><g:link action="headlines" controller="folder">Headlines</g:link></li>
						<li><g:link action="twitter" controller="folder">Twitter</g:link></li>
					</ul>

					<ul class="list-unstyled flowlist">
						<g:each var="folder" in="${folders}">
							<li>
								<g:link uri="${folder.canonicalUrl()}">${folder.description}</g:link>
							</li>
						</g:each>
					</ul>

				</div>
			</div>
		</div>

		<div class="">
			<div class="">
				<h4 class="">
					<g:if test="${(flash.device == 'mobile' && flash.useNormalView == 'no')}">
						<a id="folder-accordian-heading2" data-toggle="collapse" data-parent="folder-accordion" href="#folder-accordion2"><span id="folder-collapse-icon2" class="glyphicon glyphicon-chevron-right"></span> Tags</a>
					</g:if>
					<g:else>Tags</g:else>
				</h4>
			</div>
			<div id="folder-accordion2" class="${classes}">
				<div class="">
					<ul class="list-unstyled flowlist">
						<g:each var="tag" in="${tags}">
							<li><g:link action="list" controller="tags" id="${tag.tag}">${tag.tag}</g:link></li>
						</g:each>
					</ul>
				</div>

			</div>
		</div>
	</div>

</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#folder-accordion1').on('show.bs.collapse', function () {
			$('#folder-collapse-icon1').removeClass("glyphicon-chevron-right");
			$('#folder-collapse-icon1').addClass("glyphicon-chevron-down");
		});
		$('#folder-accordion1').on('hide.bs.collapse', function () {
			$('#folder-collapse-icon1').removeClass("glyphicon-chevron-down");
			$('#folder-collapse-icon1').addClass("glyphicon-chevron-right");
		});
		$('#folder-accordion2').on('show.bs.collapse', function () {
			$('#folder-collapse-icon2').removeClass("glyphicon-chevron-right");
			$('#folder-collapse-icon2').addClass("glyphicon-chevron-down");
		});
		$('#folder-accordion2').on('hide.bs.collapse', function () {
			$('#folder-collapse-icon2').removeClass("glyphicon-chevron-down");
			$('#folder-collapse-icon2').addClass("glyphicon-chevron-right");
		});
	});
</script>