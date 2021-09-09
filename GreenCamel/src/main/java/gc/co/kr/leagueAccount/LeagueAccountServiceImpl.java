package gc.co.kr.leagueAccount;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LeagueAccountServiceImpl implements LeagueAccountService{

	@Autowired
	private LeagueAccountDAO leagueAccountDAO;
	
	@Override
	public LeagueAccountVO selectLeagueAcc(String userID) {
		LeagueAccountVO leagueAccountVO  = leagueAccountDAO.selectLeagueAcc(userID);		
		return leagueAccountVO;
	}

	@Override
	public List<LeagueFollowVO> selectFollowers(String userID) {
		List<LeagueFollowVO> leagueFollowVO = leagueAccountDAO.selectFollowers(userID) ;
		return leagueFollowVO;
	}

	@Override
	public int createLeagueAcc(LeagueAccountVO leagueAccountVO) {
		System.out.println("inserting  leagueAccountVO : " + leagueAccountVO);
		int row = leagueAccountDAO.createLeagueAcc(leagueAccountVO);
		return row;
	}


}
