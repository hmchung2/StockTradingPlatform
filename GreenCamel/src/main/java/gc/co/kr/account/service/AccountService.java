package gc.co.kr.account.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import gc.co.kr.account.vo.AccountVO;

@Transactional
public interface AccountService {
	
	@Transactional
	int createAcc(AccountVO account);

	List<AccountVO> selectAllAccounts(String userID);
	
	
}
