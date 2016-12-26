package com.lys.face;

import com.lys.entity.Jcomment;

import java.util.List;

/**
 * @author between
 */
public interface IJcommentService extends BaseService<Jcomment> {

    List<Object[]> find(Integer jid);

}
