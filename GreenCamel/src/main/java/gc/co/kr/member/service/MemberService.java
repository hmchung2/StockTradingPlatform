package gc.co.kr.member.service;

import gc.co.kr.member.vo.MemberVO;

public interface MemberService {
	
	MemberVO signin(MemberVO member);
	
	int signup(MemberVO member);
	
	MemberVO selectByID(String id);
	
}
