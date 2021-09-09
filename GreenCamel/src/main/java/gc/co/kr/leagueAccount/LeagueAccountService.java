package gc.co.kr.leagueAccount;

import java.util.List;

public interface LeagueAccountService {
		
	LeagueAccountVO selectLeagueAcc(String userID);
	
	List<LeagueFollowVO> selectFollowers(String userID);
	
	int createLeagueAcc(LeagueAccountVO leagueAccountVO);
	
	
}
