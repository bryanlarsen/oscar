/**
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved.
 * This software is published under the GPL GNU General Public License.
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada
 */
package oscar.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Yet another conversion utility class for bridging JPA entity to legacy schema mismatch. 
 */
public class ConversionUtils {

	public static final String DEFAULT_DATE_PATTERN = "yyyy-MM-dd";
	public static final String DEFAULT_TIME_PATTERN = "HH:mm:ss";
	public static final String DEFAULT_TS_PATTERN = "yyyy-MM-dd HH:mm:ss";

	private static final Long ZERO_LONG = new Long(0);
	private static final Integer ZERO_INT = new Integer(0);
	private static final Double ZERO_DOUBLE = new Double(0.0);
	private static final String ZERO_STRING = "0";

	private ConversionUtils() {
	}

	public static List<Integer> toIntList(List<String> list) {
		List<Integer> result = new ArrayList<Integer>();
		for (String str : list)
			result.add(fromIntString(str));
		return result;
	}

	/**
	 * Converts the provided string representing time into a date object. Time must match the {@link #DEFAULT_TIME_PATTERN}.
	 * 
	 * @param timeString
	 * 		Time string to be parsed
	 * @return
	 * 		Returns the parsed string
	 */
	public static Date fromTimeString(String timeString) {
		return fromDateString(timeString, DEFAULT_TIME_PATTERN);
	}
	
	public static Date fromTimeStringNoSeconds(String timeString) {
		return fromDateString(timeString, "HH:mm");
	}

	/**
	 * Converts the provided date representing time into a date object. Time must match the {@link #DEFAULT_DATE_PATTERN}.
	 * 
	 * @param dateString
	 * 		Date string to be parsed
	 * @return
	 * 		Returns the parsed string
	 */
	public static Date fromDateString(String dateString) {
		return fromDateString(dateString, DEFAULT_DATE_PATTERN);
	}
	
	public static Date fromTimestampString(String dateString) {
		return fromDateString(dateString, DEFAULT_TS_PATTERN);
	}
	
	public static String toTimestampString(Date timestamp) {
		return toDateString(timestamp, DEFAULT_TS_PATTERN);
	}

	private static Date fromDateString(String dateString, String formatPattern) {
		if (dateString == null || "".equals(dateString.trim())) return null;

		SimpleDateFormat format = new SimpleDateFormat(formatPattern);
		try {
			return format.parse(dateString);
		} catch (ParseException e) {
			return null;
		}
	}

	private static String toDateString(Date date, String formatPattern) {
		if (date == null) return "";

		SimpleDateFormat format = new SimpleDateFormat(formatPattern);
		return format.format(date);
	}

	/**
	 * Formats the date instance into a string keeping only the time of the day and excluding the remaining info.   
	 * 
	 * @param time
	 * 		Date to be formatted using {@link #DEFAULT_TIME_PATTERN}
	 * @return
	 * 		Returns the formatted string
	 */
	public static String toTimeString(Date time) {
		return toDateString(time, DEFAULT_TIME_PATTERN);
	}

	/**
	 * Formats the date instance into a string keeping only the date.   
	 * 
	 * @param time
	 * 		Date to be formatted using {@link #DEFAULT_DATE_PATTERN}
	 * @return
	 * 		Returns the formatted string
	 */
	public static String toDateString(Date date) {
		return toDateString(date, DEFAULT_DATE_PATTERN);
	}

	/**
	 * Parses the specified string as a Long instance. 
	 * 
	 * @param longString
	 * 		String to be parsed as long
	 * @return
	 * 		Returns the parsed long
	 */
	public static Long fromLongString(String longString) {
		if (longString == null || longString.trim().isEmpty()) return ZERO_LONG;
		return Long.parseLong(longString);
	}

	/**
	 * Parses the specified string as an Integer instance. 
	 * 
	 * @param intString
	 * 		String to be parsed as integer
	 * @return
	 * 		Returns the parsed integer
	 */
	public static Integer fromIntString(String intString) {
		if (intString == null || intString.trim().isEmpty()) return ZERO_INT;
		return Integer.parseInt(intString);
	}

	/**
	 * Formats the specified integer as string 
	 * 
	 * @param integer
	 * 		Integer to format as a string.
	 * @return
	 * 		Returns the formatted string, or {@value #ZERO_STRING} for null paramter value.
	 */
	public static String toIntString(Integer integer) {
		if (integer == null) return ZERO_STRING;
		return integer.toString();
	}

	/**
	 * Formats the specified boolean as string 
	 * 
	 * @param b
	 * 		Boolean to format as a string.
	 * @return
	 * 		Returns {@value #ZERO_STRING} for false or null instance or "1" otherwise.
	 */
	public static String toBoolString(Boolean b) {
		if (b == null || b == Boolean.FALSE) return ZERO_STRING;
		return "1";
	}

	/**
	 * Parses the specified string as boolean.
	 * 
	 * @param str
	 * 		String to be parsed
	 * @return
	 * 		Returns false for empty, null or {@value #ZERO_STRING} or true otherwise. 
	 */
	public static boolean fromBoolString(String str) {
		if (str == null || str.trim().isEmpty() || ZERO_STRING.equals(str)) return false;
		return true;
	}

	/**
	 * Parses the specified string as an Double instance. 
	 * 
	 * @param str
	 * 		String to be parsed as double
	 * @return
	 * 		Returns the parsed double
	 */
	public static Double fromDoubleString(String str) {
		if (str == null || str.trim().isEmpty())
			return ZERO_DOUBLE;
		
	    return Double.parseDouble(str);
    }
	
	/**
	 * Formats the specified double as string 
	 * 
	 * @param d
	 * 		Double to format as a string.
	 * @return
	 * 		Returns the formatted string, or {@value #ZERO_STRING} for null value.
	 */
	public static String toDoubleString(Double d) {
		if (d == null)
			return ZERO_STRING;
		return d.toString();
	}

}