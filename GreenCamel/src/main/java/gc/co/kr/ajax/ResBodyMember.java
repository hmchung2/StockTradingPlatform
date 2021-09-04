package gc.co.kr.ajax;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gc.co.kr.member.service.MemberService;
import gc.co.kr.member.vo.MemberVO;
import gc.co.kr.model.email.EmailDTO;
import gc.co.kr.model.email.EmailService;

@Controller
@RequestMapping("/ajax")
public class ResBodyMember {
	
	@Autowired
	private MemberService service;	
	
	@Autowired
	EmailService emailService;
	
	@RequestMapping("/restBody.json")
	@ResponseBody
	public Map<String, String> getIdCheck(@RequestParam("id") String id){
		System.out.println("ajax : -->  id checking :" + id);
		Map<String, String> result = new HashMap<String, String>();
		result.put("result", "false");
		MemberVO existingUser = service.selectByID(id);
		System.out.println("existingUser : " + existingUser );
		if(existingUser  == null) {
			result.put("result","true");
		}		
		return result;		
	}
	
	@RequestMapping("/sendMail.json")
	@ResponseBody
	public Map<String, String> sendEmail(@RequestParam("emailAddr") String emailAddr,@RequestParam("digits") String digits){
		System.out.println("ajax -> email sending ");
		Map<String, String> result = new HashMap<String, String>();
		try {
			EmailDTO emailDTO = new EmailDTO();
			emailDTO.setSenderMail("hmchung2@gmail.com");
			emailDTO.setSenderName("green camel");
			emailDTO.setReceiveMail(emailAddr);
			emailDTO.setMessage("인증번호  : " + digits);
			emailService.sendMail(emailAddr ,"GC 플랫폼 인증번호 발급" , digits  );
			result.put("result" , "success");
		}catch (Exception e) {
			// TODO: handle exception
			result.put("result", "fail");
			System.out.println("이메일 실패 : " +  e);
		}
		
		

		return result;
	}
	
	
}
