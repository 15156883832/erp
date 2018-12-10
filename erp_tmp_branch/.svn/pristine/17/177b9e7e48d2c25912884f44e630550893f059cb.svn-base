package com.jojowonet.modules.order.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Lists;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jojowonet.modules.fitting.form.SignJson;
import com.jojowonet.modules.fitting.form.Target;

public class WebPageFunUtils {

	/**
	 * 获取工单的详细过程信息
	 *
	 * @param pros
	 *            as:2017-05-04 21:40:32#@工单接入@#@2017-05-05 10:01:40#@工单进行派工
	 * @return
	 */
	public static ArrayList<Target> getOrderProcess(String pros) {
		try {
			ArrayList<Target> list = Lists.newArrayList();
			if (StringUtils.isNotBlank(pros)) {
				Gson gson = new Gson();
				list = gson.fromJson(pros, new TypeToken<ArrayList<Target>>() {
				}.getType());
			}
			// 升序 按时间升序排序
			Collections.sort(list, new Comparator<Target>() {
				public int compare(Target o1, Target o2) {
					return o1.getTime().compareTo(o2.getTime());
				}
			});
			return list;
		} catch (Exception ex) {
			return new ArrayList<>();
		}
	}

	public static ArrayList<SignJson> getSignTimesList(String pros) {
		try {
			ArrayList<SignJson> list = Lists.newArrayList();
			if (StringUtils.isNotBlank(pros)) {
				Gson gson = new Gson();
				list = gson.fromJson(pros, new TypeToken<ArrayList<SignJson>>() {
				}.getType());
			}
			/*
			 * // 升序 按时间升序排序 Collections.sort(list, new Comparator<Target>() { public int
			 * compare(Target o1, Target o2) { return o1.getTime().compareTo(o2.getTime());
			 * } });
			 */
			ArrayList<SignJson> lists = Lists.newArrayList();
			for (SignJson sj : list) {
				SignJson gs = new SignJson();
				gs.setOn(sj.getOn().substring(sj.getOn().length() - 8, sj.getOn().length() - 3));
				gs.setOff(sj.getOff().substring(sj.getOff().length() - 8, sj.getOff().length() - 3));
				lists.add(gs);
			}
			return lists;
		} catch (Exception ex) {
			return new ArrayList<>();
		}
	}

	public static ArrayList<SignJson> getSignTimesListUsed(String pros) {
		try {
			ArrayList<SignJson> list = Lists.newArrayList();
			if (StringUtils.isNotBlank(pros)) {
				Gson gson = new Gson();
				list = gson.fromJson(pros, new TypeToken<ArrayList<SignJson>>() {
				}.getType());
			}
			/*
			 * // 升序 按时间升序排序 Collections.sort(list, new Comparator<Target>() { public int
			 * compare(Target o1, Target o2) { return o1.getTime().compareTo(o2.getTime());
			 * } });
			 */
			ArrayList<SignJson> lists = Lists.newArrayList();
			for (SignJson sj : list) {
				SignJson gs = new SignJson();
				gs.setOn(sj.getOn());
				gs.setOff(sj.getOff());
				lists.add(gs);
			}
			return lists;
		} catch (Exception ex) {
			return new ArrayList<>();
		}
	}

	/**
	 * 获取备件申请反馈信息
	 */
	public static ArrayList<Target> getFittingProcess(String pros) {
		ArrayList<Target> list = Lists.newArrayList();
		if (StringUtils.isNotBlank(pros)) {
			Gson gson = new Gson();
			list = gson.fromJson(pros, new TypeToken<ArrayList<Target>>() {
			}.getType());
		}
		// 降序 按时间降序排序
		Collections.sort(list, new Comparator<Target>() {
			public int compare(Target o1, Target o2) {
				return -o1.getTime().compareTo(o2.getTime());
			}
		});
		return list;
	}

	public static ArrayList<Target> getFittingProcessWithoutSort(String pros) {
		ArrayList<Target> list = Lists.newArrayList();
		if (StringUtils.isNotBlank(pros)) {
			Gson gson = new Gson();
			list = gson.fromJson(pros, new TypeToken<ArrayList<Target>>() {
			}.getType());
		}
		return list;
	}

	public static ArrayList<SignJson> getSignJsonWithoutSort(String signJson) {
		ArrayList<SignJson> list = Lists.newArrayList();
		if (StringUtils.isNotBlank(signJson)) {
			Gson gson = new Gson();
			list = gson.fromJson(signJson, new TypeToken<ArrayList<SignJson>>() {
			}.getType());
		}
		return list;
	}

	/**
	 * 拼接过程信息
	 */
	public static String appendProcessDetail(Target ta, String existsDetail) {
		if (ta == null || StringUtil.isBlank(ta.getContent())) {
			throw new IllegalTargetException();
		}
		try {
			ArrayList<Target> list = getFittingProcessWithoutSort(existsDetail);// 先前已经存在的过程信息
			list.add(ta);
			Collections.sort(list, new Comparator<Target>() {
				public int compare(Target o1, Target o2) {
					return o1.getTime().compareTo(o2.getTime());
				}
			});
			Gson gson = new Gson();
			return gson.toJson(list, new TypeToken<ArrayList<Target>>() {
			}.getType());
		} catch (Exception ex) {
			return existsDetail;
		}
	}

	public static String appendSignJson(SignJson sj, String existsSignJson) {
		if (sj == null || StringUtil.isBlank(sj.getOff()) || StringUtil.isBlank(sj.getOn())) {
			throw new IllegalTargetException();
		}
		try {
			ArrayList<SignJson> list = getSignJsonWithoutSort(existsSignJson);// 先前已经存在的过程信息
			list.add(sj);
			/*
			 * Collections.sort(list, new Comparator<SignJson>() { public int compare(Target
			 * o1, Target o2) { return o1.getTime().compareTo(o2.getTime()); } });
			 */
			Gson gson = new Gson();
			return gson.toJson(list, new TypeToken<ArrayList<SignJson>>() {
			}.getType());
		} catch (Exception ex) {
			return existsSignJson;
		}
	}

	public static String appendProcessDetails(List<Target> ta, String existsDetail) {
		for (Target t : ta) {
			if (t == null || StringUtil.isBlank(t.getContent())) {
				throw new IllegalTargetException();
			}
		}

		try {
			ArrayList<Target> list = getFittingProcessWithoutSort(existsDetail);// 先前已经存在的过程信息
			list.addAll(ta);
			Collections.sort(list, new Comparator<Target>() {
				public int compare(Target o1, Target o2) {
					return o1.getTime().compareTo(o2.getTime());
				}
			});
			Gson gson = new Gson();
			return gson.toJson(list, new TypeToken<ArrayList<Target>>() {
			}.getType());
		} catch (Exception ex) {
			return existsDetail;
		}
	}

	/**
	 * 获取总费用
	 */
	public static String getOrderTotalFee(int len, Object... fees) {
		Double totalFee = 0d;
		if (fees != null) {
			for (Object fee : fees) {
				totalFee += Double.valueOf(String.valueOf(fee));
			}
		}
		if (totalFee > 0) {
			return String.valueOf(totalFee);
		}
		return "0";
	}

	public static Double getTotalFee(Object... fees) {
		Double result = 0d;
		if (fees != null) {
			for (Object fee : fees) {
				Double item = 0d;
				try {
					item = Double.valueOf(String.valueOf(fee));
				} catch (Exception e) {
					//
				}
				result += item;
			}
		}
		return result;
	}

	public static String getOrderTotalFee(Object fee1, Object fee2, Object fee3) {
		return getOrderTotalFee(3, fee1, fee2, fee3);
	}
}
