package com.lys.controller;

import com.lys.util.Global;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 论坛访问控制类(类资源访问：/bbs/*)
 * @author between
 */
public class BBSController extends BaseController{

    private static Logger logger = LoggerFactory.getLogger(BBSController.class);

    @RequestMapping(method = RequestMethod.GET)
    public String get(){
        return Global.BBS_INDEX;
    }

}
