package com.lys.entity;

import java.sql.Timestamp;

/**
 * Guide entity. @author MyEclipse Persistence Tools
 */

public class Guide implements java.io.Serializable {

	// Fields

	private Integer id;
	private String question;
	private String answer;
	private String url;
	private Short isShow;
	private Timestamp time;

	// Constructors

	/** default constructor */
	public Guide() {
	}

	/** full constructor */
	public Guide(String question, String answer, String url, Short isShow,
			Timestamp time) {
		this.question = question;
		this.answer = answer;
		this.url = url;
		this.isShow = isShow;
		this.time = time;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Short getIsShow() {
		return this.isShow;
	}

	public void setIsShow(Short isShow) {
		this.isShow = isShow;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

}