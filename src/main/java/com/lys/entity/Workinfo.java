package com.lys.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Workinfo entity. @author MyEclipse Persistence Tools
 */

public class Workinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	@JSONField(name="work_type")
	private Integer workType;
	@JSONField(name="company_name")
	private String companyName;
	@JSONField(name="company_scale")
	private Integer companyScale;
	@JSONField(name="position_name")
	private String positionName;
	@JSONField(name="start_time",format="yyyy.MM")
	private Date startTime;
	@JSONField(name="end_time",format="yyyy.MM")
	private Date endTime;
	private String detail;

	// Constructors

	/** default constructor */
	public Workinfo() {
	}

	/** full constructor */
	public Workinfo(Integer uid, Integer workType, String companyName,
			Integer companyScale, String positionName, Date startTime,
			Date endTime, String detail) {
		this.uid = uid;
		this.workType = workType;
		this.companyName = companyName;
		this.companyScale = companyScale;
		this.positionName = positionName;
		this.startTime = startTime;
		this.endTime = endTime;
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

	public Integer getWorkType() {
		return this.workType;
	}

	public void setWorkType(Integer workType) {
		this.workType = workType;
	}

	public String getCompanyName() {
		return this.companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public Integer getCompanyScale() {
		return this.companyScale;
	}

	public void setCompanyScale(Integer companyScale) {
		this.companyScale = companyScale;
	}

	public String getPositionName() {
		return this.positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getDetail() {
		return this.detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

}