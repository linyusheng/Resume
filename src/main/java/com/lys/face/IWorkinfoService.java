package com.lys.face;

import com.lys.entity.Workinfo;

import java.util.List;

/**
 * @author between
 */
public interface IWorkinfoService extends BaseService<Workinfo> {

    List<Workinfo> findByUser(Integer id);
    
}
