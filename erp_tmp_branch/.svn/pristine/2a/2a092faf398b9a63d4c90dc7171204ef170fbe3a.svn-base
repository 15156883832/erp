package com.jojowonet.modules.order.service;

import java.util.List;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.VenderDao;
import com.jojowonet.modules.order.entity.Vender;


@Component
@Transactional(readOnly = true)
public class VenderService extends BaseService{
	@Autowired
	private VenderDao venderDao;
	//查询厂家资料信息列表
	public Page<Record> findVenderList(Page<Record> page){
		List<Record> Venderlist=venderDao.getVenderList(page);
		long count=venderDao.getListCount();
	       page.setCount(count);
	       page.setList(Venderlist);
	       return page;
	}
	
	
	//添加厂家信息
	public boolean save(Vender vender){
		boolean flag;
		venderDao.save(vender);
		flag=true;
		return flag;
	}

	
	//删除厂家信息
	public Integer delete(String id){
		return venderDao.delete(id);
	}
	
	//根据id查询厂家信息
	public Record findVenderById(String id){
		Record vender =venderDao.findVenderById(id);
		return vender;
	}
	
	
	//查询所有厂家名称
	public List<String> getVenderName(){
		List<String> nameList=venderDao.getVenderName();
		return nameList;
	}
}
