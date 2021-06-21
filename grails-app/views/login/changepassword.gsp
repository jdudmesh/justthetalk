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
<title>Change Password</title>
</head>
<body>

  	<div class="col-sm-6">
  		<h4>Change Password</h4>

		<g:form name="savepassword" action="savechangedpassword" autocomplete="false" class="form-horizontal" role="form">

			<div class="form-group">
				<label for="newPassword" class="col-sm-4 control-label">New Password</label>
				<div class="col-sm-5">
					<input type='password' name='newPassword' id='newPassword' class="text_ form-control" placeholder="New Password"/>
					(Between 6 and 12 characters)
				</div>
			</div>

			<div class="form-group">
				<label for="newPasswordConfirm" class="col-sm-4 control-label">Confirm Password</label>
				<div class="col-sm-5"><input type='password' name='newPasswordConfirm' id='newPasswordConfirm' class="text_ form-control" placeholder="Confirm Password"/></div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4">
					<g:submitButton name="submit" value="Change Password" class="btn"/>
				</div>
			</div>

		</g:form>

  		<g:each var="err" in="${flash.errors }">
  			<div class="alert alert-danger">${err}</div>
  		</g:each>

  		<g:each var="err" in="${flash.errors }">
			<div class="rederror"><g:message code="${err }" /></div>
  		</g:each>

	</div>


</body>
</html>