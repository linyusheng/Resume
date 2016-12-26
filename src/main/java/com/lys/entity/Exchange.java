package com.lys.entity;

import java.sql.Timestamp;

/**
 * Exchange entity. @author MyEclipse Persistence Tools
 */

public class Exchange implements java.io.Serializable {

	// Fields

	private Integer eid;
	private Goods goods;
	private Userinfo userinfo;
	private String enumber;
	private Integer ecount;
	private String eaddress;
	private Timestamp etime;

	// Constructors

	/** default constructor */
	public Exchange() {
	}

	/** full constructor */
	public Exchange(Goods goods, Userinfo userinfo, String enumber,
			Integer ecount, String eaddress, Timestamp etime) {
		this.goods = goods;
		this.userinfo = userinfo;
		this.enumber = enumber;
		this.ecount = ecount;
		this.eaddress = eaddress;
		this.etime = etime;
	}

	// Property accessors

	public Integer getEid() {
		return this.eid;
	}

	public void setEid(Integer eid) {
		this.eid = eid;
	}

	public Goods getGoods() {
		return this.goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Userinfo getUserinfo() {
		return this.userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public String getEnumber() {
		return this.enumber;
	}

	public void setEnumber(String enumber) {
		this.enumber = enumber;
	}

	public Integer getEcount() {
		return this.ecount;
	}

	public void setEcount(Integer ecount) {
		this.ecount = ecount;
	}

	public String getEaddress() {
		return this.eaddress;
	}

	public void setEaddress(String eaddress) {
		this.eaddress = eaddress;
	}

	public Timestamp getEtime() {
		return this.etime;
	}

	public void setEtime(Timestamp etime) {
		this.etime = etime;
	}

}