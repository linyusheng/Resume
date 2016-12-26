package com.lys.model;

import java.util.List;

public class MAbiinfo {
	
	private List<Language> languageAbility;
	private List<It> itAbility;
	private List<String> certificate;
	private List<String> character;
	private List<String> hobby;
	
	public List<Language> getLanguageAbility() {
		return languageAbility;
	}
	public void setLanguageAbility(List<Language> languageAbility) {
		this.languageAbility = languageAbility;
	}
	public List<It> getItAbility() {
		return itAbility;
	}
	public void setItAbility(List<It> itAbility) {
		this.itAbility = itAbility;
	}
	public List<String> getCertificate() {
		return certificate;
	}
	public void setCertificate(List<String> certificate) {
		this.certificate = certificate;
	}
	public List<String> getCharacter() {
		return character;
	}
	public void setCharacter(List<String> character) {
		this.character = character;
	}
	public List<String> getHobby() {
		return hobby;
	}
	public void setHobby(List<String> hobby) {
		this.hobby = hobby;
	}
	

}
