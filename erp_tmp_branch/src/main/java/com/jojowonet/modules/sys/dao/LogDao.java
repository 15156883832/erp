/**
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.jojowonet.modules.sys.dao;

import ivan.common.entity.mysql.common.Log;
import ivan.common.persistence.BaseDao;

import org.springframework.stereotype.Repository;


/**
 * 日志DAO接口
 * @version 2013-8-23
 */
@Repository(value="logDaoET")
public class LogDao extends BaseDao<Log> {

}
