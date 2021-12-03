package com.wolf.dao;

import java.util.List;

import com.wolf.domain.ACommentDTO;
import com.wolf.domain.ACommentPageDTO;

public interface ACommentDAO {
	public List<ACommentDTO> getcomments(ACommentPageDTO PageDTO);
	
	public int getcommentCount();
	
	public void insertcomment(ACommentDTO ACommentdto);
	
	public List<ACommentDTO> getrecomments(ACommentPageDTO PageDTO);
	
	public int getrecommentCount(ACommentPageDTO PageDTO);
	
	public void insertRecomment(ACommentDTO ACommentdto);
	
	public void insertPiture(ACommentDTO ACommentdto);
	
	public List<ACommentDTO> checkcomment(ACommentDTO ACommentdto);
	
	public String deleteComment(int commentNum);
	
	public List<ACommentDTO> checkrecomment(String memid,int commentNum);
}
