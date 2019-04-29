package com.neusoft.modules.account.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neusoft.common.md5.MD5Utils;
import com.neusoft.common.page.Page;
import com.neusoft.modules.account.model.Account;
import com.neusoft.modules.account.service.AccountService;
import com.neusoft.modules.front.fightTicket.model.FightTicket;
import com.neusoft.modules.front.fightTicket.service.FightTicketService;
import com.neusoft.modules.integral.model.IntegralInfo;
import com.neusoft.modules.integral.service.IntegralInfoService;
import com.neusoft.modules.role.model.Role;

@Controller
@RequestMapping(value = "account")
public class AccountController {

	@Autowired
	private AccountService accountService;
	
	@Autowired
	private IntegralInfoService integralInfoService;
	
	@Autowired
	private FightTicketService fightTicketService;
	
	/*@Autowired 
	private RoleService roleService;*/
	
	/**
	 * 
	 * 部门：软件开发事业部
	 * 功能：查询所有的账号信息
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-2-15
	 */
	@RequestMapping(value = "/selAll")
	public String selAll(Model model){
		List<Account> accountList = accountService.selAll();
		model.addAttribute("accountList", accountList);
		return "accountList";
	}
	
	/**
	 * 
	 * 部门：软件开发事业部
	 * 功能：登陆后进行根据权限类别进行相应的跳转
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-2-15
	 */
	@RequestMapping(value = "/toJump")
	public String toJump(Account account,HttpSession session,HttpServletRequest request,HttpServletResponse response){
		String remember = request.getParameter("remember");
		Cookie nameCookie = new Cookie("name",account.getUserName());
		Cookie pwdCookie = new Cookie("pwd",account.getPwd());
		if(remember != null && remember.equals("on")){
			nameCookie.setMaxAge(7*24*60*60);//设置cookie的有效时长 单位是秒  
			pwdCookie.setMaxAge(7*24*60*60);//  
            nameCookie.setPath(request.getContextPath()+"/");//设置c有效范围cookie的，这里是整个上下文环境  
            pwdCookie.setPath(request.getContextPath()+"/");  
            response.addCookie(nameCookie);//写入cookie  
            response.addCookie(pwdCookie);  
		}else{
			nameCookie.setMaxAge(0);  
            /** 
             * 如果用户没有勾选记住密码的功能，那么在页面跳转的时候 
             * 执行改方法就会把cookie的有效时长清零。这样记住密码功能就不能使用了 
             */  
			pwdCookie.setMaxAge(0);  
			nameCookie.setPath(request.getContextPath()+"/");//设置c有效范围cookie的，这里是整个上下文环境  
            pwdCookie.setPath(request.getContextPath()+"/"); 
			response.addCookie(nameCookie);//写入cookie  
	        response.addCookie(pwdCookie);  
		}
		if(null != account){
			String userName = account.getUserName();
			Account acc = accountService.selAccoutByUserName(userName);
			String roleId = acc.getRole().getId();
			if(null != roleId && !"".equals(roleId)){
			
				Account a = (Account)session.getAttribute("user");
				if(a == null){
					//记录上次登录时间
					acc.setLastLogin(acc.getLoginDate());
					accountService.updLastLogin(acc.getLoginDate(), acc.getId());
					//记录本次登录时间
					accountService.updLoginDate(acc.getId());
				}
				
				session.setAttribute("user", acc);
				
				if(roleId.equals("1")){//用户
					return "/modules/front/film/homePage";
				}else if(roleId.equals("2")){//管理员
					return "/modules/admin/adminIndex";
				}else if(roleId.equals("3")){//超管
					return "/modules/admin/superAdmin";
				}
			}
		}
		return "/error/loginError";
	}
	
	/**
	 * 
	 * 部门：软件开发事业部
	 * 功能：跳转到注册页
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-2-15
	 */
	@RequestMapping(value = "/toRegister")
	public String toRegister(){
		return "/modules/front/register/register";
	}
	
