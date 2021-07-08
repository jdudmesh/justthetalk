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
  <div class="body">
  <div>
    <img alt="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQ0AAAA0CAYAAACQEG3ZAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAB1dJREFUeNrsXd116jgQFpy8Lx0s+8hTfCuIqSC5FYRUkFABUEG4FQAVhFSAU0HIE49xKli2Aq8mV96wDtgzsmRJZr5zdG5yI+tvNJ9mRrLcEULEKlUhlWl54m99mUYChykyXyTTrUw3qnxM+9YyrWTaGmqDCSxV22ohGwywcvqv3s5ul4rwMELK2wQSlZoGVZaHukfRtdp9zLLspAJlyNQrGQRsGVWAQdkQyjuWNhUTL2swxSZmmSSNqUwZIcUiTGwalM3UUR+nGvNZR9dq9xFIo5i6xDJuGlhlXg0oWqzKGQkGg2EUVNK4tkwYixJrhoqeKo+Jg8EwiAsNSwOUcW/Bx1tY6uNCxTi2rgZZuQobwiOzzm435enJaIOlYctFWVju5xOLmsFwRxqmXRRwH/qW+9lnN4XBcGtp9Ay24Z6YH9yMmaBvI92zuBmM+rjQfA6IY2nIAogI+VOZhuIrpvJOsFIilTc9R0FngwEQfVwYbyDgpLPb7Q2UnY9vUR5A7ntZxzbg4YvUQhmfWMT2ws15j6BI49oQaUTE/Fvx/yDslujaROdGGioIOxEl29gyD8hyRjkMpojiRllwZXKcqPy5Yq1kPesAhg7G65ZoWX/2T/w+ZLj3tF+PMj0g8t2d0vGuZsWmXBQqabxV/I6tr1OSZsQyk1NlSUVJZIJdkw2xzMnhQS3Nse3JZx9V3XFF3pFMrzL/CEkYD8rKWxBkmJPMk3z+teTw2bBENkONcSiT9fTEHMllNiLO81iNybuwf6ZJ1NBdDNYmYxrUyhlusECuKIdKvSgjDrAuZHpSq1WdReNTMeGUq2dj9kmeov7hQhibJ2F/V1DHeuojCWNvgzSuWS+9hq5SPyrX4xg2hhcLsKgWHhHGwkKZjx7NiVtkvueyP9a1NOq6KFcND9qVYGDIZnTEyphquJMoxcK6RZZNdlvk9SAMvX/kg2tSlzSER4PBsEiuUqnBpJ1YrK/MumkCtq2BiQcyxS7ylUHcuqTBLorfWIrfgd20pmtDsQRgws1VvXtCfQ+OxigS+B24vG9zQdsdiYXZs002dfWlKsNFzYYAe92xbp7EWE2WiLiagbKv6hJGZ7e7U5YClPdOeLZfY3GAeseqXtgSxx7hB3976rHJDvh10MY3oksDcyAJ3TUxQRr5Ntqe+eE78gNNUnmoj37IZ+tOsLeDdqTqnERPkzQosYzDlYpyoKsPbpCDi4Moca5Es29CNHex0DGMkLLfYqzSroEGsYviJ7YVv6OgcZnP/pCsNFyFptEzNL4+kwZWR1HWrQnS4PMa7UaTvrgL0ohaLr8/TLompkijx9ZGqxE1PMEZZoElDJRrYoo02Npg8KpfjUtH9WLdomdsgd2GG8ZgtAXUOd/zvD/olwgvWPYMw9ho7Ba12ewPAakgBHaZNBjnDsqbs6BYsai4aiBAkK4qYNJgnDsSZL5RC8kiBymWRCENyuEgBqMN6CuyuBXtjtuRiJASCC3emsVgtFmJ4BqAd2Vd9M+kz8ZJg+z7MBgBKs67wN12drakQY1pPAv+FACjHGOh/2EqV5Zs/jU+yo5I2jILBP0ODpU0EtYJRpUba+Blu6YBlgUlGAikCLsuf7OlgVsJ1oJPgDKQUBf4YFdkF586GBEJA+b/z4BEkBAIIcYYBjpbri9MGgyiUk4IE3zYcPsor8bDohna/TFb06Shc4ycg6GMNoFiZSxFeDuI/wh8jAlFoDqkkQqHX2BnMBySxkegfUyQ+cDSqDyL1bXcCAwBNYmUdYRR09QPES+EvJWujC5prAx1pmnm/uB5zzhDUBb5ShdFlzTQF3YwggfLOXzsCXK0ZmmYclGoQaXizU5/Wq6P0SxpvPBwO7c2IMbTs0UazwY6QvURi0Gr/pn4pCGTBuXGKt9JPeQXNo3FNeqQhomt10TQPzoTH/kZOyGTQAR86UtD1I3iaY0JFxHng8+40uxXSJZGsZ/fUPc+DROnQ6GMESH/xiHJNbVax+rbqYkncQUYO+wX0O7VR5KApO8J1mDq4DRovphgLQiYp29KHvcBWozYvlqzNEy5KLOGBm3mSloa3/8AwU4UQW6E+5cEfxHb/iToX5h3JZ8tsW8Ljb61Kq7RbagRVQw4tzxYcw9W61QECkV6NmWUyDqWAZBG6KDENW5skUZqaNDHFoW3dWllHGAV8mxT32e1ISPX73M812z72cU1uo4H/RBDC5Myf4XZB+HOW7CqmZYRyGXo4PutRUVKzkSelPbGNkljbXICGTSD5x4RBqzUef+SUBkD+iDTD0OWG0zgH46Cn0XcEd1HX6xXm9ZGX5wIYncNCT81SBxjpVy6ZLRWz499Mx+V0g0PyDEJMdYh+zCV//wl9GJFMF/ugHwcWxhFNzsnw6o549ViZDmucdTa6HjeQYjg3ij/ClivGNXdH5DWiyIMPvXZMLLBIBJfb0henZioIKPEI6KomnOX4ussBswp2GpdijM7Vp9l2XfSOPafDAaDcdLSZNJgMBhMGgwGwxr+FWAA/oyAtLcbpNUAAAAASUVORK5CYII=" />
  </div>

  <p>Dear ${user.username }</p>
  <br/>
  <p>A password reset request has been received for your account. If you did not request this yourself you should contact
  <a href="mailto:help@justthetalk.com">help@justthetalk.com</a>. If you did make this request then please follow
  the link below to rest you password</p>
  <br/>
  <p><a href="${url }">Reset my password...</a></p>
  <br/>
  <p>If your e-mail client will not allow you click on links then please copy and paste the following URL into your browser address bar...</p>
  <br/>
  <p>${url }</p>

  <br/>
  <p>Best Regards,</p>
  <br/>
  <p>NOTtheTalk</p>

  </div>
</body>
</html>