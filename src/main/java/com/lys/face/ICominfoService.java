package com.lys.face;

import com.lys.entity.Cominfo;

import java.util.List;

/**
 * @author between
 * @date 2016/5/28
 */
public interface ICominfoService extends BaseService<Cominfo> {

    List<Cominfo> findByUser(Integer id);

}
