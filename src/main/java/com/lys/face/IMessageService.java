package com.lys.face;

import com.lys.entity.Message;

import java.util.List;

/**
 * @author between
 * @date 2016/5/28
 */
public interface IMessageService extends BaseService<Message>{

    List<Message> findByUser(Integer uid);

    List<Message> findUnRead(Integer uid);

    int markRead(String ids);

    List<Message> finds();

    List<Message> findMessageUsers(String time);

    List<Message> findAdvice();

    void deletes(String[] times);

}
