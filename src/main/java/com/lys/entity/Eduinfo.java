package com.lys.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Eduinfo entity. @author MyEclipse Persistence Tools
 */

public class Eduinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	private Integer degree;
	@JSONField(name="start_time",format="yyyy.MM")
	private Date startTime;
	@JSONField(name="end_time",format="yyyy.MM")
	private Date endTime;
	@JSONField(name="college_name")
	private String collegeName;
	@JSONField(name="major_type")
	private Integer majorType;
	@JSONField(name="major_name")
	private String majorName;
	private Integer rank;
	private String detail;
	private String course;

	// Constructors

	/** default constructor */
	public Eduinfo() {
	}

	/** full constructor */
	public Eduinfo(Integer uid, Integer degree, Date startTime, Date endTime,
			String collegeName, Integer majorType, String majorName,
			Integer rank, String detail, String course) {
		this.uid = uid;
		this.degree = degree;
		this.startTime = startTime;
		this.endTime = endTime;
		this.collegeName = collegeName;
		this.majorType = majorType;
		this.majorName = majorName;
		this.rank = rank;
		this.detail = detail;
		this.course = course;
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

	public Integer getDegree() {
		return this.degree;
	}

	public void setDegree(Integer degree) {
		this.degree = degree;
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

	public String getCollegeName() {
		return this.collegeName;
	}

	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}

	public Integer getMajorType() {
		return this.majorType;
	}

	public void setMajorType(Integer majorType) {
		this.majorType = majorType;
	}

	public String getMajorName() {
		return this.majorName;
	}

	public void setMajorName(String majorName) {
		this.majorName = majorName;
	}

	public Integer getRank() {
		return this.rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}

	public String getDetail() {
		return this.detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getCourse() {
		return this.course;
	}

	public void setCourse(String course) {
		this.course = course;
	}

}