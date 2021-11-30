package com.wolf.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.wolf.domain.ACommentDTO;
import com.wolf.domain.ACommentPageDTO;

@Repository
public class ACommentDAOImpl implements ACommentDAO{
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.team.mapper.ACommentMapper";

	@Override
	public List<ACommentDTO> getcomments(ACommentPageDTO PageDTO) {
		return sqlSession.selectList(namespace + ".getcomment" , PageDTO);
	}

	@Override
	public int getRecommentCount() {
		return sqlSession.selectOne(namespace + ".getcommentCount");
	}

	@Override
	public void insertRecomment(ACommentDTO ACommentdto) {
		sqlSession.insert(namespace + ".insertcomment", ACommentdto);
	}
	
}
