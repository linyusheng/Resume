package com.lys.entity;

import java.sql.Timestamp;

/**
 * Grade entity. @author MyEclipse Persistence Tools
 */

public class Grade implements java.io.Serializable {

	// Fields

	private Integer gid;
	private Baseinfo baseinfo;
	private Userinfo userinfo;
	private Integer grade;
	private String gcontent;
	private Timestamp gtime;

	// Constructors

	/** default constructor */
	public Grade() {
	}

	/** full constructor */
	public Grade(Baseinfo baseinfo, Userinfo userinfo, Integer grade,
			String gcontent, Timestamp gtime) {
		this.baseinfo = baseinfo;
		this.userinfo = userinfo;
		this.grade = grade;
		this.gcontent = gcontent;
		this.gtime = gtime;
	}

	// Property accessors

	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	public Baseinfo getBaseinfo() {
		return this.baseinfo;
	}

	public void setBaseinfo(Baseinfo baseinfo) {
		this.baseinfo = baseinfo;
	}

	public Userinfo getUserinfo() {
		return this.userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public Integer getGrade() {
		return this.grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}

	public String getGcontent() {
		return this.gcontent;
	}

	public void setGcontent(String gcontent) {
		this.gcontent = gcontent;
	}

	public Timestamp getGtime() {
		return this.gtime;
	}

	public void setGtime(Timestamp gtime) {
		this.gtime = gtime;
	}

}