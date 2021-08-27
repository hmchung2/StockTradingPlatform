package gc.co.kr;


import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import gc.co.kr.account.dao.AccountDAO;
import gc.co.kr.account.vo.AccountVO;
import gc.co.kr.member.service.MemberService;
import gc.co.kr.member.vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:/config/spring/spring-mvc.xml"})
public class LoginTest {
	
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
		
	@Autowired
	private AccountDAO accountDAO;
	
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

	@Ignore
	@Test
	public void login() throws Exception{
		MemberVO member = new MemberVO();
		member.setId("user");
		MemberVO userVO = memberService.signin(member);
		System.out.println(userVO);
	}
	
	@Ignore
	@Test
	public void testSelectAccount() throws Exception{
		AccountVO newAccount = new AccountVO();
		newAccount.setBalance(5000);
		newAccount.setId("hmchung1005");
		newAccount.setGcaPassword("12345");
		newAccount.setGcaNumber("1234561235");
		int row = accountDAO.createAcc(newAccount);
		System.out.println(row);
	}
	
	@Test
	public void testSelectAllAccounts() throws Exception{
		List<AccountVO> list = accountDAO.selectAllAccounts("hmchung1005");
		for(AccountVO acc: list) {
			System.out.println(acc);
		}
	}
	
	
	
}
