package com.neusoft.modules.account.model;

import java.util.Date;

import com.neusoft.common.model.CommonModel;
import com.neusoft.modules.role.model.Role;

public class Account extends CommonModel{
	
	private String id;//id
	
	private String account;//昵称
	
	private String userName;//登录名
	
	private String pwd;//密码
	
	private String trueName;//姓名
	
	private String email;//email
	
	private String phone;//电话
	
	private String photo;//头像
	
	private String sex;//性别
	
	private String birthday;//生日
	
	private String securityQu;//密保问题
	
	private String securityAnswer;//密保答案
	
	private Role role;//权限
	
	private String isMember;//是否是会员
	
	private int integral;//积分
	
	private Date lastLogin;//上次登录时间
	
	private Date loginDate;//本次登录时间

	public Account() {
		super();
	}

	public Account(String id, String account, String userName, String pwd,
			String trueName, String email, String phone, String photo,
			String sex, String birthday, String securityQu,
			String securityAnswer, Role role, String isMember, int integral,
			Date lastLogin, Date loginDate) {
		super();
		this.id = id;
		this.account = account;
		this.userName = userName;
		this.pwd = pwd;
		this.trueName = trueName;
		this.email = email;
		this.phone = phone;
		this.photo = photo;
		this.sex = sex;
		this.birthday = birthday;
		this.securityQu = securityQu;
		this.securityAnswer = securityAnswer;
		this.role = role;
		this.isMember = isMember;
		this.integral = integral;
		this.lastLogin = lastLogin;
		this.loginDate = loginDate;
	}

	public Date getLoginDate() {
		return loginDate;
	}


	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getTrueName() {
		return trueName;
	}

	public void setTrueName(String trueName) {
		this.trueName = trueName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getSecurityQu() {
		return securityQu;
	}

	public void setSecurityQu(String securityQu) {
		this.securityQu = securityQu;
	}

	public String getSecurityAnswer() {
		return securityAnswer;
	}

	public void setSecurityAnswer(String securityAnswer) {
		this.securityAnswer = securityAnswer;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getIsMember() {
		return isMember;
	}

	public void setIsMember(String isMember) {
		this.isMember = isMember;
	}

	public int getIntegral() {
		return integral;
	}

	public void setIntegral(int integral) {
		this.integral = integral;
	}

	public Date getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Date lastLogin) {
		this.lastLogin = lastLogin;
	}
	
}
