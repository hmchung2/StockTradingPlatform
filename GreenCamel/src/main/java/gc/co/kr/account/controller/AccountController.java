package gc.co.kr.account.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import gc.co.kr.account.service.AccountService;
import gc.co.kr.account.vo.AccountVO;
import gc.co.kr.member.vo.MemberVO;

@SessionAttributes({ "accountVO" }) 
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
	
	
	@GetMapping("/signin")
	public String showAllAccounts(Model model, HttpSession session) {
		System.out.println("전체 계좌 조회");
		MemberVO userVO  =  (MemberVO)session.getAttribute("userVO");
		String userID = userVO.getId();
		List<AccountVO> list =  service.selectAllAccounts(userID);
		model.addAttribute("list", list);
		Map<String, String> map = new HashMap<>(); 
		model.addAttribute("map" , map);
		return "gcaccount/viewaccounts";
	}	
	
	@PostMapping("/signin")
	public String accountDetail(AccountVO accountVO, Model model, HttpSession session) {
		System.out.println("계좌 상세");
		//ModelAndView mav = new ModelAndView();		
		MemberVO userVO  =  (MemberVO)session.getAttribute("userVO");
		accountVO.setId(userVO.getId());
		System.out.println("accountVO : " + accountVO);
		String view ="";
		accountVO = service.signinAccount(accountVO);		
		System.out.println("userAccountVO : "  + accountVO);
		if(accountVO == null) {
			String  msg ="패스워드 정보가 잘못 입력 되었습니다.";
			view = showAllAccounts(model, session);
			model.addAttribute("msg" , msg);			
			System.out.println(msg);
		}else {
			model.addAttribute("accountVO", accountVO);
			System.out.println("setting user account");
			String dest = (String) session.getAttribute("dest2");
			if (dest != null) {
				session.removeAttribute("dest");
				view = "redirect:" + dest;
			} else {
				view = "redirect:/";
			}			
		}
		System.out.println("post viewaccounts view : "  + view);
		return view;		
	}
	
	@GetMapping("/htc")
	public String getHTC() {
		return "gcaccount/htc";
	}
	
	
	//view =  "gcaccount/htc";
//	@GetMapping("/htc")
//	public String htsHome(HttpSession session) {
//		AccountVO userAccountVO = (AccountVO)session.getAttribute("userAccountVO");
//		System.out.println("trading center arrived");
//		System.out.println(userAccountVO);
//		session.removeAttribute("userAccountVO");
//		return "/";
//	}	
}
