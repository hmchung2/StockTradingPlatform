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
	public MemberVO login(MemberVO member) {
		MemberVO userVO = memberDAO.login(member);
		return userVO;
	}
}
