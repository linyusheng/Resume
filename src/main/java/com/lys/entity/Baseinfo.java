package com.lys.entity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Baseinfo entity. @author MyEclipse Persistence Tools
 */

public class Baseinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	private String name;
	private Integer sex;
	@JSONField(name="birth_date")
	private String birthDate;
	private String email;
	private String phone;
	private String address;
	private String postcode;
	@JSONField(name="politics_status")
	private Integer politicsStatus;
	@JSONField(name="face_large_full_url")
	private String faceLargeFullUrl;
	private String university;
	private String education;
	private String degree;
	private String major;
	private String graduation;
	private String trade;
	private String position;
	private String city;
	private String rname;
	private String keyword;
	private String browseNum;
	private String collectNum;

	// Constructors

	/** default constructor */
	public Baseinfo() {
	}

	/** full constructor */
	public Baseinfo(Integer uid, String name, Integer sex, String birthDate,
			String email, String phone, String address, String postcode,
			Integer politicsStatus, String faceLargeFullUrl, String university,
			String education, String degree, String major, String graduation,
			String trade, String position, String city, String rname,
			String keyword, String browseNum, String collectNum) {
		this.uid = uid;
		this.name = name;
		this.sex = sex;
		this.birthDate = birthDate;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.postcode = postcode;
		this.politicsStatus = politicsStatus;
		this.faceLargeFullUrl = faceLargeFullUrl;
		this.university = university;
		this.education = education;
		this.degree = degree;
		this.major = major;
		this.graduation = graduation;
		this.trade = trade;
		this.position = position;
		this.city = city;
		this.rname = rname;
		this.keyword = keyword;
		this.browseNum = browseNum;
		this.collectNum = collectNum;
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

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSex() {
		return this.sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getBirthDate() {
		return this.birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostcode() {
		return this.postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public Integer getPoliticsStatus() {
		return this.politicsStatus;
	}

	public void setPoliticsStatus(Integer politicsStatus) {
		this.politicsStatus = politicsStatus;
	}

	public String getFaceLargeFullUrl() {
		return this.faceLargeFullUrl;
	}

	public void setFaceLargeFullUrl(String faceLargeFullUrl) {
		this.faceLargeFullUrl = faceLargeFullUrl;
	}

	public String getUniversity() {
		return this.university;
	}

	public void setUniversity(String university) {
		this.university = university;
	}

	public String getEducation() {
		return this.education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getDegree() {
		return this.degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public String getMajor() {
		return this.major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getGraduation() {
		return this.graduation;
	}

	public void setGraduation(String graduation) {
		this.graduation = graduation;
	}

	public String getTrade() {
		return this.trade;
	}

	public void setTrade(String trade) {
		this.trade = trade;
	}

	public String getPosition() {
		return this.position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getRname() {
		return this.rname;
	}

	public void setRname(String rname) {
		this.rname = rname;
	}

	public String getKeyword() {
		return this.keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getBrowseNum() {
		return this.browseNum;
	}

	public void setBrowseNum(String browseNum) {
		this.browseNum = browseNum;
	}

	public String getCollectNum() {
		return this.collectNum;
	}

	public void setCollectNum(String collectNum) {
		this.collectNum = collectNum;
	}

}