package com.lys.face;

import com.lys.entity.Honinfo;
import com.lys.entity.Userinfo;

/**
 * @author between
 */
public interface IHoninfoService extends BaseService<Honinfo> {

    void init(Userinfo userinfo);

    Honinfo findByUser(Integer id);

}
