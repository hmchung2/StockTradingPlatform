package gc.co.kr.member.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import gc.co.kr.member.service.MemberService;
import gc.co.kr.member.vo.MemberVO;

@SessionAttributes({ "userVO" }) 
@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
		
	@GetMapping("/login")
	public String loginForm() {
		return "login/login";
	}

	@PostMapping("/login")
	public String login(MemberVO member, Model model, HttpSession session) {
		MemberVO userVO = service.login(member);
		String msg = "";
		String view = "";
		if (userVO == null) {
			msg = "아이디 또는 패스워드가 잘못되었습니다.";
			view = "login/login";
			model.addAttribute("msg", msg);
		} else {
			
			model.addAttribute("userVO", userVO);
			msg = "환영합니다. " + userVO.getName() + "님";
			session.setAttribute("msg", msg);
			// 이제 로그인 후에 그냥 가면 안되고 직전 페이지로 가게함.
			String dest = (String) session.getAttribute("dest");
			if (dest != null) {
				session.removeAttribute("dest");
				view = "redirect:" + dest;
			} else {
				view = "redirect:/";
			}
		}
		return view;
	}
}
