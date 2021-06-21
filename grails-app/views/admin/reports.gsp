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
<title>Reports</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker.css">
</head>
<body>

	<div class="col-sm-9">
		<div class="row">
  			<form id="datesForm" class="form-inline" method="POST">
				<div class="form-group">
    				<label for="startDate">Start Date</label>
    				<input type="text" class="form-control" id="startDate" name="startDate" value="${startDate}">
  				</div>
  				<div class="form-group">
    				<label for="endDate">End Date</label>
    				<input type="text" class="form-control" id="endDate" name="endDate" value="${endDate}">
  				</div>
  				<button id="dateSubmit" type="button" class="btn btn-default" style="margin-top: 25px;">Go...</button>
  				<input type="hidden" class="form-control" id="startDateF" name="startDateF">
  				<input type="hidden" class="form-control" id="endDateF" name="endDateF">
			</form>
		</div>

		<div class="row">
			<h4>Number of posts between selected dates: ${numPostsBetween}</h4>
		</div>
		<div class="row">
			<h4>Number of unique users between selected dates: ${numUsersBetween}</h4>
		</div>
		<div class="row">
			<h4>Number of reports between selected dates: ${numReportsBetween}</h4>
		</div>
		<div class="row">
			<h4>Report results between selected dates:</h4>
			<table>
				<g:each var="r" in="${numResults}">
					<tr>
						<td style="width: 200px">
							<g:if test="${r[0] == -1}">Deleted</g:if>
							<g:if test="${r[0] == 0}">Pending</g:if>
							<g:if test="${r[0] == 1}">Approved</g:if>
						</td>
						<td>${r[1]}</td>
					</tr>
				</g:each>
			</table>
		</div>

	</div>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {

			$("#startDate").datepicker({format: 'dd/mm/yyyy'});
			$("#endDate").datepicker({format: 'dd/mm/yyyy'});

			$("#dateSubmit").click(function() {

				var startDate = $("#startDate").datepicker("getDate");
				var endDate = $("#endDate").datepicker("getDate");
				if(!(startDate == null || endDate == null)) {
					var startDateF = moment(startDate).format("YYYY-MM-DD");
					var endDateF = moment(endDate).format("YYYY-MM-DD");
					$("#startDateF").val(startDateF);
					$("#endDateF").val(endDateF);
					$("#datesForm").submit();
				}


			});

		});
	</script>
</body>
</html>