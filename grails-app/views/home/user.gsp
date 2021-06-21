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
<title>JUSTtheTalk - ${user.username}</title>
<meta name="ROBOTS" content="NOINDEX, NOFOLLOW">
</head>
<body>

	<div class="col-sm-9">


		<sec:ifLoggedIn>
			<g:if test="${!flash.isSelf }">
				<g:if test="${flash.isIgnored }">
					<div class="alert alert-warning">You are ignoring this user. Visit your profile page to stop ignoring them.</div>
				</g:if>
				<g:else>
					<div>
						<g:link controller="post" action="ignoreuser" id="${user.id}" class="btn btn-warning">Hide posts from this user</g:link>
					</div>
					<br/>
				</g:else>
			</g:if>
		</sec:ifLoggedIn>

  		<div>
	  		<table>
	  			<g:if test="${user.displayEmail}">
		  			<tr>
		  				<td style="width:300px">E-Mail Address</td><td>${user.email }</td>
		  			</tr>
		  		</g:if>
		  		<g:else>
			  		<sec:ifAnyGranted roles="ROLE_ADMIN">
			  			<tr style="vertical-align: top;">
			  				<td style="width:200px">E-Mail Address</td><td>${user.email }
			  					<g:if test="!${user.displayEmail}">
			  						<div class="alert alert-danger">You're only seeing this because you're an admin</div>
			  					</g:if>
			  				</td>
			  			</tr>
			  		</sec:ifAnyGranted>
		  		</g:else>
		  		<sec:ifAnyGranted roles="ROLE_ADMIN">
		  			<tr>
		  				<td>Sign-up date</td><td><g:formatDate format="dd/MM/yyyy" date="${user.createdDate}"/></td>
		  			</tr>
		  			<tr>
		  				<td>Moderation Score</td><td>${flash.moderationScore}</td>
		  			</tr>
		  			<tr><td colspan="2">&nbsp;</td></tr>
		  			<tr>
		  				<td colspan="2">
		  					<g:if test="${user.options.premoderate}">
		  						<g:link controller="admin" action="unmoderateuser" id="${user.id}" class="btn btn-success">Remove from pre-moderation</g:link>
		  					</g:if>
		  					<g:else>
		  						<g:link controller="admin" action="moderateuser" id="${user.id}" class="btn btn-warning">Pre-moderate</g:link>
		  					</g:else>
		  					<g:if test="${user.options.watch}">
		  						<g:link controller="admin" action="unwatchuser" id="${user.id}" class="btn btn-success">Remove from watch list</g:link>
		  					</g:if>
		  					<g:else>
		  						<g:link controller="admin" action="watchuser" id="${user.id}"  class="btn btn-warning">Put on watch list</g:link>
		  					</g:else>
		  					<g:if test="${user.accountLocked}">
		  						<g:link controller="admin" action="unlockuser" id="${user.id}"  class="btn btn-success">Unlock User</g:link>
		  					</g:if>
		  					<g:else>
		  						<g:link controller="admin" action="lockuser" id="${user.id}"  class="btn btn-danger">Lock User</g:link>
		  					</g:else>
		  					<g:if test="${user.enabled}">
		  						<g:link controller="admin" action="deleteuser" id="${user.id}"  class="btn btn-danger">Delete User</g:link>
		  					</g:if>
		  					<g:else>
		  						<g:link controller="admin" action="undeleteuser" id="${user.id}"  class="btn btn-success">Undelete User</g:link>
		  					</g:else>
		  				</td>
		  			</tr>
		  			<tr><td colspan="2">&nbsp;</td></tr>
		  			<tr>
		  				<td colspan="2">
							<g:form name="user_${user.id}" controller="admin" action="resetpassword">
								Reset Password: <g:textField name="password" />
								<g:hiddenField name="userid" value="${user.id}" />
								<g:submitButton name="submit" value="Save" class="btn btn-primary"/>
							</g:form>
						</td>
					</tr>
		  		</sec:ifAnyGranted>
	  			<tr><td colspan="2">&nbsp;</td></tr>
	  			<tr>
	  				<td colspan="2">
	  					<div class="well">
		  					<h5>All about ${user.username}...</h5>
		  					<g:if test="${user.bio && user.bio.size() > 0}">
		  						<div>${user.bio}</div>
		  					</g:if>
		  					<g:else>
		  						<div>${user.username} has nothing to say</div>
		  					</g:else>
		  				</div>
	  				</td>
	  			</tr>
	  			<tr><td colspan="2">&nbsp;</td></tr>

	  		</table>

		</div>

		<sec:ifAnyGranted roles="ROLE_ADMIN">

			<div>
				<h2>Notes</h2>
				<g:if test="${modNotes == null || modNotes.size() == 0}">
					<div>No notes yet!</div>
				</g:if>
				<g:else>
					<table>
						<g:each in="${modNotes}" var="n">
							<tr>
								<td>
									<div style="text-decoration:underline"><g:formatDate format="dd/MM/yyyy HH:mm" date="${n.createdDate}"/> - ${n.mod.username}</div>
									<div>${n.note}</div>
								</td>
							</tr>
						</g:each>
					</table>
				</g:else>

				<g:form name="modnote" controller="home" action="addModNote" useToken="true">
					<div><g:textArea name="note" style="width:100%;height;40px;"></g:textArea></div>
					<br/>
					<g:hiddenField name="userid" value="${user.id}"></g:hiddenField>
					<g:submitButton name="submit" value="Add Note" class="btn btn-primary"/>
				</g:form>

			</div>

			<div>
				<h2>History</h2>
				<table>
					<tr><th style="width: 120px">Date</th><th style="width: 200px">Event</th><th  style="width: 100px"></th></tr>
					<g:each in="${history}" var="h">
						<tr>
							<td><g:formatDate format="yyyy-MM-dd HH:mm" date="${h.createdDate}"/></td>
							<td>${h.eventType}</td>
							<td>&#160;</td>
						</tr>
						<tr>
							<td>&#160;</td>
							<td colspan="2">${h.eventData}</td>
						</tr>
					</g:each>
				</table>
			</div>

			<div>
				<h2>Sockpuppets</h2>
				<g:if test="${sockpuppets.size() > 0}">
					<table>
						<tr><th style="width: 120px">Sockpuppet</th><th style="width: 120px">IP Address</th><th style="width: 200px">Location</th><th  style="width: 100px">Last Login</th></tr>
						<g:each in="${sockpuppets}" var="sock">
							<tr style='vertical-align: top;'>
								<td><g:link action="user" id="${sock.sockpuppet}">${sock.sockpuppet}</g:link></td>
								<td><g:link action="showip" id="${sock.ip_address}">${sock.ip_address}</g:link></td>
								<td><g:formatDate format="yyyy-MM-dd" date="${sock.last_login}"/></td>
							</tr>
						</g:each>
					</table>
				</g:if>
				<g:else>
					<div>None Found</div>
				</g:else>
			</div>

			<div>
				<h2>Logins</h2>
				<table>
					<tr><th style="width: 120px">IP Address</th><th style="width: 200px">Location</th><th  style="width: 100px">Last Login</th></tr>
					<g:each in="${logins}" var="login">
						<tr><td><g:link action="showip" id="${login.ipAddress}">${login.ipAddress}</g:link></td><td>${login.geoLocation}</td><td><g:formatDate format="yyyy-MM-dd" date="${login.lastLogin}"/></td></tr>
					</g:each>
				</table>
			</div>


		</sec:ifAnyGranted>

	</div>

</body>
</html>