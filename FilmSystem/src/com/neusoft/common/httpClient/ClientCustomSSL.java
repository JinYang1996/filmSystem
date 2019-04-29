package com.neusoft.common.httpClient;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpEntity;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ArrayNode;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.neusoft.modules.front.filmDetail.model.FilmDetail;

public class ClientCustomSSL {
	public static CloseableHttpClient createSSLClientDefault(){
		try {
			//忽略掉对服务器端证书的校验
			SSLContext sslContext = new SSLContextBuilder().loadTrustMaterial(null, new TrustStrategy() {
                 //信任所有
                 public boolean isTrusted(X509Certificate[] chain,
                                 String authType) throws CertificateException {
                     return true;
                 }
             }).build();
             SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext);
             return HttpClients.custom().setSSLSocketFactory(sslsf).build();
         } catch (KeyManagementException e) {
             e.printStackTrace();
         } catch (NoSuchAlgorithmException e) {
             e.printStackTrace();
         } catch (KeyStoreException e) {
             e.printStackTrace();
         }
	     return  HttpClients.createDefault();
	}
	
	//使用jackson进行解析
	private static final ObjectMapper objectMapper = new ObjectMapper();
	
	private static final String URL_START = "https://movie.douban.com/j/search_subjects";
	
	private static final String URL_SEARCH = "?type=movie&tag=%E7%83%AD%E9%97%A8&sort=recommend&page_limit=20";
	
	private static final String URL_PAGE = "&page_start=";
	
	//爬取豆瓣中电影的数量  size*20
	private static final int size = 5;
	
	/**
	 * 根据豆瓣网址返回数据
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-3-6
	 */
	public static String getEntity(String url){
		String content = "";
		try {
			CloseableHttpClient httpClient = createSSLClientDefault();
			HttpGet httpGet = new HttpGet(url);
			CloseableHttpResponse response = httpClient.execute(httpGet);
			
			HttpEntity entity = response.getEntity();
			content = EntityUtils.toString(entity,"utf-8");
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return content;
	}
	
	/**
	 * 获取豆瓣电影中的电影信息
	 * 部门：软件开发事业部
	 * 功能：
	 * 描述：
	 * 作成者：jinyang
	 * 作成时间：2018-3-5
	 */
	public static List<FilmDetail> achieveFilms() throws JsonProcessingException, IOException{
		List<FilmDetail> filmList = new ArrayList<FilmDetail>();
		for(int i=0;i<size;i++){
			String url = URL_START+URL_SEARCH+URL_PAGE+i*20;
			System.out.println(url);
			String content = getEntity(url);
			JsonNode jsonNode = objectMapper.readTree(content);
			ArrayNode subjects = (ArrayNode)jsonNode.get("subjects");
			/*List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();*/
			for(JsonNode subject : subjects){
				/*Map<String,Object> map = new LinkedHashMap<String,Object>();
				map.put("title", subject.get("title"));
				map.put("rate", subject.get("rate"));
				map.put("url", subject.get("url"));
				map.put("cover", subject.get("cover"));
				map.put("is_new", subject.get("is_new"));*/
				if(null != subject.get("url") && !("").equals(subject.get("url"))){
					System.out.println(subject.get("url").getValueAsText());
					String filmContent = getEntity(subject.get("url").getValueAsText());
					Document doc = Jsoup.parse(filmContent);
					Element element = doc.getElementById("info");
					String el = element.text().replace(" ", "");
					int direct = el.indexOf("导演");
					int screenWriter = el.indexOf("编剧");
					String direct1 = "";
					int staring = el.indexOf("主演");
					if(screenWriter < 0 && staring >=0){
						direct1 = el.substring(direct+3 ,staring);//导演
					}else if(direct >=0 && screenWriter>=0){
						direct1 = el.substring(direct+3 ,screenWriter);//导演
					}
					
					
					String screenWriter1 = "";
					if(screenWriter >= 0 && staring >= 0){
						screenWriter1 = el.substring(screenWriter+3 ,staring);//编剧
					}
					
					int type = el.indexOf("类型");
					String staring1 = "";
					if(staring >= 0 && type >= 0){
						staring1 = el.substring(staring+3 ,type);//主演
					}
					
					int address = el.indexOf("官方网站");
					String address1 = "";
					
					int area = el.indexOf("制片国家/地区");
					String type1 = "";
					if(address >= 0){
						type1 = el.substring(type+3 ,address);//类型
						address1 = el.substring(address+5, area);//官方地址
					}else{
						if(type >= 0 && area >= 0){
							type1 = el.substring(type+3 ,area);//类型
						}
					}
					System.out.println(address);
					System.out.println(el);
					System.out.println(subject.get("title").getTextValue());
					System.out.println(type1);
					System.out.println(address1);
					
					int language = el.indexOf("语言");
					String area1 = "";
					if(area >= 0 && language >= 0){
						area1 = el.substring(area+8 ,language);//制片国家/地区
					}
					
					int showTime = el.indexOf("上映日期");
					if(showTime < 0){
						continue;
					}
					String language1 = "";
					if(language >= 0 && showTime >= 0){
						language1 = el.substring(language+3 ,showTime);//语言
					}
					
					int filmLength = el.indexOf("片长");
					String showTime1 = "";
					if(showTime >= 0 && filmLength >= 0){
						String showTime2 = el.substring(showTime+5 ,filmLength);//上映日期
						showTime1 = showTime2.substring(0,10);//上映日期
					}
					System.out.println(showTime1);
					
					int alternate = el.indexOf("又名");
					String filmLength1 = "";
					if(filmLength >= 0 && alternate >= 0){
						filmLength1 = el.substring(filmLength+3 ,alternate);//片长
					}
					
					int IMDb = el.indexOf("IMDb链接");
					String alternate1 = "";
					if(alternate >= 0 && IMDb >=0){
						alternate1 = el.substring(alternate+3,IMDb);//又名
					}else{
						continue;
					}
					
					/*int IMDb = el.indexOf("IMDb链接");
					String alternate1 = "";
					String IMDb1 = "";
					if(IMDb >= 0 && alternate >=0){
						alternate1 = el.substring(alternate+3,IMDb);//又名
						IMDb1 = el.substring(IMDb+7);//IMDB
					}*/
					
					/*
					System.out.println(direct1);
					System.out.println(screenWriter1);
					System.out.println(staring1);
					System.out.println(type1);
					System.out.println(area1);
					System.out.println(language1);
					System.out.println(showTime1);
					System.out.println(filmLength1);
					System.out.println(alternate1);
					System.out.println(IMDb1);*/
					Elements ratingEle = doc.getElementsByClass("rating_people");
					String evaluationNum = "";
					for(Element e:ratingEle){
						if(e.children().size() == 1){
							evaluationNum = e.children().text();//评价人数
						}
						System.out.println(evaluationNum);
					}
					/*map.put("direct",direct1);
					map.put("screenWriter",screenWriter1);
					map.put("staring",staring1);
					map.put("type",type1);
					map.put("area",area1);
					map.put("language",language1);
					map.put("language",showTime1);
					map.put("filmLength",filmLength1);
					map.put("alternate",alternate1);
					map.put("IMDb",IMDb1);
					map.put("evaluationNum", evaluationNum);
					map.put("page_url", subject.get("url").getValueAsText());*/
					
					FilmDetail film = new FilmDetail();
					film.setReleaseYear(showTime1.substring(0,4));
					film.setPicture(subject.get("cover").getTextValue());//剧照
					film.setTitle(subject.get("title").getTextValue());//片名
					film.setDirect(direct1);//导演
					film.setScreenWriter(screenWriter1);//编剧
					film.setLeadingRole(staring1);//主演
					film.setType(type1);//类型
					film.setState(area1);//制片国家/地区
					film.setLanguage(language1);//语言
					film.setReleaseDate(showTime1);//上映日期
					film.setFilmLength(filmLength1);//时长
					film.setAlternateName(alternate1);//又名
					/*film.setIMDB(IMDb1);*///IMDB
					double score = Double.parseDouble(subject.get("rate").getTextValue());
					film.setScore(score);//评分
					film.setEvaluationNum(Integer.parseInt(evaluationNum));//评论人数
					
					Element elementBrief = doc.getElementById("link-report");//影片简介
					String contentBrief = elementBrief.text().toString();
					
					System.out.println(elementBrief.toString());
					film.setBrief(contentBrief);
					
					filmList.add(film);
					System.out.println(film.toString());
					
					
				}
				/*result.add(map);*/
				/*break;*/
			}
			/*System.out.println(result.size()+objectMapper.writeValueAsString(result));*/
		}
		return filmList;
	}
	
	public static void main(String[] args){
		try {
			List<FilmDetail> filmList = achieveFilms();
			System.out.println(filmList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
