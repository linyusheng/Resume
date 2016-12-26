package com.lys.face;

import com.lys.entity.Baseinfo;
import com.lys.entity.Userinfo;
import com.lys.util.Page;

import java.util.Map;

/**
 * @author between
 * @date 2016/5/28
 */
public interface IBaseinfoService extends BaseService<Baseinfo> {

    Long count();

    void init(Userinfo user);

    Baseinfo findByUser(Integer id);

    boolean editHead(Integer uid,String head);

    Map<String,Object> search(String key, Integer positionId, Integer educationId, Page page);

}
