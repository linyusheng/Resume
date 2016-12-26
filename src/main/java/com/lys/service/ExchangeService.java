package com.lys.service;

import java.io.Serializable;
import java.util.List;

import com.lys.face.BaseService;
import com.lys.face.IExchangeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Exchange;

/**
 * 商品兑换业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class ExchangeService implements IExchangeService {
	
	@Autowired
	private BaseDAO<Exchange> baseDAO;

	public Exchange get(Integer id) {
		return baseDAO.get(Exchange.class, id);
	}

	public Serializable save(Exchange o) {
		return baseDAO.save(o);
	}

	public void update(Exchange o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Exchange> findAll() {
		return baseDAO.find("from Exchange");
	}

}
