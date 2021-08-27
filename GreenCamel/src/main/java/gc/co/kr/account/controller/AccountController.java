package gc.co.kr.account.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gc.co.kr.account.service.AccountService;
import gc.co.kr.account.vo.AccountVO;
import gc.co.kr.member.vo.MemberVO;


@Controller
@RequestMapping("/account")
public class AccountController { 
	
	@Autowired
	private AccountService service;
	

	
	@GetMapping("/contract")
	public String getContract() {
		System.out.println("contract");		
		return "gcaccount/accountContract";		
	}
	
	@GetMapping("/create")
	public String createAccountForm(Model model) {
		System.out.println("create");
		model.addAttribute("accountVO" , new AccountVO());
		return "gcaccount/create";
	}
	
	@PostMapping("/create")
	public String createAccount(AccountVO account, Model model, HttpSession session) {		
		System.out.println("inserting new account");
		System.out.println("inserted account  info: " + account);
		String msg = "";
		String view = "";
		try {
			MemberVO userVO  =  (MemberVO)session.getAttribute("userVO");
			account.setId(userVO.getId());
			int row = service.createAcc(account);
			if(row == 1) {
				msg ="성공적으로 계좌를 생성 했습니다.";
				String dest = (String) session.getAttribute("dest");
				if(dest != null) {
					session.removeAttribute(dest);
					view = "redirect:" + dest;
				}else {
					view = "redirect:/";
				}
			}else {
				msg = "계좌번호 생성시 문제가 발생 했습니다.";
				view = "gcaccount/create";
			}
		}catch (Exception e) {
			e.printStackTrace();
			msg = "서버에 문제 발생 했습니다.";			
			view = "gcaccount/create";
		}
		System.out.println(msg);
		session.setAttribute("msg", msg);
		return view;
	}
	
	
	@GetMapping("/showall")
	public String showAllAccounts(HttpSession session) {
		System.out.println("전체 계좌 조회");
		MemberVO userVO  =  (MemberVO)session.getAttribute("userVO");
		String userID = userVO.getId();
		List<AccountVO> list =  service.selectAllAccounts(userID);

		
		
		return "gcaccount/showall";
	}	
	
	
	
}
