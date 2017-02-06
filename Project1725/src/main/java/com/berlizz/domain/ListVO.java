package com.berlizz.domain;

import java.util.Date;

public class ListVO {

	private Integer listNumber;
	private String title;
	private String writer;
	private String description;
	private Date regTimestamp;
	private String regDate;
	private Boolean completed;
	
	@Override
	public String toString() {
		return "ListVO : [listNumber = " + listNumber + "]";
	}

	public Integer getListNumber() {
		return listNumber;
	}

	public void setListNumber(Integer listNumber) {
		this.listNumber = listNumber;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getRegTimestamp() {
		return regTimestamp;
	}

	public void setRegTimestamp(Date regTimestamp) {
		this.regTimestamp = regTimestamp;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public Boolean getCompleted() {
		return completed;
	}

	public void setCompleted(Boolean completed) {
		this.completed = completed;
	}
	
	
}
