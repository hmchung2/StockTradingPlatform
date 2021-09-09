package gc.co.kr.ajax;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gc.co.kr.account.service.AccountService;
import gc.co.kr.leagueAccount.LeagueAccountService;
import gc.co.kr.leagueAccount.LeagueAccountVO;

@Controller
@RequestMapping("/ajax/account")
public class ResBodyAccount {	
	@Autowired
	private AccountService service;
	
	@Autowired
	private LeagueAccountService leagueService;
}
