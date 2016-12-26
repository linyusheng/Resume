package com.lys.face;

import com.lys.entity.Goods;
import com.lys.util.Page;

import java.util.List;
import java.util.Map;

/**
 * @author between
 */
public interface IGoodsService extends BaseService<Goods> {

    Long count();

    List<Goods> finds(String ids);

    void deletes(String ids);

    Map<String,Object> search(String key, Integer pId, Integer tId, Page page, Integer order);

}
