package com.lys.face;

import com.lys.entity.Templete;
import com.lys.model.MTemplete;
import com.lys.util.Page;

import java.util.List;
import java.util.Map;

/**
 * @author between
 */
public interface ITempleteService extends BaseService<Templete> {

    Long count();

    void deletes(String ids);

    List<Templete> finds(String ids);

    Map<String,Object> search(String q, Page page, Integer p1);

    List<Templete> find(Integer userId);

    List<Templete> findHotTempletes();

    List<Templete> findNewTempletes();

    List<Templete> findByType(Integer typeId);

    List<MTemplete> copyList(List<Templete> list);
}
