package gc.co.kr.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import gc.co.kr.member.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSession session;
	
	public MemberVO signin(MemberVO member) {
		System.out.println("sign in try");
		MemberVO userVO = sqlSessionTemplate.selectOne("member.MemberDAO.signin" , member);		
		System.out.println("sign in done");
		return userVO;
	}

	public int signup(MemberVO member) {
		// TODO Auto-generated method stub		
		System.out.println("inserting new member");
		int row = 	session.insert("member.MemberDAO.signup", member);
		return row;
	}
	
	
	public MemberVO selectByID(String id) {		
		MemberVO existingUser = sqlSessionTemplate.selectOne("member.MemberDAO.selectByID" , id);		
		return existingUser;		
	}	
}	
