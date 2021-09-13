package gc.co.kr.account.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import gc.co.kr.account.service.AccountService;
import gc.co.kr.account.vo.AccountVO;
import gc.co.kr.leagueAccount.LeagueAccountService;
import gc.co.kr.leagueAccount.LeagueAccountVO;
import gc.co.kr.leagueAccount.LeagueFollowVO;
import gc.co.kr.member.vo.MemberVO;
import gc.co.kr.stocksummary.service.StockSummaryService;
import gc.co.kr.stocksummary.vo.StockNameVO;
import gc.co.kr.stocksummary.vo.StockSummaryVO;

@Controller
@RequestMapping("/account")
public class AccountController { 
	
	@Autowired
	private AccountService service;
	
	@Autowired
	private LeagueAccountService leagueService;
	
	@Autowired
	private StockSummaryService summaryService;
	

	
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
		List<LeagueFollowVO> leagueFollowVOlist = leagueService.selectFollowers(userID);
		LeagueAccountVO leagueAccountVO = leagueService.selectLeagueAcc(userID);
		model.addAttribute("leagueFollowList", leagueFollowVOlist );
		model.addAttribute("leagueAccountVO", leagueAccountVO);		
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
			session.setAttribute("accountVO", accountVO);
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
	
	
	@PostMapping("/leagueSignin")
	public String leagueAccountDetail(@RequestParam("password") String password , Model model , HttpSession session  ) {
		System.out.println("league sign in");
		MemberVO userVO  =  (MemberVO)session.getAttribute("userVO");
		String view;
		String msg;
		if( password != null && !password.equals(userVO.getPassword() ) ) {
			System.out.println("password : " + password);
			System.out.println("userpassword : " + userVO.getPassword());
			msg ="패스워드 정보가 잘못 입력 되었습니다.";
			view = showAllAccounts(model, session);
			model.addAttribute("msg", msg);
		}else {
			LeagueAccountVO leagueAccountVO = leagueService.selectLeagueAcc(userVO.getId());
			if(leagueAccountVO == null) {
				msg ="리그 계좌가 없습니다.";
				view = showAllAccounts(model, session);
				model.addAttribute("msg" , msg);
				System.out.println( msg);
			}else {
				session.setAttribute("leagueAccountVO", leagueAccountVO);
				System.out.println("setting user league Account");
				String dest = (String) session.getAttribute("dest2");
				if(dest != null) {
					view = "redirect:" + dest;
					session.removeAttribute("dest");
				}else {
					view = "redirect:/";					
				}
				System.out.println("성공");
				
			}
		}
		
		System.out.println("post viewleagueaccounts : " + view);
		return view;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	@PostMapping("/createLeagueAcc")
	public String createLeagueAcc(Model model ,  HttpSession session) {
		System.out.println("creating new League Account");
		LeagueAccountVO leagueAccountVO =  new LeagueAccountVO();
		String id = ((MemberVO)session.getAttribute("userVO")).getId();		
		leagueAccountVO.setId(id);
		leagueAccountVO.setBalance(100000000);
		leagueAccountVO.setFollowPrice(0);
		leagueAccountVO.setTier("BRONZE");
		LeagueAccountVO existingCheck = leagueService.selectLeagueAcc(id);
		String msg = "";
		if(existingCheck != null) {
			msg = "warning:Error:이미 리그 계좌가 존재 합니다. 계좌 초기화 하시겠습니까?";
		}else {
			int row = leagueService.createLeagueAcc(leagueAccountVO);			
			if(row == 1) {
				msg = "success:회원가입 성공:리그 계좌를 성공적으로 생성 했습니다.";			
			}else {
				msg = "warning:Error:계좌 생성 중 문제가 발생했습니다.";
			}
		}	
		session.setAttribute("msg", msg);
		return "redirect:/account/signin";	
	}
	
	
	@GetMapping("/signout")
	public String accountSignout(HttpSession session) {
		session.removeAttribute("accountVO");
		return "redirect:/account/signin";
	}
		
	@GetMapping("/hts")
	public String getHTC(Model model) {
		List<StockSummaryVO> stockSummaryList = null;
		List<StockNameVO> stockNameList =  summaryService.selectAllStockNames();
		List<String>  symbols= new ArrayList<String>();
		if(stockNameList != null && stockNameList.size() > 0) {			
			for(StockNameVO stock : stockNameList) {
				symbols.add(stock.getSymbol());
			}			
			stockSummaryList = summaryService.selectCurrentStockSummary(symbols);			
		}
		
		Map<String, String> stockNameMap = new HashMap<String, String>();
		
		for( StockNameVO stock : stockNameList   ) {
			stockNameMap.put(stock.getSymbol() , stock.getLongName() );
		}
				
		Gson gson = new Gson();
        String serializeString = gson.toJson(stockNameMap);
        model.addAttribute("stockNameMap" , serializeString);			
		model.addAttribute("stockSummaryList" , stockSummaryList);				
		return "gcaccount/hts";
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
