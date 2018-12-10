/**
 */
package com.jojowonet.modules.fitting.dao;

import com.jojowonet.modules.fitting.entity.MicroFactory;
import ivan.common.persistence.BaseDao;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

/**
 * 小厂家表。
 * @version 2017-05-20
 */
@Repository
public class MicroFactoryDao extends BaseDao<MicroFactory> {

	public MicroFactory findByName(String name) {
		Query query = getSession().createQuery("from MicroFactory where name=:name");
		query.setParameter("name", name);
		return (MicroFactory) query.uniqueResult();
	}
	
}
