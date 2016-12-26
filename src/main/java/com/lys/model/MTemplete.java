package com.lys.model;

import java.sql.Timestamp;

import com.alibaba.fastjson.annotation.JSONField;

public class MTemplete {
	
	private Integer tpId;
	private Integer tid;
	private String tname;
	private Integer uid;
	private String nickname;
	private String tpTitle;
	private Long tpSize;
	private String tpUrl;
	private Boolean isOpen;
	@JSONField(format="yyyy-MM-dd")
	private Timestamp tpTime;
	private Integer downloadNum;
	private Integer clickNum;
	private Integer collectNum;
	
	public MTemplete() {
		
	}
	
	public Integer getTpId() {
		return tpId;
	}
	public void setTpId(Integer tpId) {
		this.tpId = tpId;
	}
	public Integer getTid() {
		return tid;
	}
	public void setTid(Integer tid) {
		this.tid = tid;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getTpTitle() {
		return tpTitle;
	}
	public void setTpTitle(String tpTitle) {
		this.tpTitle = tpTitle;
	}
	public Long getTpSize() {
		return tpSize;
	}
	public void setTpSize(Long tpSize) {
		this.tpSize = tpSize;
	}
	public String getTpUrl() {
		return tpUrl;
	}
	public void setTpUrl(String tpUrl) {
		this.tpUrl = tpUrl;
	}
	public Boolean getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(Boolean isOpen) {
		this.isOpen = isOpen;
	}
	public Timestamp getTpTime() {
		return tpTime;
	}
	public void setTpTime(Timestamp tpTime) {
		this.tpTime = tpTime;
	}
	public Integer getDownloadNum() {
		return downloadNum;
	}
	public void setDownloadNum(Integer downloadNum) {
		this.downloadNum = downloadNum;
	}
	public Integer getClickNum() {
		return clickNum;
	}
	public void setClickNum(Integer clickNum) {
		this.clickNum = clickNum;
	}
	public Integer getCollectNum() {
		return collectNum;
	}
	public void setCollectNum(Integer collectNum) {
		this.collectNum = collectNum;
	}
	

}
