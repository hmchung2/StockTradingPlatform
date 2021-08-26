package gc.co.kr.member.dao;

import gc.co.kr.member.vo.MemberVO;

public interface MemberDAO {
	
	MemberVO signin(MemberVO member);
	
	int signup(MemberVO member);
	
	MemberVO selectByID(String id);

}
