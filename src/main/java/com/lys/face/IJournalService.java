package com.lys.face;

import com.lys.entity.Journal;

import java.util.List;

/**
 * @author between
 */
public interface IJournalService extends BaseService<Journal> {

    Long count();

    List<Journal> findByUser(Integer uid);

}
