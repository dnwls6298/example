package com.wolf.domain;

import java.sql.Timestamp;

public class ACommentDTO {
	private String memId;
	private int star;
	private String comment;
	private int commentNum;
	private int recomment;
	private Timestamp date;
	private String picture;

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}

	public int getRecomment() {
		return recomment;
	}

	public void setRecomment(int recomment) {
		this.recomment = recomment;
	}

	public int getStar() {
		return star;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}
}