	/**
	 * 
	 * 部门：软件开发事业部
	 * 功能：注册账号后跳转相应的页面
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-2-15
	 */
	@RequestMapping(value = "/register")
	public String register(Account account,HttpSession session){
		//要跳转的页面
		String toPage = "";
		if(null != account && null != account.getPwd()){
			
			account.setId(UUID.randomUUID().toString().replace("-", ""));
			account.setRemarks(account.getPwd());
			account.setPwd(MD5Utils.getMD5(account.getPwd()));
			//account.setRole(roleService.get("1"));
			//是否是会员  否
			account.setIsMember("1");
			account.setCreateBy(account.getUserName());
			account.setCreateDate(new Date());
			
			IntegralInfo integralInfo = new IntegralInfo();
			//添加积分记录信息  用户
			if("1".equals(account.getRole().getId())){
				integralInfo.setId(UUID.randomUUID().toString().replace("-", ""));
				integralInfo.setAccount(account);
				integralInfo.setIntegralSource("注册首送");
				integralInfo.setScore(2000);
				integralInfoService.insert(integralInfo);
				account.setIntegral(2000);
			}
			
			accountService.save(account);
			
			
		}
		
		Account a = (Account)session.getAttribute("user");
		if(a == null){
			accountService.updLoginDate(account.getId());
		}
		
		session.setAttribute("user", account);
		
		String userName = account.getUserName();
		Account acc = accountService.selAccoutByUserName(userName);
		String roleId = acc.getRole().getId();
		if(null != roleId && !"".equals(roleId)){
			if(roleId.equals("1")){//用户
				toPage = "modules/front/film/homePage";
			}else if(roleId.equals("2")){//管理员
				toPage = "modules/admin/commonAdmin";
			}else if(roleId.equals("3")){//超管
				toPage = "modules/admin/superAdmin";
			}
		}else{
			toPage = "error/loginError";
		}
		return toPage;
	}
	
	/**
	 * 部门：软件开发事业部
	 * 功能：跳转到登录页
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-2-27
	 */
	@RequestMapping(value = "/toLogin")
	public String toLogin(){
		return "/modules/front/login/login";
	}
	
	/**
	 * 
	 * 部门：软件开发事业部
	 * 功能：验证用户名是否存在
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-2-15
	 */
	@ResponseBody
	@RequestMapping(value = "validateUsername")
	public String validateUsername(HttpServletRequest request){
		String res = "0";
		String userName = request.getParameter("userName");
		if(null != userName && !("").equals(userName)){
			Account account = accountService.selAccoutByUserName(userName);
			if(null != account){
				res = "1";//账号已存在
			}else{
				res = "2";//账号可以通过
			}
		}
		return res;
	}
	
	/**
	 * 
	 * 部门：软件开发事业部
	 * 功能：点击登录按钮对登录的信息进行验证
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-2-15
	 */
	@ResponseBody
	@RequestMapping(value = "validate")
	public String validate(HttpServletRequest request){
		String flag = "0";
		String userName = request.getParameter("userName");
		String pwd = request.getParameter("pwd");
		if(null != userName && null != pwd){
			Account account = accountService.selAccoutByUserName(userName);
			if(null != account){
				if(account.getPwd().equals(MD5Utils.getMD5(pwd))){
					flag = "1";//验证通过
				}else{
					flag = "2";//验证失败
				}
			}else{
				flag = "3";//该用户不存在
			}
		}
		return flag;
	}
	
	/**
	 * 跳转到个人中心页
	 */
	@RequestMapping(value = "toPerson")
	public String toPerson(Model model,HttpSession session,FightTicket fightTicket){
		Account account = (Account)session.getAttribute("user");
		fightTicket.setFightPeople(account.getUserName());
		List<FightTicket> fightList = fightTicketService.selAllByPerson(fightTicket);	
		model.addAttribute("fightList",fightList);
		return "modules/front/person/person_pa";
	}
	
