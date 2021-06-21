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
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" lang="en">
    <head>

        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <g:if test="${(flash.device == 'mobile' && flash.useNormalView == 'no')}">
        	<meta name="viewport" content="width=device-width" />
        </g:if>

        <title><g:layoutTitle default="JUSTtheTalk" /></title>

        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico?v=2')}" type="image/x-icon" />

		<link rel='stylesheet' href='${resource(dir:'js/bootstrap/css',file:'bootstrap.min.css')}' />
		<link rel='stylesheet' href='${resource(dir:'css',file:'bootstrap-dialog.css')}' />
		<link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />

		<g:if test="${(flash.device == 'mobile' && flash.useNormalView == 'no') || flash.device == 'normal'}">
			<link rel="stylesheet" href="${resource(dir:'css',file:'mobile.css')}" />
		</g:if>
		<g:if test="${flash.device == 'tablet'}">
			<link rel="stylesheet" href="${resource(dir:'css',file:'tablet.css')}" />
		</g:if>

		<!--[if lte IE 8]>
		<style type="text/css">
			.col-sm-3 {width: 242px; float: left;}
			.col-sm-6 {width: 440px; float: left;}
			.col-sm-9 {width: 682px; float: left;}
			.container {width:924px;}
		</style>
		<![endif]-->

		<script src="${resource(dir:'js',file:'jquery-1.10.2.min.js')}" type="text/javascript"></script>
		<script src="${resource(dir:'js/bootstrap/js',file:'bootstrap.min.js')}" type="text/javascript"></script>
		<script src="${resource(dir:'js',file:'bootstrap-dialog.js')}" type="text/javascript"></script>

		<script src="/socket.io/socket.io.js" type="text/javascript"></script>


        <g:layoutHead />

		<sec:ifLoggedIn>
			<script>
			  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

			  ga('create', 'UA-47267190-2', 'justthetalk.com');
			  ga('send', 'pageview');

			</script>
		</sec:ifLoggedIn>
		<sec:ifNotLoggedIn>
			<script type="text/javascript">
			  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

			  ga('create', 'UA-47267190-1', 'justthetalk.com');
			  ga('send', 'pageview');

			</script>
		</sec:ifNotLoggedIn>
    </head>
    <body>

		<g:bannerMessage />

		<div id="contentouter" class="container">


			<div id="content">

			<div id="logorow" class="row">

		   		<div id="header" class="col-sm-3">
		   			<g:link controller="home" action="index">
		   				<img id="toplogo" src="${resource(dir:'images',file:'logo3.png')}" alt="JUSTtheTalk"/>
		   			</g:link>
		   		</div>
				<div id="bannerdesc" class="col-sm-9">No smilies, no avatars, no flashing gifs. Just discuss the issues of the day, from last night's telly via football to science or philosophy.</div>


			</div>
			<div id="toolbar" class="row">

		   		<div id="topbar">

			    	<div id="contentheader" >

			    		<div>
			   				<div id="loginsection">
								<sec:ifNotLoggedIn>
								  <g:link controller="login" action="auth" rel="nofollow" class="btn btn-primary">Login</g:link> or
								  <g:link controller="signup" action="" rel="nofollow" class="btn btn-primary">Sign Up</g:link>
								</sec:ifNotLoggedIn>
								<sec:ifLoggedIn>
					    			<div>
					    				<sec:username />
					    				<g:link controller="logout" action="index" rel="nofollow" class="btn btn-primary">Sign Out</g:link>
					    			</div>
					    		</sec:ifLoggedIn>
			   				</div>

			    			<ol class="breadcrumb">

								<g:if  test="${folders}">
									<li>
										<div class="btn-group">
											<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
											<ul class="dropdown-menu" role="menu">
												<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MODERATOR">
													<li><g:link controller="folder" action="list" id="admin">Mod's Corner</g:link></li>
													<li role="presentation" class="divider"></li>
												</sec:ifAnyGranted>
												<g:each  var="f" in="${folders}">
													<g:if test="${f.type == 0}">
														<li><g:link uri="${f.canonicalUrl()}">${f.description}</g:link></li>
													</g:if>
												</g:each>
											</ul>
										</div>
									</li>
								</g:if>

				   				<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><g:link controller="home" action="index" class="headerTextLink" itemprop="url"><span itemprop="title">Home</span></g:link></li>
				   				<g:if test="${nav}">
					   				<g:each var="crumb" in="${nav.breadcrumbs }">
					   					<g:if test="${crumb.link }">
					   						<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
					   							<g:link controller="${crumb.controller }" action="${crumb.action }" id="${crumb.id }" class="headerTextLink" itemprop="url">
					   								<span itemprop="title">${crumb.text}</span>
					   							</g:link>
					   						</li>
					   					</g:if>
					   					<g:else>
					   						<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><span itemprop="title">${crumb.text }</span></li>
					   					</g:else>
					   				</g:each>
				   				</g:if>

			   				</ol>


			    		</div>


		  			<div id="headerText">
		  			</div>

			    	</div>

				</div>
			</div>

			<div class="row">

	   			<g:layoutBody />

				<div id="rightcontent" class="col-sm-3">
					<h4>Tools</h4>
					<ul class="list-unstyled flowlist">
						<li><g:link controller="home" action="index">Home</g:link></li>

						<sec:ifLoggedIn>
							<li><g:link controller="home" action="bio">Profile</g:link></li>
							<li><g:link controller="subscriptions" action="check">Subscriptions</g:link></li>
							<li><g:link controller="search" action="index">Search</g:link></li>
						</sec:ifLoggedIn>

						<li><g:link controller="home" action="charter">Charter</g:link></li>
						<li><g:link controller="home" action="help">Help</g:link></li>
						<li><g:link controller="home" action="policy">Policy</g:link></li>
						<li><g:link controller="home" action="terms">Terms &amp; Conditions</g:link></li>
						<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MODERATOR">
							<li><g:link controller="admin" action="moderate">Moderate</g:link></li>
							<sec:ifAnyGranted roles="ROLE_ADMIN">
								<li><g:link controller="admin" action="modhistory">Mod History</g:link></li>
								<li><g:link controller="admin" action="premods">Who's on Pre-mod</g:link></li>
								<li><g:link controller="admin" action="recentusers">Recent Signups</g:link></li>
								<li><g:link controller="admin" action="reports">Reports</g:link></li>
							</sec:ifAnyGranted>
						</sec:ifAnyGranted>

					</ul>
					<g:donationFrontPage />
				</div>
    		</div>
    	</div>

    	<g:if test="${flash.device == 'mobile'}">
	    	<div class="row">
	    		<div class="alert alert-success">
	    			<g:if test="${flash.useNormalView == 'no'}">
	    				<div class="centretext">You are using the mobile version of this site.</div>
	    				<div class="centretext"><g:link controller="home" action="switchview" params="${['view':'normal', 'ret':request.forwardURI]}" class="">Switch to the normal version</g:link></div>
	    			</g:if>
	    			<g:else>
	    				<div class="centretext">You are using the normal version of this site.</div>
	    				<div class="centretext"><g:link controller="home" action="switchview" params="${['view':'mobile', 'ret':request.forwardURI]}" class="">Switch to the mobile version</g:link></div>
	    			</g:else>
	    		</div>
	    	</div>
    	</g:if>

    	</div>

    </body>
</html>