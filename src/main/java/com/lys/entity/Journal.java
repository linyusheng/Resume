package com.lys.entity;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;


import com.alibaba.fastjson.annotation.JSONField;

/**
 * Journal entity. @author MyEclipse Persistence Tools
 */

public class Journal implements java.io.Serializable {

	// Fields

	private Integer jid;
	@JSONField(serialize=false)
	private Userinfo userinfo;
	private String title;
	private String content;
	private String keyword;
	private String url;
	private String browseNum;
	private String praiseNum;
	private Timestamp time;
	private Set jcomments = new HashSet(0);

	// Constructors

	/** default constructor */
	public Journal() {
	}

	/** full constructor */
	public Journal(Userinfo userinfo, String title, String content,
			String keyword, String url, String browseNum, String praiseNum,
			Timestamp time, Set jcomments) {
		this.userinfo = userinfo;
		this.title = title;
		this.content = content;
		this.keyword = keyword;
		this.url = url;
		this.browseNum = browseNum;
		this.praiseNum = praiseNum;
		this.time = time;
		this.jcomments = jcomments;
	}

	// Property accessors

	public Integer getJid() {
		return this.jid;
	}

	public void setJid(Integer jid) {
		this.jid = jid;
	}

	public Userinfo getUserinfo() {
		return this.userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getKeyword() {
		return this.keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getBrowseNum() {
		return this.browseNum;
	}

	public void setBrowseNum(String browseNum) {
		this.browseNum = browseNum;
	}

	public String getPraiseNum() {
		return this.praiseNum;
	}

	public void setPraiseNum(String praiseNum) {
		this.praiseNum = praiseNum;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public Set getJcomments() {
		return this.jcomments;
	}

	public void setJcomments(Set jcomments) {
		this.jcomments = jcomments;
	}

}