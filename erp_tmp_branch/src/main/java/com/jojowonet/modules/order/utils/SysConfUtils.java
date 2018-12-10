package com.jojowonet.modules.order.utils;

import java.util.List;

import com.google.common.collect.Lists;
import com.jfinal.plugin.activerecord.Record;

/**
 * The Class SysConfUtils.
 */
public class SysConfUtils {

	/**
	 * Gets the long value from record.
	 *
	 * @param record the record
	 * @param attr the attr
	 * @return the long value from record
	 */
	public static long getLongValueFromRecord(Record record, String attr)
	{
		long value = 0l;
		if(record != null && attr != null && !attr.isEmpty())
		{
			Long attr_value = record.getLong(attr);
			if(attr_value != null)
				value = attr_value.longValue();
		}
		return value;
	}
	
	/**
	 * Gets the belong a not b.
	 *
	 * @param A the a
	 * @param B the b
	 * @return the belong a not b
	 */
	public static List<Integer> getBelongANotB(List<Integer> A, List<Integer> B)
	{
		List<Integer> result = Lists.newArrayList();
		if(A != null && B != null)
		{
			for(Integer a : A)
			{
				if(!B.contains(a))
					result.add(a);
			}
		}
		return result;
	}
}
