package com.lys.entity;

import java.sql.Timestamp;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Message entity. @author MyEclipse Persistence Tools
 */

public class Message implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	private Integer type;
	private Integer kind;
	private String info;
	private String detail;
	private Short isreaded;
	private String url;
	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	private Timestamp time;

	// Constructors

	/** default constructor */
	public Message() {
	}

	/** full constructor */
	public Message(Integer uid, Integer type, Integer kind, String info,
			String detail, Short isreaded, String url, Timestamp time) {
		this.uid = uid;
		this.type = type;
		this.kind = kind;
		this.info = info;
		this.detail = detail;
		this.isreaded = isreaded;
		this.url = url;
		this.time = time;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getKind() {
		return this.kind;
	}

	public void setKind(Integer kind) {
		this.kind = kind;
	}

	public String getInfo() {
		return this.info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getDetail() {
		return this.detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public Short getIsreaded() {
		return this.isreaded;
	}

	public void setIsreaded(Short isreaded) {
		this.isreaded = isreaded;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

}