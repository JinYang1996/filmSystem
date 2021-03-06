package com.neusoft.modules.account.mapper;

import java.util.Date;
import java.util.List;

import com.neusoft.common.cominterface.CommonInterface;
import com.neusoft.modules.account.model.Account;

public interface AccountMapper extends CommonInterface<Account>{

	
	/**
	 * 根据用户名查询账号信息
	 */
	public Account selAccoutByUserName(String userName);
	
	/**
	 * 更新账号积分
	 */
	public void updIntegral(int integral,String id);
	
	/**
	 * 根据用户名修改密码
	 */
	public void updPwdByUserName(String pwd,String userName);
	
	/**
	 * 修改会员状态
	 */
	public void updMember(String isMember, String id ,int integral);
	
	/**
	 * 记录登录状态
	 */
	public void updLoginDate(String id);
	
	/**
	 * 记录上次登录时间
	 */
	public void updLastLogin(Date lastLogin,String id);
	
	/**
	 * 根据条件查询所有用户信息
	 */
	public List<Account> selAccountByTerm(Account account);
	
	/**
	 * 根据条件查询出用户的数量
	 */
	public int selCountByTerm(Account account);
	
	/**
	 * 超级管理员根据条件查询所有用户信息
	 */
	public List<Account> selAccountByTermSuper(Account account);
	
	/**
	 * 超级管理员根据条件查询出用户的数量
	 */
	public int selCountByTermSuper(Account account);
	
	/**
	 * 添加管理员
	 */
	public void insertAdmin(Account account);
	
	/**
	 * 删除用户信息
	 */
	public void updAccountDel(String id,String updateBy);
	
	/**
	 * 超级管理员修改信息
	 */
	public void updateBySuper(Account account);
	
	/**
	 * 查询管理员用户
	 */
	public List<Account> selAdmin();
}

