package com.neusoft.common.pattern;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PatternTool {

	public static boolean isContainChinese(String str){
		Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
		Matcher m = p.matcher(str);
		if(m.find()){
			return true;
		}else{
			return false;
		}
	}
	
}
