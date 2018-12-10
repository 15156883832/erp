package com.jojowonet.modules.order.service;

import java.util.Date;
import java.util.List;

import ivan.common.persistence.Page;
import ivan.common.service.BaseService;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.dao.DocSetDao;
import com.jojowonet.modules.order.entity.DocSet;


/**
 * 文件上传service层
 * @author yc
 * @version 2017-09-07
 */

@Component
@Transactional(readOnly = true)
public class DocSetService  extends BaseService{
	@Autowired
	private DocSetDao docSetDao;
	public Page<Record> getDocList(Page<Record> page){
		List<Record> list=docSetDao.getDocList(page);
		for (Record rd : list) {
			String doctype=rd.getStr("doc_type");
			String newtype=doctype.substring(1);
			rd.set("doc_type",newtype);
		}
		long count=docSetDao.getcount();
		page.setList(list);
		page.setCount(count);
		return page;
	}
	public List<Record> getDocListrecord(){
		List<Record> list=docSetDao.getDocList(null);
		for (Record rd : list) {
			String doctype=rd.getStr("doc_type");
			String newtype=doctype.substring(1);
			rd.set("doc_type",newtype);
		}

		return list;
	}
	public String save(String name, String doctype, String description,
			String realdocpath, String icon,String filesize) {
		String id="";
		id=docSetDao.getDocByname(name);
		String result="保存出错";
		if(StringUtils.isNotBlank(id)){
			Long size=new Long(0);
			if(StringUtils.isNotBlank(filesize)){
				Long newsize=size.valueOf(filesize);
				if(0<=newsize&&newsize<=1024){
					filesize=filesize+"b";
				}else if(newsize>=1024&&newsize<=1048576){
					filesize=String.valueOf(newsize/1024);
					filesize=filesize+"kb";
				}else{
					filesize=String.valueOf(newsize/1048576);
					filesize=filesize+"m";
				}
			}else{
				filesize="0b";
			}
		
			if(StringUtils.isEmpty(name)){
				result="文件名称保存出错";
			}else if(StringUtils.isEmpty(doctype)){
				result="文件类型保存出错";
			}else if(StringUtils.isEmpty(description)){
				result="文件描述保存出错";
			}else if(StringUtils.isEmpty(realdocpath)){
				result="文件路径保存出错";
			}else if(StringUtils.isEmpty(icon)){
				result="保存出错";
			}else{
				DocSet docSet=new DocSet();
				docSet.setId(id);
				docSet.setName(name);
				docSet.setDocType(doctype);
				docSet.setDescription(description);
				docSet.setPath(realdocpath);
				docSet.setIcon(icon);
				docSet.setCreateBy(UserUtils.getUser().getId());
				docSet.setDocSize(filesize);
				docSet.setUpdateTime(new Date());
				docSetDao.save(docSet);
				result="ok";
			}
		}else{
			Long size=new Long(0);
			if(StringUtils.isNotBlank(filesize)){
				Long newsize=size.valueOf(filesize);
				if(0<=newsize&&newsize<=1024){
					filesize=filesize+"b";
				}else if(newsize>=1024&&newsize<=1048576){
					filesize=String.valueOf(newsize/1024);
					filesize=filesize+"kb";
				}else{
					filesize=String.valueOf(newsize/1048576);
					filesize=filesize+"m";
				}
			}else{
				filesize="0b";
			}
			if(StringUtils.isEmpty(name)){
				result="文件名称保存出错";
			}else if(StringUtils.isEmpty(doctype)){
				result="文件类型保存出错";
			}else if(StringUtils.isEmpty(description)){
				result="文件描述保存出错";
			}else if(StringUtils.isEmpty(realdocpath)){
				result="文件路径保存出错";
			}else if(StringUtils.isEmpty(icon)){
				result="保存出错";
			}else{
				DocSet docSet=new DocSet();
				docSet.setName(name);
				docSet.setDocType(doctype);
				docSet.setDescription(description);
				docSet.setPath(realdocpath);
				docSet.setIcon(icon);
				docSet.setCreateBy(UserUtils.getUser().getId());
				docSet.setDocSize(filesize);
				docSetDao.save(docSet);
				result="ok";
			}
		}
			
		return result;
	
		
	}
	public Integer deletedoc(String id) {
		Integer i=docSetDao.deletedoc(id);
		return i;
	}

}
