package com.berlizz.domain;

import java.util.Date;

public class ReplyVO {

	private Integer replyNumber;
	private Integer listNumber;
	private String replytext;
	private String replyWriter;
	private Date regDate;
	private Date updateDate;
	
	@Override
	public String toString() {
		return "ReplyVO : [replyNumber = " + replyNumber + "]";
	}

	public Integer getReplyNumber() {
		return replyNumber;
	}

	public void setReplyNumber(Integer replyNumber) {
		this.replyNumber = replyNumber;
	}

	public Integer getListNumber() {
		return listNumber;
	}

	public void setListNumber(Integer listNumber) {
		this.listNumber = listNumber;
	}

	public String getReplytext() {
		return replytext;
	}

	public void setReplytext(String replytext) {
		this.replytext = replytext;
	}

	public String getReplyWriter() {
		return replyWriter;
	}

	public void setReplyWriter(String replyWriter) {
		this.replyWriter = replyWriter;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	
	
	
}
