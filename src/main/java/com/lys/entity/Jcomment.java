package com.lys.entity;

import java.sql.Timestamp;

/**
 * Jcomment entity. @author MyEclipse Persistence Tools
 */

public class Jcomment implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	private Integer jid;
	private String content;
	private Timestamp time;

	// Constructors

	/** default constructor */
	public Jcomment() {
	}

	/** full constructor */
	public Jcomment(Integer uid, Integer jid, String content, Timestamp time) {
		this.uid = uid;
		this.jid = jid;
		this.content = content;
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

	public Integer getJid() {
		return this.jid;
	}

	public void setJid(Integer jid) {
		this.jid = jid;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

}