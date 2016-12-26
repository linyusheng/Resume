package com.lys.face;

import com.lys.entity.Collect;

import java.util.List;

/**
 * @author between
 * @date 2016/5/28
 */
public interface ICollectService extends BaseService<Collect> {

    List<Collect> findByUser(Integer uid);

    void delete(Integer uid,String kind,Integer tid);

    List<Collect> findByUser(Integer uid,String kind);

}
