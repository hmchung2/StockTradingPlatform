package gc.co.kr.leagueAccount;

import java.util.List;

public interface LeagueAccountDAO {
	
	LeagueAccountVO selectLeagueAcc(String userID);
	
	List<LeagueFollowVO> selectFollowers(String userID);
	
	int createLeagueAcc(LeagueAccountVO leagueAccountVO);
	
}
