package com.lys.face;

import com.lys.entity.Stuinfo;

import java.util.List;

/**
 * @author between
 */
public interface IStuinfoService extends BaseService<Stuinfo> {

    List<Stuinfo> findByUser(Integer id);

}
