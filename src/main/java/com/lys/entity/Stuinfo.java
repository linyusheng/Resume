package com.lys.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Stuinfo entity. @author MyEclipse Persistence Tools
 */

public class Stuinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	@JSONField(name="college_name")
	private String collegeName;
	private String position;
	private String department;
	@JSONField(name="start_time",format="yyyy.MM")
	private Date startTime;
	@JSONField(name="end_time",format="yyyy.MM")
	private Date endTime;
	private String performance;

	// Constructors

	/** default constructor */
	public Stuinfo() {
	}

	/** full constructor */
	public Stuinfo(Integer uid, String collegeName, String position,
			String department, Date startTime, Date endTime, String performance) {
		this.uid = uid;
		this.collegeName = collegeName;
		this.position = position;
		this.department = department;
		this.startTime = startTime;
		this.endTime = endTime;
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

	public String getCollegeName() {
		return this.collegeName;
	}

	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}

	public String getPosition() {
		return this.position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getDepartment() {
		return this.department;
	}

	public void setDepartment(String department) {
		this.department = department;
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

	public String getPerformance() {
		return this.performance;
	}

	public void setPerformance(String performance) {
		this.performance = performance;
	}

}