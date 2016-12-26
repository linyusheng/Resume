package com.lys.entity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Honinfo entity. @author MyEclipse Persistence Tools
 */

public class Honinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	@JSONField(name="world_prize")
	private String worldPrize;
	@JSONField(name="national_prize")
	private String nationalPrize;
	@JSONField(name="province_prize")
	private String provincePrize;
	@JSONField(name="college_prize")
	private String collegePrize;
	@JSONField(name="other_prize")
	private String otherPrize;

	// Constructors

	/** default constructor */
	public Honinfo() {
	}

	/** full constructor */
	public Honinfo(Integer uid, String worldPrize, String nationalPrize,
			String provincePrize, String collegePrize, String otherPrize) {
		this.uid = uid;
		this.worldPrize = worldPrize;
		this.nationalPrize = nationalPrize;
		this.provincePrize = provincePrize;
		this.collegePrize = collegePrize;
		this.otherPrize = otherPrize;
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

	public String getWorldPrize() {
		return this.worldPrize;
	}

	public void setWorldPrize(String worldPrize) {
		this.worldPrize = worldPrize;
	}

	public String getNationalPrize() {
		return this.nationalPrize;
	}

	public void setNationalPrize(String nationalPrize) {
		this.nationalPrize = nationalPrize;
	}

	public String getProvincePrize() {
		return this.provincePrize;
	}

	public void setProvincePrize(String provincePrize) {
		this.provincePrize = provincePrize;
	}

	public String getCollegePrize() {
		return this.collegePrize;
	}

	public void setCollegePrize(String collegePrize) {
		this.collegePrize = collegePrize;
	}

	public String getOtherPrize() {
		return this.otherPrize;
	}

	public void setOtherPrize(String otherPrize) {
		this.otherPrize = otherPrize;
	}

}