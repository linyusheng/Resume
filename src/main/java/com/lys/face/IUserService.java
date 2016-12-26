package com.lys.face;

import com.lys.entity.Userinfo;

import java.util.List;

/**
 * @author between
 */
public interface IUserService extends BaseService<Userinfo> {

    void init(String email,String pwd,String nickname);

    Userinfo getUser(String account);

    Userinfo getUser(String utype,String account, String password);

    boolean editHead(Integer id,String head);

    boolean setPwd(Integer id,String password);

    boolean setPwd(String email,String password);

    void updateIntegrity(Integer id,Integer changeValue);

    List<Userinfo> findByIds(String ids);

    List<Userinfo> findUser(String type);

    Long count();

    Long countMonthRegister();

    Long countDayRegister();

}
