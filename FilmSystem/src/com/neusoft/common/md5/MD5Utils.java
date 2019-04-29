package com.neusoft.common.md5;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Utils {

	/**
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-2-27
	 */
	public static void main(String[] args) {
		String str = "nnxx";
		String str3 = "QQabcd123";
		System.out.println(getMD5(str));
		System.out.println(getMD5(str3));
	}

	public static String getMD5(String str){
		char hexDigits[] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
		
		try {
			byte[] btInput = str.getBytes();
			//获得MD5的摘要算法MessageDigest对象
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			//使用指定字节更新摘要对象
			mdInst.update(btInput);
			//获得密文
			byte[] md = mdInst.digest();
			//把密文转换成16进制的字符串形式
			int j = md.length;
			StringBuffer sb = new StringBuffer(j * 2);
			for(int i = 0; i < j; i++){
				byte byte0 = md[i];
				sb.append(hexDigits[(byte0 & 0xf0) >> 4]);
				sb.append(hexDigits[byte0 & 0xf]);
			}
			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
