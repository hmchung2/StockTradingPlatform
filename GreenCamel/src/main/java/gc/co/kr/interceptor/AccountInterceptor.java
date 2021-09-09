package gc.co.kr.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import gc.co.kr.account.vo.AccountVO;
import gc.co.kr.leagueAccount.LeagueAccountVO;

public class AccountInterceptor extends HandlerInterceptorAdapter{
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		System.out.println("계좌 인터셉터 처리...");
		// 로그인여부 판단.
		HttpSession session = request.getSession();
		AccountVO accountVO = (AccountVO)session.getAttribute("accountVO");
		
		if(accountVO == null) {
			System.out.println("일반 계좌 확인 안됨");
			LeagueAccountVO  leagueAccountVO = (LeagueAccountVO)session.getAttribute("leagueAccountVO");
			if(leagueAccountVO == null) {
				System.out.println("리그 계좌 확인 안됨");
				String uri = request.getRequestURI();
				uri = uri.substring(request.getContextPath().length());
				System.out.println(uri);
				session.setAttribute("dest2", uri);
				response.sendRedirect(request.getContextPath() +  "/account/signin");
				return false;
			}
		}				
		System.out.println("계좌 확인 됨");
		return true;
	}
}
