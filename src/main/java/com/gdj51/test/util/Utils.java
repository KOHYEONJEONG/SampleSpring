package com.gdj51.test.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.lang.RandomStringUtils;

import com.gdj51.test.common.CommonProperties;

public class Utils {
	/**
	 * Primary Key 생성 : 고유값
	 * 
	 * @return String
	 */
	public static String getPrimaryKey() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");//년월일분초
		return formatter.format(new java.util.Date()) + RandomStringUtils.randomNumeric(6);
		//RandomStringUtils : 아파치 톰캣 common.lang에서 제공하는 건데, 랜덤으로 값을 만들 수 있다.
		//왜?? 같은 날 같은 파일이 올라올 수 있겠지??
		//꼭 년월일분초를 넣을 필요는 없지만, 년월일분초와 랜덤 숫자까지 넣어주면 더 좋겠지?
		
	}
	
	/**
	 * 문자열을 key를 통해 암호화 하고 base64 로 인코딩
	 * 
	 * @return String
	 * @throws Throwable
	 */
	public static String encryptAES128(String value) throws Throwable {
		SecretKeySpec keySpec 
				= new SecretKeySpec(CommonProperties.SECURE_KEY.getBytes("UTF-8"), "AES");

		Cipher cipher = Cipher.getInstance("AES");
		cipher.init(Cipher.ENCRYPT_MODE, keySpec);
		byte[] encrypted = cipher.doFinal(value.getBytes()); // 암호화
		
		Encoder encoder = Base64.getEncoder();
		
		String encodeString = encoder.encodeToString(encrypted); // 바이트 타입의 배열을 문자열로 변환

		return encodeString;
	}

	/**
	 * key 를 통해 문자열 base64 디코딩
	 * 
	 * @return String
	 * @throws Throwable
	 */
	public static String decryptAES128(String value) throws Throwable {
		SecretKeySpec keySpec = new SecretKeySpec(CommonProperties.SECURE_KEY.getBytes("UTF-8"), "AES");

		Cipher cipher = Cipher.getInstance("AES");
		cipher.init(Cipher.DECRYPT_MODE, keySpec);
		
		Decoder decoder = Base64.getDecoder();
		
		byte[] decodeBytes = decoder.decode(value); //문자열 형태의 파라메터를 배열에 바이트 변환 후 삽입

		byte[] decryptBytes = cipher.doFinal(decodeBytes); // 복호화

		return new String(decryptBytes);
	}
	
	/**
	 * MAP의 Key를 소문자로 변환
	 * 
	 * @return HashMap<String, String>
	 */
	public static HashMap<String, String> toLowerMapKey(HashMap<String, String> oldMap) throws Throwable {
		Set<String> keySet = oldMap.keySet();
		
		Iterator<String> keys = keySet.iterator();
		
		HashMap<String, String> newMap = new HashMap<String, String>();
		
		while(keys.hasNext()) {
			String key = keys.next();
			newMap.put(key.toLowerCase(), String.valueOf(oldMap.get(key)));
		}
		
		return newMap;
	}
	
	/**
	 * List의 MAP Key를 소문자로 변환
	 * 
	 * 
	 * @return HashMap<String, String>
	 */
	public static List<HashMap<String, String>> toLowerListMapKey(List<HashMap<String, String>> oldList) {
		List<HashMap<String, String>> newList = new ArrayList<HashMap<String, String>>();
		
		for(HashMap<String, String> oldMap : oldList) {
			Set<String> keySet = oldMap.keySet();
			
			Iterator<String> keys = keySet.iterator();
			
			HashMap<String, String> newMap = new HashMap<String, String>();
			
			while(keys.hasNext()) {
				String key = keys.next();
				newMap.put(key.toLowerCase(), String.valueOf(oldMap.get(key)));
			}
			
			newList.add(newMap);
		}
		
		return newList;
	}
	
	/**
	 * List의 MAP Key를 camel식으로 변환
	 * 
	 * @return HashMap<String, String>
	 */
	public static List<HashMap<String, String>> toCamelListMapKey(List<HashMap<String, String>> oldList) {
		List<HashMap<String, String>> newList = new ArrayList<HashMap<String, String>>();
		
		for(HashMap<String, String> oldMap : oldList) {
			Set<String> keySet = oldMap.keySet();
			
			Iterator<String> keys = keySet.iterator();
			
			HashMap<String, String> newMap = new HashMap<String, String>();
			
			while(keys.hasNext()) {
				String key = keys.next();
				
				String[] temp = key.split("_");
				
				String camelKey = "";
				
				for(int i = 0 ; i < temp.length ; i++) {
					if(i == 0) {
						camelKey += temp[0].toLowerCase();
					} else {
						camelKey += temp[i].substring(0, 1).toUpperCase() + temp[i].substring(1).toLowerCase();
					}
				}
				
				newMap.put(camelKey, String.valueOf(oldMap.get(key)));
			}
			
			newList.add(newMap);
		}
		
		return newList;
	}
}
