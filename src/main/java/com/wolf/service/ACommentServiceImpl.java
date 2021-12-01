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
	public int getcommentCount() {
		return ACommentDAO.getcommentCount();
	}

	@Override
	public void insertcomment(ACommentDTO ACommentdto) {
		ACommentDAO.insertcomment(ACommentdto);
	}

	@Override
	public List<ACommentDTO> getrecomments(ACommentPageDTO PageDTO) {
		return ACommentDAO.getrecomments(PageDTO);
	}

	@Override
	public int getrecommentCount(ACommentPageDTO PageDTO) {
		return ACommentDAO.getrecommentCount(PageDTO);
	}

	@Override
	public void insertRecomment(ACommentDTO ACommentdto) {
		ACommentDAO.insertRecomment(ACommentdto);
	}

}
