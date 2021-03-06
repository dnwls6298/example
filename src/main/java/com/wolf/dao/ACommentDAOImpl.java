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
	public int getcommentCount() {
		return sqlSession.selectOne(namespace + ".getcommentCount");
	}

	@Override
	public void insertcomment(ACommentDTO ACommentdto) {
		sqlSession.insert(namespace + ".insertcomment", ACommentdto);
	}

	@Override
	public List<ACommentDTO> getrecomments(ACommentPageDTO PageDTO) {
		return sqlSession.selectList(namespace + ".getrecomment" , PageDTO);
	}

	@Override
	public int getrecommentCount(ACommentPageDTO PageDTO) {
		return sqlSession.selectOne(namespace + ".getrecommentCount" , PageDTO);
	}

	@Override
	public void insertRecomment(ACommentDTO ACommentdto) {
		sqlSession.insert(namespace + ".insertrecomment", ACommentdto);
	}

	@Override
	public void insertPiture(ACommentDTO ACommentdto) {
		sqlSession.insert(namespace + ".insertpicture", ACommentdto);
		
	}

	@Override
	public List<ACommentDTO> checkcomment(ACommentDTO ACommentdto) {
		return sqlSession.selectList(namespace + ".checkcomment",ACommentdto);
	}

	@Override
	public String deleteComment(int commentNum) {
		String filename = sqlSession.selectOne(namespace + ".getFilename" , commentNum);
		sqlSession.delete(namespace + ".deletecomment", commentNum);
		return filename;
	}

	@Override
	public List<ACommentDTO> checkrecomment(String memid, int commentNum) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
