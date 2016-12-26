package com.lys.entity;

/**
 * Abiinfo entity. @author MyEclipse Persistence Tools
 */

public class Abiinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	private String languageAbility;
	private String itAbility;
	private String certificate;
	private String characters;
	private String hobby;

	// Constructors

	/** default constructor */
	public Abiinfo() {
	}

	/** full constructor */
	public Abiinfo(Integer uid, String languageAbility, String itAbility,
			String certificate, String characters, String hobby) {
		this.uid = uid;
		this.languageAbility = languageAbility;
		this.itAbility = itAbility;
		this.certificate = certificate;
		this.characters = characters;
		this.hobby = hobby;
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

	public String getLanguageAbility() {
		return this.languageAbility;
	}

	public void setLanguageAbility(String languageAbility) {
		this.languageAbility = languageAbility;
	}

	public String getItAbility() {
		return this.itAbility;
	}

	public void setItAbility(String itAbility) {
		this.itAbility = itAbility;
	}

	public String getCertificate() {
		return this.certificate;
	}

	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}

	public String getCharacters() {
		return this.characters;
	}

	public void setCharacters(String characters) {
		this.characters = characters;
	}

	public String getHobby() {
		return this.hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

}