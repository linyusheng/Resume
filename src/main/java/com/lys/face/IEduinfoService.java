package com.lys.face;

import com.lys.entity.Eduinfo;

import java.util.List;

/**
 * @author between
 * @date 2016/5/28
 */
public interface IEduinfoService extends BaseService<Eduinfo> {

    List<Eduinfo> findByUser(Integer id);

}
