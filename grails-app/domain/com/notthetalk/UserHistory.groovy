/*
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
 */

package com.notthetalk

import org.apache.commons.logging.LogFactory

class UserHistory {

	private static final log = LogFactory.getLog(this)

	User user
	Date createdDate
	String eventType
	String eventData

    static constraints = {
		eventData blank:false
		eventType blank:false
    }

	static void CreateUserHistoryLocation(User user, String eventType, String ip, String location) {

		def addr = InetAddress.getByName(ip)

		UserHistory hist = new UserHistory()
		hist.user = user
		hist.createdDate = new Date()
		hist.eventType = eventType;
		hist.eventData = ip + " (" + addr + ")" + ": " + location;

		hist.save()

	}

	static void CreateUserHistory(User user, String eventType, String eventData) {

		UserHistory hist = new UserHistory()
		hist.user = user
		hist.createdDate = new Date()
		hist.eventType = eventType
		hist.eventData = eventData

		hist.save()

	}

	static void CreateUserHistory(User user, String eventType, User admin) {

		UserHistory hist = new UserHistory()
		hist.user = user
		hist.createdDate = new Date()
		hist.eventType = eventType;
		hist.eventData = "Actioned by: " + admin.username

		hist.save()

	}

}
