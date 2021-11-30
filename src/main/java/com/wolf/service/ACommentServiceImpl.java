package com.wolf.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.wolf.dao.ACommentDAO;
import com.wolf.domain.ACommentDTO;
import com.wolf.domain.ACommentPageDTO;

@Service
public class ACommentServiceImpl implements ACommentService{
	
	@Inject
	private ACommentDAO ACommentDAO;

	@Override
	public List<ACommentDTO> getcomments(ACommentPageDTO PageDTO) {
		return ACommentDAO.getcomments(PageDTO);
	}

	@Override
	public int getRecommentCount() {
		return ACommentDAO.getRecommentCount();
	}

	@Override
	public void insertRecomment(ACommentDTO ACommentdto) {
		ACommentDAO.insertRecomment(ACommentdto);
	}

	@Override
	public List<ACommentDTO> getrecomments(ACommentPageDTO PageDTO) {
		return ACommentDAO.getrecomments(PageDTO);
	}

}
