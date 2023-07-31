package com.gdj51.test.web.test2.controller;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.net.HttpURLConnection;
import java.io.IOException;
import org.json.simple.parser.JSONParser;//중요
import org.json.simple.parser.ParseException;
import org.json.simple.JSONArray;//중요
import org.json.simple.JSONObject;//중요
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class APIRESTUARANT {

   @RequestMapping(value="getAPI")
   public ModelAndView getAPI(ModelAndView mav) {
      mav.setViewName("api/apiTest");
      return mav;
   }


   @RequestMapping(value="getAPIRequest", produces = "text/json;charset=UTF-8")
   @ResponseBody
   public String getRes(ModelAndView mav) throws IOException, ParseException {
      //String key = "75554e67576b6f303133366941626663";

      //String url = "http://openapi.seoul.go.kr:8088/+"+ key+"/json/LOCALDATA_072404/1/5/";
      StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088");
      /*URL*/
      urlBuilder.append("/" + URLEncoder.encode("75554e67576b6f303133366941626663","UTF-8") ); /*인증키
            (sample사용시에는 호출시 제한됩니다.)*/
      urlBuilder.append("/" + URLEncoder.encode("json","UTF-8") ); /*요청파일타입
            (xml,xmlf,xls,json) */
      urlBuilder.append("/" + URLEncoder.encode("LOCALDATA_072404","UTF-8"));
      /*서비스명 (대소문자 구분 필수입니다.)*/
      urlBuilder.append("/" + URLEncoder.encode("1","UTF-8")); /*요청시작위치
            (sample인증키 사용시 5이내 숫자)*/
      urlBuilder.append("/" + URLEncoder.encode("2","UTF-8"));//982
      /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
      // 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.
      // 서비스별 추가 요청 인자이며 자세한 내용은 각 서비스별 '요청인자'부분에자세히 나와 있습니다.

      //urlBuilder.append("/" + URLEncoder.encode("20220301","UTF-8")); /* 서비스별추가 요청인자들*/

      URL url = new URL(urlBuilder.toString());


      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("GET");
      conn.setRequestProperty("Content-type", "application/json");
      //System.out.println("Response code: " + conn.getResponseCode()); 
      /* 연결
            자체에 대한 확인이 필요하므로 추가합니다.*/
      BufferedReader rd;
      // 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
      if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
         rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
      } else {
         rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
      }
      StringBuilder sb = new StringBuilder();
      String line;
      while ((line = rd.readLine()) != null) {
         sb.append(line);
      }
      rd.close();
      conn.disconnect();

      //String형태에 json을 json으로 바꿔주는 작업 아래.
      //sb는 JSON형태의 문자열이다. 그래서 ATController처럼 ObjectMapper mapper = new ObjectMapper();을 선언한 필요가 없다.(atcontroller ATListAjax메소드가서 주석 살펴보삼)
      //1. JSONParser 형변환
      //2. JSONObject 객체추출
      //3. JSONArray(선택사항) 배열추출
      //4. 배열안에 객체 추출
      
      JSONParser parser = new JSONParser();
      String s = sb.toString();
      Object obj = parser.parse(s);
            
      JSONObject jsonObject = (JSONObject)obj;
      System.out.println("jsonObject====>"+jsonObject);
      
      
      JSONObject LOCALDATA_072404 = (JSONObject)jsonObject.get("LOCALDATA_072404");//객체에 접근
      
      JSONArray jsonArr2 = (JSONArray)LOCALDATA_072404.get("row");//배열에 접근
      System.out.println("=====>" + jsonArr2);
      
      JSONObject jsonObject2 = new JSONObject();
      System.out.println("size====>" + jsonArr2.size());
      for(int i=0; i<jsonArr2.size(); i++) {
    	  jsonObject2 =(JSONObject) jsonArr2.get(i);//배열안에 객체 접근하려고
    	  String ss = (String) jsonObject2.get("UPTAENM");
    	  System.out.println(ss);//키값 내려고
      }
      
      
      //Object
      //get해야지 해당 key 값을 가져온다.
      
      
      //map으로 변환
      //Map<String, Object> model = new HashMap <String,Object>();
      //model = jsonToMap(jsonObject);
      
      //List<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
      //for (String key : model.keySet()) {
      //    System.out.println("key:" + key + ", value:" + model.get(key));
      //}
      
      /*
             OBJECT : {"LOCALDATA_072404":{
                         "list_total_count":480117,
                         "row":[{"SITEWHLADDR":"서울특별시 종로구 평창동 110-1번지 ",
                            "ISREAM":"","JTUPSOMAINEDF":"","HOFFEPCNT":"",
                            "UPDATEGBN":"I","FCTYOWKEPCNT":"",
                            "MANEIPCNT":"0",
                            "RDNWHLADDR":"서울특별시 종로구 평창길 352 (평창동)",
                            "LVSENM":"기타","ROPNYMD":"",
                            "FACILTOTSCP":"725.98",
                            "JTUPSOASGNNO":"",
                            "UPTAENM":"뷔페식",
                            "LASTMODTS":"20080709135030",
                            "MULTUSNUPSOYN":"N",
                            "RDNPOSTNO":"03004",
                            "X":"197993.205677416    ",
                            "Y":"456584.627065144    ",
                            "HOMEPAGE":"",
                            "WMEIPCNT":"0",
                            "FCTYSILJOBEPCNT":"",
                            "APVPERMYMD":"19951111",
                            "DTLSTATEGBN":"01",
                            "UPDATEDT":"2018-08-31 23:59:59.0",
                            "SITETEL":"02 3960044",
                            "MGTNO":"3000000-101-1995-05829",
                            "BDNGOWNSENM":"",
                            "TRDSTATENM":"영업/정상",
                            "CLGENDDT":"",
                            "CLGSTDT":"",
                            "BPLCNM":"북악파크부페",
                            "WTRSPLYFACILSENM":"상수도전용",
                            "SITEPOSTNO":"110846",
                            "APVCANCELYMD":"",
                            "FCTYPDTJOBEPCNT":"",
                            "DTLSTATENM":"영업",
                            "DCBYMD":"",
                            "OPNSFTEAMCODE":"3000000",
                            "TOTEPNUM":"",
                            "TRDPJUBNSENM":"기타",
                            "MONAM":"",
                            "SNTUPTAENM":"뷔페식",
                            "TRDSTATEGBN":"01",
                            "SITEAREA":""
                      }],

                         "RESULT":
                               {
                                  "MESSAGE":"정상 처리되었습니다","CODE":"INFO-000"
                               }
                      }
                   } 
       */

      return sb.toString();//json형태의 문자열
   }
/*
   public static Map<String, Object> jsonToMap(JSONObject json) throws JSONException {
      Map<String, Object> retMap = new HashMap<String, Object>();

      if(json != JSONObject.NULL) {
            retMap = toMap(json);
      }
      return retMap;
   }

   public static Map<String, Object> toMap(JSONObject object) throws JSONException {
      Map<String, Object> map = new HashMap<String, Object>();
      Iterator<String> keysItr = object.keys();
      while(keysItr.hasNext()) {
         String key = keysItr.next();
         Object value = object.get(key);
         if(value instanceof JSONArray) {
            value = toList((JSONArray) value);
         }

         else if(value instanceof JSONObject) {
            value = toMap((JSONObject) value);
         }
            map.put(key, value);
      }
      return map;
   }
   
   public static List<Object> toList(JSONArray array) throws JSONException {

        List<Object> list = new ArrayList<Object>();
        for(int i = 0; i < array.length(); i++) {
           Object value = array.get(i);
           if(value instanceof JSONArray) {
              value = toList((JSONArray) value);
           }
           else if(value instanceof JSONObject) {
              value = toMap((JSONObject) value);
           }
           list.add(value);
        }
           return list;
       } 
    */
}