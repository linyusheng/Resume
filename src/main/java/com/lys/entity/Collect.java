package com.lys.entity;

import java.sql.Timestamp;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Collect entity. @author MyEclipse Persistence Tools
 */

public class Collect implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	private Integer tid;
	private String kind;
	private String title;
	private String url;
	@JSONField(format="yyyy-MM-dd HH:mm")
	private Timestamp time;

	// Constructors

	/** default constructor */
	public Collect() {
	}

	/** full constructor */
	public Collect(Integer uid, Integer tid, String kind, String title,
			String url, Timestamp time) {
		this.uid = uid;
		this.tid = tid;
		this.kind = kind;
		this.title = title;
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

	public Integer getTid() {
		return this.tid;
	}

	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public String getKind() {
		return this.kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
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