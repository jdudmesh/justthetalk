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
	<meta name="layout" content="main"></meta>
	<title>Sign Up Here</title>
</head>
<body>

	<div class="col-sm-9">

		<p>
		Welcome to JUSTtheTalk - the new name for NOTtheTalk. We are a community of individuals who enjoy discussing anything and everything. There are
		no limits to what can be talked about here but we recommend that you read our charter and terms and conditions
		before you sign up.
		</p>


		<g:form name="signup" action="save" class="form-horizontal" role="form">

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
					<input type='password' name='password' id='password' class="text_ form-control" placeholder="Password"/>
					(Between 6 and 12 characters)
				</div>
			</div>

			<div class="form-group">
				<label for="newPasswordConfirm" class="col-sm-4 control-label">Confirm Password</label>
				<div class="col-sm-4"><input type='password' name='passwordConfirm' id='passwordConfirm' class="text_ form-control" placeholder="Confirm Password"/></div>
			</div>

			<div class="form-group">
  					<div class="col-sm-offset-4 col-sm-6">
  						<label>
  						<g:checkBox name="checkBoxAccept" value="${false}" /> I accept the <g:link controller="home" action="terms">Terms &amp; Conditions</g:link>
					</label>
				</div>
			</div>

                        <div class="form-group">
                                <div class="col-sm-offset-4 col-sm-4">
                                        <recaptcha:ifEnabled>
                                                <recaptcha:recaptcha theme="dark"/>
                                        </recaptcha:ifEnabled>
                                </div>

                        </div>

			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4">
					<g:submitButton name="submit" value="Sign up now..." class="btn btn-primary"/>
				</div>
			</div>


			<g:hiddenField name="bio" value="" />

		</g:form>

		<div>
			<g:hasErrors bean="${user}">
				<g:eachError var="err" bean="${user}">
					<g:beanErrorBootstrapAlert error="${err}" />
				</g:eachError>
			</g:hasErrors>
		</div>
		<div>
			<h4>Your Data Privacy</h4>
			<p>On May 25th 2018 the EU's General Data Protection Regulation (GDPR) comes into force. This new legislation gives you more control and greater protections around how your personal data can be stored and used. For more information about how this relates to your use of JUSTtheTalk please refere to our privacy policy <a href="https://justthetalk.com/home/policy">here</a></p>
		</div>

	</div>

</body>
</html>