	/**
	 * 根据不同的用户权限跳转不同的页面
	 */
	@RequestMapping(value = "toJumpPage")
	public String toJumpPage(HttpSession session){
		String url = "";
		Account account = (Account)session.getAttribute("user");
		if(null != account && !"".equals(account.getUserName())){
			String role = account.getRole().getId();
			if(("1").equals(role)){
				//用户
				url = "modules/front/person/person_pa";
			}else{
				//管理员
				url = "modules/admin/adminIndex";
			}
		}else{
			url = "error/error";
		}
		return url;
	}
	
	/**
	 * 注销用户
	 */
	@RequestMapping(value = "logOff")
	public String logOff(HttpSession session){
		session.removeAttribute("user");
		return "modules/front/film/homePage";
	}
	
	/**
	 * 跳转到个人信息页
	 */
	@RequestMapping(value = "toPerfect")
	public String toPerfect(HttpSession session){
		Account account = (Account)session.getAttribute("user");
		account = accountService.get(account.getId());
		session.setAttribute("user", account);
		return "modules/front/person/per_perfect";
	}
	
	/**
	 * 完善个人信息
	 */
	@RequestMapping(value = "perfectPerson")
	public String perfectPerson(Account account,HttpSession session){
		account.setUpdateBy(account.getUserName());
		IntegralInfo integralInfo = new IntegralInfo();
		//添加积分记录信息  用户
		integralInfo.setId(UUID.randomUUID().toString().replace("-", ""));
		integralInfo.setAccount(account);
		integralInfo.setIntegralSource("完善个人资料赠送");
		integralInfo.setScore(5000);
		integralInfoService.insert(integralInfo);
		int score = account.getIntegral() + 5000;
		account.setIntegral(score);
		accountService.update(account);
		return "redirect:toPerfect";
	}
	
	/**
	 * 检查密码是否正确
	 */
	@ResponseBody
	@RequestMapping(value = "checkPwd")
	public String checkPwd(@RequestParam("userName")String userName,@RequestParam("pwd")String pwd){
		String flag = null;
		Account account = accountService.selAccoutByUserName(userName);
		String pwdMd5 = MD5Utils.getMD5(pwd);
		if(pwdMd5.equals(account.getPwd())){
			flag = "1";//密码一致
		}else{
			flag = "2";//密码不一致
		}
		return flag;
	}
	
	/**
	 * 修改密码
	 */
	@ResponseBody
	@RequestMapping(value = "updateUser")
	public String updateUser(@RequestParam("userName")String userName,@RequestParam("pwd")String pwd){
		String flag = "";
		String pwdMd5 = MD5Utils.getMD5(pwd);
		if(null != userName && null != pwd){
			accountService.updPwdByUserName(pwdMd5, userName);
			flag = "1";//修改成功
		}else{
			flag = "2";//修改失败
		}
		return flag;
	}
	
	/**
	 * 开通会员
	 */
	@ResponseBody
	@RequestMapping(value = "toMember")
	public String toMember(String id,HttpSession session){
		String flag = "";
		Account acc = accountService.get(id);
		
		if(null != id && !"".equals(id)){
			
			IntegralInfo integralInfo = new IntegralInfo();
			//添加积分记录信息  用户
			if("1".equals(acc.getRole().getId())){
				integralInfo.setId(UUID.randomUUID().toString().replace("-", ""));
				integralInfo.setAccount(acc);
				integralInfo.setIntegralSource("开通会员赠送");
				integralInfo.setScore(500);
				integralInfoService.insert(integralInfo);
				int score = acc.getIntegral() + 500;
				//开通会员
				accountService.updMember("0", id ,score);
				flag = "1";
			}else{
				flag = "3";
			}
		}else{
			flag = "2";
		}
		
		Account account = accountService.get(id);
		session.setAttribute("user", account);
		return flag;
	}
	
	/**
	 * 查询账号积分
	 */
	@ResponseBody
	@RequestMapping(value = "selScore")
	public int selScore(String id){
		int score = 0;
		if(null != id && !"".equals(id)){
			Account account = accountService.get(id);
			score = account.getIntegral();
		}
		return score;
	}
	
