package com.lys.entity;

/**
 * Othinfo entity. @author MyEclipse Persistence Tools
 */

public class Othinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	private String title;
	private String detail;

	// Constructors

	/** default constructor */
	public Othinfo() {
	}

	/** full constructor */
	public Othinfo(Integer uid, String title, String detail) {
		this.uid = uid;
		this.title = title;
		this.detail = detail;
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

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDetail() {
		return this.detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

}