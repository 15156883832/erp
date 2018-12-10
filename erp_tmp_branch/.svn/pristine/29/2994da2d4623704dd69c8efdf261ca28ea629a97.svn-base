package com.jojowonet.modules.fmss.utils;

import java.util.List;

import com.google.common.collect.Lists;

public class HightchartUtils {

	/**
	 * @param type:1表示天数，2表示月数
	 */
	public static List<String> handleCategory(List<Integer> category, int year, int type) {
		List<String> list = Lists.newArrayList();
		for(Integer item : category){
			String itemNew = "";
			if(type == 1){
				itemNew = ""+item/10;
			}else if(type == 2){
				itemNew = year + "-" + item/10;
			}
			list.add(itemNew);
		}
		return list;
	}
}
