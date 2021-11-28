package com.wolf.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.wolf.domain.ACommentDTO;

@Repository
public class ACommentDAOImpl implements ACommentDAO{
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.team.mapper.ACommentMapper";

	@Override
	public List<ACommentDTO> getcomments() {
		
		return sqlSession.selectList(namespace + ".getcomment");
	}
}
