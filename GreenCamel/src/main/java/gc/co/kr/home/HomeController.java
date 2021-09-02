package gc.co.kr.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String home() {
		return "index";
	}
	
	@RequestMapping("/chatting")
	public String chatting() {
		return "chat/view_chat";
	}

	@RequestMapping("/home-template")
	public String homeTemplate() {
		return "home-template";
	}
	
	@RequestMapping("/dash-template")
	public String dashTemplate() {
		return "dash-template";
	}
	
}
