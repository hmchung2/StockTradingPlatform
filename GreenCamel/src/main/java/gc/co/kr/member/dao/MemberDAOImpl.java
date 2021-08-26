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
		System.out.println("sign in ");
		MemberVO userVO = sqlSessionTemplate.selectOne("member.MemberDAO.signin" , member);		
		System.out.println("signed in");
		return userVO;
	}

	public int signup(MemberVO member) {
		// TODO Auto-generated method stub		
		int row = 	sqlSessionTemplate.insert("member.MemberDAO.signup", member);
		sqlSessionTemplate.commit();
		return row;
	}
	
	
	public MemberVO selectByID(String id) {		
		MemberVO existingUser = sqlSessionTemplate.selectOne("member.MemberDAO.selectByID" , id);		
		return existingUser;		
	}	
}	
