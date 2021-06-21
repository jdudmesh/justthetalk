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
<title>Password Reset</title>
</head>
<body>

  	<div class="centrecolumn-nofolders">
  		<h4>Reset Password</h4>

		<g:form name="savepassword" action="savepassword" autocomplete="false" class="form-horizontal" role="form">

			<div class="form-group">
				<label for="username" class="col-sm-4 control-label">Your user name</label>
				<div class="col-sm-5">
					<g:textField name="username" maxlength="24" class="text_ form-control" placeholder="User Name"></g:textField>
					(Between 6 and 24 characters, letters and numbers only)
				</div>
			</div>

			<div class="form-group">
				<label for="email" class="col-sm-4 control-label">E-mail address</label>
				<div class="col-sm-4"><g:textField name="email" maxlength="64" class="text_ form-control" placeholder="E-Mail Address"></g:textField></div>
			</div>

			<div class="form-group">
				<label for="newPassword" class="col-sm-4 control-label">New Password</label>
				<div class="col-sm-4">
					<input type='password' name='newPassword' id='newPassword' class="text_ form-control" placeholder="New Password"/>
					(Between 6 and 12 characters)
				</div>
			</div>

			<div class="form-group">
				<label for="newPasswordConfirm" class="col-sm-4 control-label">Confirm Password</label>
				<div class="col-sm-4"><input type='password' name='newPasswordConfirm' id='newPasswordConfirm' class="text_ form-control" placeholder="Confirm Password"/></div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4">
					<g:submitButton name="submit" value="Reset Password" class="btn"/>
				</div>
			</div>


			<g:hiddenField name="resettoken" value="${flash.resettoken }" />

		</g:form>

  		<g:each var="err" in="${flash.errors }">
  			<div class="alert alert-danger">${err}</div>
  		</g:each>

	</div>

</body>
</html>