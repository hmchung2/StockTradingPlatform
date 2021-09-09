package gc.co.kr.leagueAccount;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LeagueAccountDAOImpl implements LeagueAccountDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSession session;
	

	@Override
	public LeagueAccountVO selectLeagueAcc(String userID) {
		System.out.println("selecting League Acc");
		LeagueAccountVO leagueUserVO  = sqlSessionTemplate.selectOne("account.AccountDAO.selectLeagueAcc" , userID);
		return leagueUserVO;
	}

	@Override
	public List<LeagueFollowVO> selectFollowers(String userID) {
		System.out.println("selecting followers : " + userID);
		List<LeagueFollowVO>  leagueFollowUserVO =  sqlSessionTemplate.selectOne("account.AccountDAO.selectFollowers" , userID); 		
		return leagueFollowUserVO;
	}


	@Override
	public int createLeagueAcc(LeagueAccountVO leagueAccountVO) {
		System.out.println("creating league acc");
		int row = session.insert("account.AccountDAO.createLeagueAcc" , leagueAccountVO);		
		return row;
	}
}
