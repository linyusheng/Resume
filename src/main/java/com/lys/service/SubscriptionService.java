package com.lys.service;

import java.io.Serializable;
import java.util.List;

import com.lys.face.BaseService;
import com.lys.face.ISubscriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Subscription;

@Service
public class SubscriptionService implements ISubscriptionService {
	
	@Autowired
	private BaseDAO<Subscription> baseDAO;

	public Subscription get(Integer id) {
		return baseDAO.get(Subscription.class, id);
	}

	public Serializable save(Subscription o) {
		return baseDAO.save(o);
	}

	public void update(Subscription o) {
		// TODO Auto-generated method stub

	}

	public void delete(Integer id) {
		// TODO Auto-generated method stub
		
	}

	public List<Subscription> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

}
