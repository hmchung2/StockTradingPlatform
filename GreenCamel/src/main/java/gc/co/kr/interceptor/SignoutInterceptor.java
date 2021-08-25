package gc.co.kr.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import gc.co.kr.member.vo.MemberVO;

public class SignoutInterceptor extends HandlerInterceptorAdapter{
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		System.out.println("로그아웃 인터셉터 처리...");
		
		HttpSession session = request.getSession();
		MemberVO userVO = (MemberVO) session.getAttribute("userVO");
				
		if(userVO != null) {
			String origin = request.getHeader("Referer");
			System.out.println("origin : " +  origin);
			
			session.setAttribute("msg", "먼저 로그아웃을 해야 합니다.");
			if( origin != null && origin.startsWith("http")) {
				System.out.println("sending back to where it was");
				response.sendRedirect(origin);
			}else {
				System.out.println("unknown path : sending to home");
				response.sendRedirect(request.getContextPath());
			}			
			return false;
		}
		System.out.println("sending");
		return true;			
	}
}
