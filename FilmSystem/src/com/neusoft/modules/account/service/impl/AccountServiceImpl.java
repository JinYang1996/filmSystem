package com.neusoft.modules.account.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neusoft.common.page.Page;
import com.neusoft.modules.account.mapper.AccountMapper;
import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.account.service.AccountService;

@Service
public class AccountServiceImpl implements AccountService{

	@Autowired
	private AccountMapper accountMapper;
	
	@Override
	public List<Account> selAll() {
		return accountMapper.selAll();
	}
	
	@Override
	public void save(Account account) {
		Account acc = accountMapper.selAccoutByUserName(account.getUserName());
		if(null != acc){
			accountMapper.update(account);
		}else{
			accountMapper.insert(account);
		}
	}

	@Override
	public Account selAccoutByUserName(String userName) {
		return accountMapper.selAccoutByUserName(userName);
	}

	@Override
	public void updIntegral(int integral, String id) {
		accountMapper.updIntegral(integral, id);
	}

	@Override
	public Account get(String id) {
		return accountMapper.get(id);
	}

	@Override
	public void insert(Account t) {
		accountMapper.insert(t);
	}

	@Override
	public void update(Account t) {
		accountMapper.update(t);
	}

	@Override
	public void updPwdByUserName(String pwd, String userName) {
		accountMapper.updPwdByUserName(pwd, userName);
	}

	@Override
	public void updMember(String isMember, String id,int integral) {
		accountMapper.updMember(isMember, id,integral);
	}

	@Override
	public void updLoginDate(String id) {
		accountMapper.updLoginDate(id);
	}

	@Override
	public void updLastLogin(Date lastLogin, String id) {
		accountMapper.updLastLogin(lastLogin, id);
	}

	@Override
	public Page selAccountByTerm(Account account,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(8);
		int startRow = page.getStartRow();
		account.setStartRow(startRow);
		account.setPageSize(8);
		List<Account> accountList = accountMapper.selAccountByTerm(account);
		page.setData(accountList);
		
		int count = accountMapper.selCountByTerm(account);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selCountByTerm(Account account) {
		return accountMapper.selCountByTerm(account);
	}

	@Override
	public Page selAccountByTermSuper(Account account,int pageNo) {
		if(pageNo < 1) pageNo = 1;
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(8);
		int startRow = page.getStartRow();
		account.setStartRow(startRow);
		account.setPageSize(8);
		List<Account> accountList = accountMapper.selAccountByTermSuper(account);
		page.setData(accountList);
		
		int count = accountMapper.selCountByTermSuper(account);
		page.setSumCount(count);
		page.setSumPage(page.getPage());
		return page;
	}

	@Override
	public int selCountByTermSuper(Account account) {
		return accountMapper.selCountByTermSuper(account);
	}

	@Override
	public void insertAdmin(Account account) {
		accountMapper.insertAdmin(account);
	}

	@Override
	public void updAccountDel(String id, String updateBy) {
		accountMapper.updAccountDel(id, updateBy);
	}

	@Override
	public void updateBySuper(Account account) {
		accountMapper.updateBySuper(account);
	}

	@Override
	public List<Account> selAdmin() {
		return accountMapper.selAdmin();
	}
}
