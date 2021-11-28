package com.wolf.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.wolf.dao.ACommentDAO;
import com.wolf.domain.ACommentDTO;

@Service
public class ACommentServiceImpl implements ACommentService{
	
	@Inject
	private ACommentDAO ACommentDAO;

	@Override
	public List<ACommentDTO> getcomments() {
		return ACommentDAO.getcomments();
	}

}
