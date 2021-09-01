package gc.co.kr.practice.handler;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import gc.co.kr.member.vo.MemberVO;

@SessionAttributes({ "userVO" }) 
@Controller
public class ChatController {
	
	@GetMapping("/chat")
	public void chat(Model model) {
		MemberVO userVO = (MemberVO) model.getAttribute("userVO");
		model.addAttribute("userid", userVO.getName());
	}
}
