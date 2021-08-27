package gc.co.kr.account.service;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gc.co.kr.account.dao.AccountDAO;
import gc.co.kr.account.vo.AccountVO;

@Service
@Transactional
public class AccountServiceImpl implements AccountService{

	@Autowired
	private AccountDAO accountDAO;
	
	
	@Transactional
	@Override
	public int createAcc(AccountVO account) {
		int cnt = 0;
		String gcaNumber;
		Boolean successGenerate = false;
		while(cnt < 50) {
			gcaNumber = generateDigits();
			System.out.println("generated Number : " + gcaNumber);
			AccountVO checkAccount =  accountDAO.selectByAccNum(gcaNumber);
			if(checkAccount == null ) {
				successGenerate = true;
				account.setGcaNumber(gcaNumber);
				break;
			}
			cnt++;
		}
		int row = 0;
		if(successGenerate ) {
			System.out.println(account);
			row= accountDAO.createAcc(account);		
		}
		return row;
	}
	
	public String generateDigits() { 
	    Random rnd = new Random();
	    char [] digits = new char[9];
	    digits[0] = (char) (rnd.nextInt(9) + '1');
	    for(int i=1; i<digits.length; i++) {
	        digits[i] = (char) (rnd.nextInt(10) + '0');
	    }
	    return  String.valueOf(Long.parseLong(new String(digits)) ) ;  
	}

	@Override
	public List<AccountVO> selectAllAccounts(String userID) {
		// TODO Auto-generated method stub
		List<AccountVO> list = accountDAO.selectAllAccounts(userID);
		return list;
	}


}
