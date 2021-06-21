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

<%@ page contentType="text/html;charset=ISO-8859-1" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<title>Report Post</title>
</head>
<body>

	<div class="col-sm-9" style="margin-bottom:128px;">

		<p>We will generally only remove posts that are defamatory, racist, homophobic, misogynistic, incite hatred
		or are of a commercial nature. The nature of free speech is such that you are free to disagree
		with other points of view, points of view which you may find offensive but you are not free to
		curtail them.</p>
		<br/>
		<p>Occasionally some posters resort to personal abuse. This can be deeply unpleasant and you
		should use the "Ignore" (see the <g:link controller="home" action="help">Help</g:link> page) feature to block posters who you feel are being abusive towards you. In
		the event that abuse becomes persistent bullying, please report the posts to us.</p>
		<br/>
		<p>In all cases the decision of the moderators is final.</p>
		<br/>
		<div style="text-decoration: underline;font-weight: bold;">Post</div>
		<br/>
		<div class="well", style="width:460px;">
			<p>Folder: ${post.discussion.folder.description }</p>
			<p>Discussion: ${post.discussion.header }</p>
			<br/>
			<p style="text-decoration: underline;">Post Content:</p>
			<p id="post_${post.id}">
				<g:formatPost text="${post.text}" />
			</p>
		</div>

		<div class="bordered">
			<h4>Report Post</h4>
	  		<g:form action="savereport" name="reportform" class="form-horizontal" role="form" id="${post.id }">

						<div class="form-group">
							<label for="username" class="col-sm-4 control-label">Your name</label>
							<div class="col-sm-5"><g:textField name="username" maxlength="64" class="text_ form-control" placeholder="User Name"></g:textField></div>
						</div>

						<div class="form-group">
							<label for="email" class="col-sm-4 control-label">E-mail address</label>
							<div class="col-sm-4"><g:textField name="email" maxlength="64" class="text_ form-control" placeholder="E-Mail Address"></g:textField></div>
						</div>

						<div class="form-group">
							<label for="comment" class="col-sm-4 control-label">Please explain why you are reporting this post</label>
							<div class="col-sm-4"><g:textArea name="comment" id="comment" class="posttextarea" maxlength="512">${report.comment }</g:textArea></div>
						</div>

						<div class="form-group">
							<div class="col-sm-offset-4 col-sm-4">
								<recaptcha:ifEnabled>
									<recaptcha:recaptcha theme="blackglass" />
									<recaptcha:ifFailed />
								</recaptcha:ifEnabled>
							</div>
						</div>

						<div class="form-group">
	    					<div class="col-sm-offset-4 col-sm-4">
	    						<g:submitButton name="submit" value="Report Post" class="btn"/>
	    					</div>
	    				</div>

					<g:hiddenField name="postid" value="${post.id }" />
	  		</g:form>

			<div>
				<g:hasErrors bean="${report}">
					<g:eachError var="err" bean="${report}">
						<g:beanErrorBootstrapAlert error="${err}" />
					</g:eachError>
				</g:hasErrors>
			</div>
			<g:if test="${flash.message}">
				<div class="alert alert-danger">${flash.message}</div>
			</g:if>

		</div>

	</div>


</body>
</html>