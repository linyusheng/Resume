package com.lys.entity;

/**
 * Subscription entity. @author MyEclipse Persistence Tools
 */

public class Subscription implements java.io.Serializable {

	// Fields

	private Integer sid;
	private Userinfo userinfo;
	private String keyword;

	// Constructors

	/** default constructor */
	public Subscription() {
	}

	/** full constructor */
	public Subscription(Userinfo userinfo, String keyword) {
		this.userinfo = userinfo;
		this.keyword = keyword;
	}

	// Property accessors

	public Integer getSid() {
		return this.sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public Userinfo getUserinfo() {
		return this.userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public String getKeyword() {
		return this.keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

}