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
<title>Forgotten Password</title>
</head>
<body>

  	<div class="col-sm-6">
  		<h4>Request a new password</h4>

  		<div>
	  		<p>If you have forgotten your password then please enter your user name and e-mail address in the box below and click 'Send'. You must use the e-mail address you used when you signed up to JUSTtheTalk.</p>
	  		<p>You will receive an e-mail which contains a link which will allow you to reset your password.</p>
  		</div>

  		<g:form action="recoverpassword" name="recoverpassword" class="form-horizontal" role="form">

					<div class="form-group">
						<label for="username" class="col-sm-4 control-label">Your user name</label>
						<div class="col-sm-5"><g:textField name="username" maxlength="24" class="text_ form-control" placeholder="User Name"></g:textField></div>
					</div>

					<div class="form-group">
						<label for="email" class="col-sm-4 control-label">E-mail address</label>
						<div class="col-sm-4"><g:textField name="email" maxlength="64" class="text_ form-control" placeholder="E-Mail Address"></g:textField></div>
					</div>

					<div class="form-group">
    					<div class="col-sm-offset-4 col-sm-4">
    						<g:submitButton name="submit" value="Get Password" class="btn"/>
    					</div>
    				</div>

  		</g:form>

  		<br/>

  		<g:if test="${flash.actionmessage}">
  			<div class="alert alert-danger">${flash.actionmessage}</div>
  		</g:if>

	</div>

</body>
</html>