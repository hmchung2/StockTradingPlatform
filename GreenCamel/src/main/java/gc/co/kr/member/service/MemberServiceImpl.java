package gc.co.kr.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gc.co.kr.member.dao.MemberDAO;
import gc.co.kr.member.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;
	
	
	@Override
	public MemberVO signin(MemberVO member) {
		MemberVO userVO = memberDAO.signin(member);
		return userVO;
	}

	@Override
	public int signup(MemberVO member) {
		// TODO Auto-generated method stub		
		int row = memberDAO.signup(member);
		return row;
	}

	@Override
	public MemberVO selectByID(String id) {
		// TODO Auto-generated method stub
		MemberVO existingUser   =  memberDAO.selectByID(id);
		return existingUser;
	}
		
	
}
