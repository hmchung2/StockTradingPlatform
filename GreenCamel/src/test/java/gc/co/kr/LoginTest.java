package gc.co.kr;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import gc.co.kr.member.service.MemberService;
import gc.co.kr.member.vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:/config/spring/spring-mvc.xml"})
public class LoginTest {
	
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	
	
	@Ignore
	@Test
	public void 멤버테스트() throws Exception{
		MemberVO member = new MemberVO();
		member.setId("user");
		MemberVO user = sessionTemplate.selectOne("member.MemberDAO.selectByID" , member);
		System.out.println(user);		
	}
	
	@Autowired
	private MemberService memberService;
	
	@Test
	public void login() throws Exception{
		MemberVO member = new MemberVO();
		member.setId("user");
		MemberVO userVO = memberService.signin(member);
		System.out.println(userVO);
	}
	
	
}
