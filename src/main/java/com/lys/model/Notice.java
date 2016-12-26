package com.lys.model;

import java.sql.Timestamp;

import com.alibaba.fastjson.annotation.JSONField;
import com.lys.entity.Message;

public class Notice {
	
	private Integer id;
	private Integer uid;
	private Integer type;
	private Integer kind;
	private String info;
	private String detail;
	private Short isreaded;
	private String url;
	//@JSONField(format="yyyy-MM-dd HH:mm")
	private Timestamp time;
	private String account;
	private String head;
	
	public Notice(){
		
	}
	
	public Notice(Message m, String account, String head) {
		super();
		this.id = m.getId();
		this.uid = m.getUid();
		this.type = m.getType();
		this.kind = m.getKind();
		this.info = m.getInfo();
		this.detail = m.getDetail();
		this.isreaded = m.getIsreaded();
		this.url = m.getUrl();
		this.time = m.getTime();
		this.account = account;
		this.head = head;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getKind() {
		return kind;
	}
	public void setKind(Integer kind) {
		this.kind = kind;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public Short getIsreaded() {
		return isreaded;
	}
	public void setIsreaded(Short isreaded) {
		this.isreaded = isreaded;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	
}
