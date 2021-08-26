package gc.co.kr.ajax;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gc.co.kr.member.service.MemberService;
import gc.co.kr.member.vo.MemberVO;

@Controller
@RequestMapping("/ajax")
public class ResBodyMember {
	
	@Autowired
	private MemberService service;	
	
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
}
