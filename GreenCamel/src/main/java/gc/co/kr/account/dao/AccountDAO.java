package gc.co.kr.account.dao;

import java.util.List;

import gc.co.kr.account.vo.AccountVO;

public interface AccountDAO {

	int createAcc(AccountVO account);
	
	AccountVO selectByAccNum(String gcaNumber);

	List<AccountVO> selectAllAccounts(String userID);
	
}
