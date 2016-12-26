package com.lys.entity;

import java.sql.Timestamp;

/**
 * Userinfo entity. @author MyEclipse Persistence Tools
 */

public class Userinfo implements java.io.Serializable {

	// Fields

	private Integer uid;
	private String utype;
	private String openId;
	private String account;
	private String pwd;
	private String nickname;
	private String head;
	private Integer level;
	private Integer exp;
	private Integer point;
	private Integer browseNum;
	private String question;
	private String answer;
	private Timestamp utime;
	private Timestamp loginTime;
	private Integer editNum;
	private Boolean status;
	private String validateCode;
	private Timestamp lastActivateTime;
	private Integer integrity;

	// Constructors

	/** default constructor */
	public Userinfo() {
	}

	/** full constructor */
	public Userinfo(String utype, String openId, String account, String pwd,
			String nickname, String head, Integer level, Integer exp,
			Integer point, Integer browseNum, String question, String answer,
			Timestamp utime, Timestamp loginTime, Integer editNum,
			Boolean status, String validateCode, Timestamp lastActivateTime,
			Integer integrity) {
		this.utype = utype;
		this.openId = openId;
		this.account = account;
		this.pwd = pwd;
		this.nickname = nickname;
		this.head = head;
		this.level = level;
		this.exp = exp;
		this.point = point;
		this.browseNum = browseNum;
		this.question = question;
		this.answer = answer;
		this.utime = utime;
		this.loginTime = loginTime;
		this.editNum = editNum;
		this.status = status;
		this.validateCode = validateCode;
		this.lastActivateTime = lastActivateTime;
		this.integrity = integrity;
	}

	// Property accessors

	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public String getUtype() {
		return this.utype;
	}

	public void setUtype(String utype) {
		this.utype = utype;
	}

	public String getOpenId() {
		return this.openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public String getAccount() {
		return this.account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPwd() {
		return this.pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNickname() {
		return this.nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getHead() {
		return this.head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getExp() {
		return this.exp;
	}

	public void setExp(Integer exp) {
		this.exp = exp;
	}

	public Integer getPoint() {
		return this.point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}

	public Integer getBrowseNum() {
		return this.browseNum;
	}

	public void setBrowseNum(Integer browseNum) {
		this.browseNum = browseNum;
	}

	public String getQuestion() {
		return this.question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return this.answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Timestamp getUtime() {
		return this.utime;
	}

	public void setUtime(Timestamp utime) {
		this.utime = utime;
	}

	public Timestamp getLoginTime() {
		return this.loginTime;
	}

	public void setLoginTime(Timestamp loginTime) {
		this.loginTime = loginTime;
	}

	public Integer getEditNum() {
		return this.editNum;
	}

	public void setEditNum(Integer editNum) {
		this.editNum = editNum;
	}

	public Boolean getStatus() {
		return this.status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public String getValidateCode() {
		return this.validateCode;
	}

	public void setValidateCode(String validateCode) {
		this.validateCode = validateCode;
	}

	public Timestamp getLastActivateTime() {
		return this.lastActivateTime;
	}

	public void setLastActivateTime(Timestamp lastActivateTime) {
		this.lastActivateTime = lastActivateTime;
	}

	public Integer getIntegrity() {
		return this.integrity;
	}

	public void setIntegrity(Integer integrity) {
		this.integrity = integrity;
	}

}