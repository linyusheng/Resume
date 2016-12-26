package com.lys.entity;

import java.sql.Timestamp;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Goods entity. @author MyEclipse Persistence Tools
 */

public class Goods implements java.io.Serializable {

	// Fields

	private Integer gid;
	private Integer tid;
	private String gname;
	private Integer gpoint;
	private String gpicture;
	private Integer gnum;
	private Boolean isShow;
	@JSONField(format="yyyy-MM-dd")
	private Timestamp gtime;

	// Constructors

	/** default constructor */
	public Goods() {
	}

	/** full constructor */
	public Goods(Integer tid, String gname, Integer gpoint, String gpicture,
			Integer gnum, Boolean isShow, Timestamp gtime) {
		this.tid = tid;
		this.gname = gname;
		this.gpoint = gpoint;
		this.gpicture = gpicture;
		this.gnum = gnum;
		this.isShow = isShow;
		this.gtime = gtime;
	}

	// Property accessors

	public Integer getGid() {
		return this.gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	public Integer getTid() {
		return this.tid;
	}

	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public String getGname() {
		return this.gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}

	public Integer getGpoint() {
		return this.gpoint;
	}

	public void setGpoint(Integer gpoint) {
		this.gpoint = gpoint;
	}

	public String getGpicture() {
		return this.gpicture;
	}

	public void setGpicture(String gpicture) {
		this.gpicture = gpicture;
	}

	public Integer getGnum() {
		return this.gnum;
	}

	public void setGnum(Integer gnum) {
		this.gnum = gnum;
	}

	public Boolean getIsShow() {
		return this.isShow;
	}

	public void setIsShow(Boolean isShow) {
		this.isShow = isShow;
	}

	public Timestamp getGtime() {
		return this.gtime;
	}

	public void setGtime(Timestamp gtime) {
		this.gtime = gtime;
	}

}