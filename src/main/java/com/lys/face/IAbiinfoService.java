package com.lys.face;

import com.lys.entity.Abiinfo;
import com.lys.entity.Userinfo;
import com.lys.model.MAbiinfo;

/**
 * @author between
 * @date 2016/5/28
 */
public interface IAbiinfoService extends BaseService<Abiinfo>{

    void init(Userinfo user);

    MAbiinfo findByUser(Integer id);

    void update(String field,Integer userId,String data);

    String findByUserId(String field,Integer uid);
}
