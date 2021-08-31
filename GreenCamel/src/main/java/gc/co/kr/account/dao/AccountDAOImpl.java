package gc.co.kr.account.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import gc.co.kr.account.vo.AccountVO;

@Repository
public class AccountDAOImpl implements AccountDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSession session;

	@Override
	public int createAcc(AccountVO account) {
		System.out.println("creating output");
		int row = session.insert("account.AccountDAO.createAcc" , account);
		return row;
	}
	
	@Override
	public AccountVO selectByAccNum(String gcaNumber) {
		System.out.println("selectByAccNum");
		AccountVO member = sqlSessionTemplate.selectOne("account.AccountDAO.selectByAccNum" , gcaNumber);
		return member;		
	}

	@Override
	public List<AccountVO> selectAllAccounts(String userID) {
		// TODO Auto-generated method stub
		System.out.println("AccountDAO selectALlAccounts");
		List<AccountVO> list = sqlSessionTemplate.selectList("account.AccountDAO.selectAllAccounts" ,   userID);
		return list;
	}

	@Override
	public AccountVO signinAccount(AccountVO accountVO) {
		// TODO Auto-generated method stub
		AccountVO userAccountVO = sqlSessionTemplate.selectOne("account.AccountDAO.signinAccount" , accountVO);		
		return userAccountVO ;
	}
	
}
