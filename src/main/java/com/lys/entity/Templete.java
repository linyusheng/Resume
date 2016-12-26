package com.lys.entity;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Templete entity. @author MyEclipse Persistence Tools
 */

public class Templete implements java.io.Serializable {

	// Fields

	private Integer tpId;
	private Type type;
	private Userinfo userinfo;
	private String tpTitle;
	private Long tpSize;
	private String tpUrl;
	private Boolean isOpen;
	private Timestamp tpTime;
	private Integer downloadNum;
	private Integer clickNum;
	private Integer collectNum;
	private Set grades = new HashSet(0);

	// Constructors

	/** default constructor */
	public Templete() {
	}

	/** full constructor */
	public Templete(Type type, Userinfo userinfo, String tpTitle, Long tpSize,
			String tpUrl, Boolean isOpen, Timestamp tpTime,
			Integer downloadNum, Integer clickNum, Integer collectNum,
			Set grades) {
		this.type = type;
		this.userinfo = userinfo;
		this.tpTitle = tpTitle;
		this.tpSize = tpSize;
		this.tpUrl = tpUrl;
		this.isOpen = isOpen;
		this.tpTime = tpTime;
		this.downloadNum = downloadNum;
		this.clickNum = clickNum;
		this.collectNum = collectNum;
		this.grades = grades;
	}

	// Property accessors

	public Integer getTpId() {
		return this.tpId;
	}

	public void setTpId(Integer tpId) {
		this.tpId = tpId;
	}

	public Type getType() {
		return this.type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public Userinfo getUserinfo() {
		return this.userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public String getTpTitle() {
		return this.tpTitle;
	}

	public void setTpTitle(String tpTitle) {
		this.tpTitle = tpTitle;
	}

	public Long getTpSize() {
		return this.tpSize;
	}

	public void setTpSize(Long tpSize) {
		this.tpSize = tpSize;
	}

	public String getTpUrl() {
		return this.tpUrl;
	}

	public void setTpUrl(String tpUrl) {
		this.tpUrl = tpUrl;
	}

	public Boolean getIsOpen() {
		return this.isOpen;
	}

	public void setIsOpen(Boolean isOpen) {
		this.isOpen = isOpen;
	}

	public Timestamp getTpTime() {
		return this.tpTime;
	}

	public void setTpTime(Timestamp tpTime) {
		this.tpTime = tpTime;
	}

	public Integer getDownloadNum() {
		return this.downloadNum;
	}

	public void setDownloadNum(Integer downloadNum) {
		this.downloadNum = downloadNum;
	}

	public Integer getClickNum() {
		return this.clickNum;
	}

	public void setClickNum(Integer clickNum) {
		this.clickNum = clickNum;
	}

	public Integer getCollectNum() {
		return this.collectNum;
	}

	public void setCollectNum(Integer collectNum) {
		this.collectNum = collectNum;
	}

	public Set getGrades() {
		return this.grades;
	}

	public void setGrades(Set grades) {
		this.grades = grades;
	}

}