package com.lys.face;

import com.lys.entity.Othinfo;

import java.util.List;

/**
 * @author between
 */
public interface IOthinfoService extends BaseService<Othinfo> {

    List<Othinfo> findByUser(Integer id);

}
