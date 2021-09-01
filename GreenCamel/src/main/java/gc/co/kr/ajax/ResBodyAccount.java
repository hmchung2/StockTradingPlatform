package gc.co.kr.ajax;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import gc.co.kr.account.service.AccountService;

@Controller
@RequestMapping("/ajax")
public class ResBodyAccount {
	
	@Autowired
	private AccountService service;
	
	

}
