package gc.co.kr;


import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import gc.co.kr.realtimestock.dao.RealTimeStockDAO;
import gc.co.kr.realtimestock.service.RealTimeStockService;
import gc.co.kr.realtimestock.vo.RealTimeStockVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:/config/spring/spring-mvc.xml"})
public class LoginTest {
	
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
		
	@Autowired
	private AccountDAO accountDAO;
	
	@Autowired
	private RealTimeStockDAO realtimestockDAO;
	
	@Autowired
	private RealTimeStockService realtimestockService;
	
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
	
	@Ignore
	@Test
	public void testSelectAllAccounts() throws Exception{
		List<AccountVO> list = accountDAO.selectAllAccounts("hmchung1005");
		for(AccountVO acc: list) {
			System.out.println(acc);
		}
	}
	
	@Ignore
	@Test
	public void testrealtimestockDAO() throws Exception{
		Map<String , String> testing = new HashMap<String,String>();
		testing.put("start", "2021-08-31-17:37:20");
		testing.put("end", "2021-08-31-17:40:50");
		List<RealTimeStockVO> list = realtimestockDAO.selectStockByTime(testing);
		for(RealTimeStockVO r : list) {
			System.out.println(r);
		}
	}
	@Ignore
	@Test
	public void testrealtimestockSERVICE() throws Exception{
		Map<String , String> testing = new HashMap<String,String>();
		testing.put("start", "2021-08-31-17:37:20");
		testing.put("end", "2021-08-31-17:40:50");
		List<RealTimeStockVO> list = realtimestockService.selectStockByTime(testing);
		for(RealTimeStockVO r : list) {
			System.out.println(r);
		}		
	}
	@Ignore
	@Test
	public void testGetInitValues() throws Exception{
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("fullTime", 1630460051);
		params.put("interval", 30);
		String symbolList = "AAPL";
		params.put("symbolList", symbolList);
		List<Map<String,Object>> list = realtimestockDAO.getInitValues(params);
		for(Map<String, Object> m : list) {
			System.out.println( Float.parseFloat(String.valueOf( m.get("max_value"))) );
		}				
	}
	
	@Test
	public void testGetReals() throws Exception{
		Map<String, Object> params = new HashMap<String , Object>();
		
		params.put("startTime" , 1631200787);
		params.put("endTime", 1631220787);		
		params.put("symbol", "AAPL");
		List<RealTimeStockVO> realTimeData  = realtimestockService.getRealTimeStockData(params);
		for(RealTimeStockVO r : realTimeData ) {
			System.out.println(r);
		}
		
	}
	
	
}
