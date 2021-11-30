package com.wolf.service;

import java.util.List;

import com.wolf.domain.ACommentDTO;
import com.wolf.domain.ACommentPageDTO;

public interface ACommentService {
	public List<ACommentDTO> getcomments(ACommentPageDTO PageDTO);
	
	public int getRecommentCount();
	
	public void insertRecomment(ACommentDTO ACommentdto);
	
	public List<ACommentDTO> getrecomments(ACommentPageDTO PageDTO);
}
