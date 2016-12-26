package com.lys.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Cominfo entity. @author MyEclipse Persistence Tools
 */

public class Cominfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	@JSONField(name="project_name")
	private String projectName;
	@JSONField(name="project_scale")
	private Integer projectScale;
	@JSONField(name="project_source")
	private String projectSource;
	@JSONField(name="position_name")
	private String positionName;
	@JSONField(name="start_time",format="yyyy.MM")
	private Date startTime;
	@JSONField(name="end_time",format="yyyy.MM")
	private Date endTime;
	private String detail;
	private String performance;

	// Constructors

	/** default constructor */
	public Cominfo() {
	}

	/** full constructor */
	public Cominfo(Integer uid, String projectName, Integer projectScale,
			String projectSource, String positionName, Date startTime,
			Date endTime, String detail, String performance) {
		this.uid = uid;
		this.projectName = projectName;
		this.projectScale = projectScale;
		this.projectSource = projectSource;
		this.positionName = positionName;
		this.startTime = startTime;
		this.endTime = endTime;
		this.detail = detail;
		this.performance = performance;
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

	public String getProjectName() {
		return this.projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public Integer getProjectScale() {
		return this.projectScale;
	}

	public void setProjectScale(Integer projectScale) {
		this.projectScale = projectScale;
	}

	public String getProjectSource() {
		return this.projectSource;
	}

	public void setProjectSource(String projectSource) {
		this.projectSource = projectSource;
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

	public String getPerformance() {
		return this.performance;
	}

	public void setPerformance(String performance) {
		this.performance = performance;
	}

}