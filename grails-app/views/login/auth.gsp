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

<head>
<meta name='layout' content='main' />
<title>Login</title>
</head>

<body>

	<div class="col-sm-6 col-sm-offset-3">

		<div id='login'>
			<div class='inner'>

				<g:if test='${flash.message}'>
					<div class='alert alert-danger'>${flash.message}</div>
				</g:if>

				<h4>Login...</h4>

				<form action="https://${request.getHeader('Host')}${raw(postUrl)}" method='POST' id='loginForm' class="form-horizontal" role="form" autocomplete='off'>

					<div class="form-group">
						<label for="j_username" class="col-sm-4 control-label">User Name</label>
						<div class="col-sm-6"><input type='text' name='j_username' id='j_username' class="text_ form-control" placeholder="User Name"/></div>
					</div>

					<div class="form-group">
						<label for="j_password" class="col-sm-4 control-label">Password</label>
						<div class="col-sm-4"><input type='password' name='j_password' id='j_password' class="text_ form-control" placeholder="Password"/></div>
					</div>

					<div class="form-group">
    					<div class="col-sm-offset-4 col-sm-6">
    						<label>
	    						<input type='checkbox' class='chk' name='_spring_security_remember_me' id='remember_me'
									<g:if test='${hasCookie}'>checked='checked'</g:if> /> Remember me
							</label>
						</div>
					</div>

					<div class="form-group">
    					<div class="col-sm-offset-4 col-sm-4">
    						<input type='submit' value='Login' class="btn btn-primary"/>
    					</div>
    				</div>

				</form>

				<br/>

				<g:link controller="login" action="forgotpassword">I forgot my password...</g:link>

			</div>
			<div>
				<h4>Your Data Privacy</h4>
				<p>On May 25th 2018 the EU's General Data Protection Regulation (GDPR) comes into force. This new legislation gives you more control and greater protections around how your personal data can be stored and used. For more information about how this relates to your use of JUSTtheTalk please refere to our privacy policy <a href="https://justthetalk.com/home/policy">here</a></p>
			</div>
		</div>

	</div>

<!--
<script type='text/javascript'>
	$(document).ready(function(){
		$("#j_username").focus();
	});
</script>
-->
</body>
