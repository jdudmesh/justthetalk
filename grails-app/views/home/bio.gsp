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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<title>Your Profile</title>
<meta name="ROBOTS" content="NOINDEX, NOFOLLOW">
</head>
<body>

	<div class="col-sm-6 col-sm-offset-3">

  		<g:form name="savebio" action="savebio">

	  		<div>
	  			<div class="form-group">
	  				<label for="email">E-Mail Address</label>
	  				<g:textField id="email" name="email" maxlength="64" value="${user.email }" />
	  			</div>
	  			<div class="form-group">
	  				<label>
	  					<g:checkBox name="displayemail" value="${user.displayEmail}" /> Show e-mail to the world?*
	  				</label>
	  			</div>
	  			<div class="form-group">
	  				<g:if test="${!user.hasFacebook()}">
						<g:link controller="facebook" action="connect">
	  						<img id="facebook-login" src="${resource(dir:'images',file:'facebook-login.png')}"/>
	  					</g:link>
	  				</g:if>

	  				<g:if test="${!user.hasTwitter()}">
 							<g:link controller="twitter" action="connect">
 								<img id="twitter-login" src="${resource(dir:'images',file:'sign-in-with-twitter-l.png')}"/>
 							</g:link>
	  				</g:if>
				</div>
	  			<div class="form-group">
	  				<label for="bio">Say something about yourself...</label>
	  				<g:textArea id="bio" name="bio" class="biotext">${user.bio}</g:textArea>
	  			</div>

			</div>
			<div>
			* We don't recommend that you reveal your main e-mail address here - create a free GMail or Hotmail account based on your user name and use that instead.
			</div>

			<g:hiddenField name="userid" value="${user.id}"></g:hiddenField>

			<div>
				<h4>Options</h4>
	  			<div class="form-group">
	  				<label>
	  					<g:checkBox name="autosubs" value="${user.options.autoSubs}" /> Automatically subscribe to threads I post on
					</label>
				</div>
	  			<div class="form-group">
	  				<label>
	  					<g:checkBox name="sortfolders" value="${user.options.sortFoldersByActivity}" /> Sort folder list by activity
					</label>
				</div>
				<!--  <li><g:checkBox name="markdown" value="${user.options.markdown}" /> Use markdown</li>  -->
			</div>
			<br/>
	  		<div><g:submitButton name="submit" value="Update Details" class="btn btn-primary"/></div>


	  		<br/>

	  		<g:if test="${flash.actionmessage }">
	  			<div class="alert alert-danger">${flash.actionmessage }</div>
	  		</g:if>
			<div>
				<g:hasErrors bean="${user}">
					<g:eachError var="err" bean="${user}">
						<g:beanErrorBootstrapAlert error="${err}" />
					</g:eachError>
				</g:hasErrors>
			</div>


  		</g:form>

  		<div>
  			<g:link controller="login" action="changepassword">Change password...</g:link>
  		</div>

  		<br/>

  		<h4>Ignored Users</h4>
  		<g:if test="${user.ignores.size() }">
  			<g:each var="ignored" in="${user.ignores }">
  				<div>
  					${ignored.ignoredUser.username } <g:link controller="post" action="unignoreuser" id="${ignored.ignoredUser.id}">(click here to stop ignoring)</g:link>
  				</div>
  			</g:each>
  		</g:if>
  		<g:else>
  			You haven't ignored any users!
  		</g:else>
  		<br/><br/>

  		<g:render template="/common/subslist" bean="${subscriptions}" />

	</div>

</body>
</html>