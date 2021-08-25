package gc.co.kr.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import gc.co.kr.member.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public MemberVO signin(MemberVO member) {		
		MemberVO userVO = sqlSessionTemplate.selectOne("member.MemberDAO.signin" , member);		
		return userVO;
	}	
}	