	/**
	 * 查询该账号是否存在密保
	 */
	@ResponseBody
	@RequestMapping(value = "checkQuestion")
	public int checkQuestion(HttpServletRequest request){
		int count = 0;
		String userName = request.getParameter("userName");
		Account account = accountService.selAccoutByUserName(userName);
		if(null != account){
			if(null != account.getSecurityQu()){
				count = 1;//有密保
			}else{
				count = 2;//无密保
			}
		}else{
			count = 3;//无此用户
		}
		return count;
	}
	
	/**
	 * 验证密保问题与答案
	 */
	@ResponseBody
	@RequestMapping(value = "selQueAndAnswer")
	public int selQueAndAnswer(HttpServletRequest request){
		int count = 0;
		String userName = request.getParameter("userName");
		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		Account account = accountService.selAccoutByUserName(userName);
		if(null != account){
			if(account.getSecurityQu().equals(question) && account.getSecurityAnswer().equals(answer)){
				count = 1;//密保问题与答案相同
			}else{
				count = 2;//密保问题与答案不符
			}
		}else{
			count = 3;//用户不存在
		}
		return count;
	}
	
	/**
	 * 管理员管理用户信息
	 */
	@RequestMapping(value = "selAccount")
	public String selAccount(Model model ,Account account ,@RequestParam("pageNo")Integer pageNo){
		Role role = new Role();
		role.setId("1");
		account.setRole(role);
		Page page = accountService.selAccountByTerm(account, pageNo);
		if(page.getData() == null){
			page.setData(new ArrayList<Account>());
		}
		model.addAttribute("page",page);
		model.addAttribute("account",account);
		return "modules/account/accountList";
	}
	
	/**
	 * 超级管理员管理用户信息
	 */
	@RequestMapping(value = "selAccountBySuper")
	public String selAccountBySuper(Model model,Account account ,@RequestParam("pageNo")Integer pageNo){
		Page page = accountService.selAccountByTermSuper(account, pageNo);
		if(page.getData() == null){
			page.setData(new ArrayList<Account>());
		}
		model.addAttribute("page",page);
		model.addAttribute("account",account);
		return "modules/account/accountList";
	}
	
	/**
	 * 添加管理员
	 */
	@RequestMapping(value = "addAdmin")
	public String addAdmin(Account account,HttpSession session){
		Account acc = (Account)session.getAttribute("user");
		if(acc != null){
			account.setId(UUID.randomUUID().toString().replace("-", ""));
			account.setAccount("admin");
			account.setRemarks(account.getPwd());
			account.setPwd(MD5Utils.getMD5(account.getPwd()));
			account.setCreateBy(acc.getUserName());
			accountService.insertAdmin(account);
		}
		return "redirect:selAccountBySuper?pageNo=1";
	}
	
	/**
	 * 删除用户
	 */
	@RequestMapping(value = "delAccount")
	public String delAccount(@RequestParam("id")String id,@RequestParam("pageNo")String pageNo,HttpSession session){
		Account acc = (Account)session.getAttribute("user");
		if(acc != null){
			accountService.updAccountDel(id, acc.getUserName());
		}
		return "redirect:selAccountBySuper?pageNo="+pageNo;
	}
	
	/**
	 * 获取用户详细信息
	 */
	@RequestMapping(value = "selAccountDetail")
	public String selAccountDetail(Model model,String id){
		Account acc = accountService.get(id);
		model.addAttribute("acc",acc);
		return "modules/account/accountDetail";
	}
	
	/**
	 * 修改用户信息
	 */
	@RequestMapping(value = "updateAccount")
	public String updateAccount(Account account,HttpSession session){
		Account acc = (Account)session.getAttribute("user");
		if(acc != null && account != null){
			accountService.updateBySuper(account);
			account.setRemarks(account.getPwd());
			account.setPwd(MD5Utils.getMD5(account.getPwd()));
			account.setUpdateBy(acc.getUserName());
		}
		String address = "";
		if(acc.getRole().getId().equals("2")){
			address = "redirect:selAccount?pageNo=1";
		}else if(acc.getRole().getId().equals("3")){
			address = "redirect:selAccountBySuper?pageNo=1";
		}
		return address;
		
	}
}
