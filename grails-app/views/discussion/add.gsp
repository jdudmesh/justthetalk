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

<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"/>
	<title>New Discussion</title>

	<script type="text/javascript">
		function postToFolder(folderId) {
			$("#folderid").val(folderId);
		}
	</script>
</head>
<body>
  <div class="col-sm-6 col-sm-offset-3">

  	<g:form name="mainform" action="save" useToken="true" class="formwithmargin">

  		<div style="margin-bottom: 12px;">
			Title  <g:textField name="threadtitle" maxlength="128" style="width: 300px;" value="${nav.title}" /><br/>
		</div>

		<div style="margin-bottom: 12px;">
	  		<div  style="margin-bottom: 4px;">Your Point...</div>
	  		<g:textArea name="threadheader" cols="40" rows="10" class="posttextarea">${nav.header}</g:textArea>
  		</div>

  		<g:hiddenField name="folderid" value="${folder.id}"></g:hiddenField>
  		<g:hiddenField name="discussionid" value="${nav.discussionid}"></g:hiddenField>
  		<g:hiddenField name="edit" value="${nav.edit}"></g:hiddenField>

  		<div>
  			<g:if test="${nav.edit}">
  				<g:submitButton name="submit" value="Update Discussion" class="btn btn-primary" />
  			</g:if>
  			<g:else>
				<g:if test="${folder.type == com.notthetalk.Folder.TYPE_NORMAL || folder.type == com.notthetalk.Folder.TYPE_ADMIN}">
					<g:submitButton name="submit" value="Start Discussion" class="btn btn-primary" />
				</g:if>
				<g:else>

					<div class="btn-group">
						<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
							Post to folder... <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<g:each  var="f" in="${folders}">
								<li><a onclick="postToFolder(${f.id})">${f.description}</a></li>
							</g:each>
						</ul>
					</div>

				</g:else>
  			</g:else>
  		</div>

	</g:form>

	<div>
   		<g:if test="${flash.errorMessage}">
   			<div class="alert alert-danger">${flash.errorMessage}</div>
   		</g:if>
		<g:hasErrors bean="${discussion}">
			<g:eachError var="err" bean="${discussion}">
				<g:beanErrorBootstrapAlert error="${err}" />
			</g:eachError>
		</g:hasErrors>
	</div>

  </div>
</body>
</html>