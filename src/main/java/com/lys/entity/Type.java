package com.lys.entity;

import java.util.Set;


/**
 * Type entity. @author MyEclipse Persistence Tools
 */

public class Type implements java.io.Serializable {

	// Fields

	private Integer tid;
	private String tname;

	// Constructors

	/** default constructor */
	public Type() {
	}

	/** full constructor */
	public Type(String tname, Set templetes) {
		this.tname = tname;
	}

	// Property accessors

	public Integer getTid() {
		return this.tid;
	}

	public void setTid(Integer tid) {
		this.tid = tid;
	}

	public String getTname() {
		return this.tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}


}