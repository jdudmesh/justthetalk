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

package com.notthetalk;

import java.util.Date;
import org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib;

public class RecentDiscussion {

	public Long discussion_id;
	public Date last_post;
	public Integer post_count;
	public String discussion_name;
	public Long folder_id;
	public String folder_name;
	public String folder_key;
	public Integer last_post_count;
	public Integer new_post_count;

	public String canonicalUrl() {

		String headerAsPath = discussion_name.replaceAll("[^A-Za-z0-9]", "_").toLowerCase();
		String url = "/" + folder_key + "/" + discussion_id.toString() + "/" + headerAsPath;

		return url;

	}


}
