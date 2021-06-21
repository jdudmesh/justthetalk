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
<html>
<head>
	<meta name="layout" content="main"/>

	<title>JUSTtheTalk - World View</title>

	<script src="${resource(dir:'js/polymaps',file:'polymaps.min.js')}" type="text/javascript"></script>
	<script src="${resource(dir:'js',file:'worldview.js')}" type="text/javascript"></script>

</head>
<body>

	<div id="maincontent" class="col-sm-9">
		<h4>Real Time Site Activity</h4>

		<div id="map_container" class="col-sm-9" style="width:100%; height: 640px;"></div>

	</div>

	<script type="text/javascript">

		var socket = null;

		$(document).ready(function() {

			socket = io.connect("${flash.proto == "HTTP" ? grailsApplication.config.notthetalk.eventsUrl : grailsApplication.config.notthetalk.eventsUrlSecure}");

			socket.on('connect', function (data) {
				socket.emit('subscribe', {topic: "hit"});
			});

			socket.on('update', function (msg) {
				console.log(msg);
			});

			$("#map_container").worldViewMap(socket, { from: "locations" });

		});

		function closeSocket() {
			socket.disconnect();
		}


	</script>

</body>
</html>
