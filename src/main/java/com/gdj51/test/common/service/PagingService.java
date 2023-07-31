package com.gdj51.test.common.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.gdj51.test.common.CommonProperties;

@Service
public class PagingService implements IPagingService{
	/*
	 * Paging
	 * (핵심)
	 * 1.한번에 몇 건의 데이터를 가지고 올 것인가.
	 * 2.보여질 페이지는 몇개 가져올지
	 */
	//테이블 시작row
	@Override
	public int getStartCount(int page) {
		int startCount = 0;
		int viewCount = CommonProperties.VIEWCOUNT;
		startCount = (page - 1) * viewCount + 1; //(현재 페이지-1) * 10 +1 
		return startCount;
	}
	
	//테이블 종료row
	@Override
	public int getEndCount(int page) {
		int endCount = 0;
		endCount = page * CommonProperties.VIEWCOUNT;//현재위치에 페이지에서 보여질 데이터 마지막 번호
		return endCount;
	}
	
	//페이징 최대 크기
	@Override
	public int getMaxPcount(int maxCount) {
		int maxPcount = 0;
		
		if(maxCount % CommonProperties.VIEWCOUNT > 0){
			maxPcount = (maxCount / CommonProperties.VIEWCOUNT) + 1;
		} else {
			maxPcount = (maxCount / CommonProperties.VIEWCOUNT);
		}
		
		if(maxCount == 0) {
			maxPcount = 1; //아무것도 없어도 1페이지라고 떠야하기 때문에.
		}
		
		return maxPcount;
	}
	
	//현재페이지 기준 시작페이지
	@Override
	public int getStartPcount(int page) {
		int startPcount = 0;
		
		if(page % CommonProperties.PAGECOUNT == 0 ) {
			startPcount = page - CommonProperties.PAGECOUNT + 1;
		} else {
			startPcount = ((page / CommonProperties.PAGECOUNT) * CommonProperties.PAGECOUNT) + 1;
		}
		
		return startPcount;
	}
	
	//현재페이지 기준 종료페이지
	@Override
	public int getEndPcount(int page, int maxCount) {
		int endPcount = 0;
		int maxPcount = getMaxPcount(maxCount);
		
		endPcount = getStartPcount(page) + CommonProperties.PAGECOUNT - 1;
		
		if(endPcount >= maxPcount){
			endPcount = maxPcount;
		}
		
		return endPcount;
	}
	
	//map 형식으로 취득
	@Override
	public HashMap<String, Integer> getPagingData(int page, int maxCount) { //페이징 데이터가 알아서 넘어온다.
		HashMap<String, Integer> pd = new HashMap<String, Integer>();
		
		pd.put("start", getStartCount(page));
		pd.put("end", getEndCount(page));
		pd.put("maxP", getMaxPcount(maxCount));
		pd.put("startP", getStartPcount(page));
		pd.put("endP", getEndPcount(page, maxCount));
		
		return pd;
	}
	
	
	/*****************
	 * Custom Paging *
	 *****************/
	//테이블 시작row
	@Override
	public int getStartCount(int page, int viewCnt) {
		
		int startCount = 0;
		
		//데이터 취득 시작번호 : (현재페이지 -1 ) * 보여질 개수 + 1
		/*
		  01 -1 = 00 => 1 => 
		  				계산:	(1 page - 1) = 0
		  									= 0 * 10 => 0 

		  11 - 1 = 10 => 2 => 
		  				계산:	(2 page - 1) => 1 
		  									= 1 * 10 => 10
		
		  21 -1 = 20 => 3 => 
		  				계산:	(3 page - 1) => 2
		  						        	= 2 * 10 => 20
		  		*자릿수를 맞추려고 01, 11, 21				        	
		 */
		startCount = (page - 1) * viewCnt + 1;
		// 1페이지인 경우 : 1~10번 데이터
		// 2페이지인 경우 : 11~20번 데이터
		// 3페이지인 경우 : 21~30번 데이터
		return startCount;
	}
	
	//테이블 종료row
	@Override
	public int getEndCount(int page, int viewCnt) {
		int endCount = 0;
		endCount = page * viewCnt;
		return endCount;
	}
	
	//페이징 최대 크기
	@Override
	public int getMaxPcount(int maxCount, int viewCnt) {
		int maxPcount = 0;
		
		if(maxCount % viewCnt > 0){
			maxPcount = (maxCount / viewCnt) + 1;
		} else {
			maxPcount = (maxCount / viewCnt);
		}
		
		if(maxCount == 0) {
			maxPcount = 1;
		}
		
		return maxPcount;
	}
	
	//현재페이지 기준 시작페이지
	@Override
	public int getStartPcount(int page, int pageCnt) {
		int startPcount = 0;
		
		if(page % pageCnt == 0 ) {
			startPcount = page - pageCnt + 1;
		} else {
			startPcount = ((page / pageCnt) * pageCnt) + 1;
		}
		
		return startPcount;
	}
	
	//현재페이지 기준 종료페이지
	@Override
	public int getEndPcount(int page, int maxCount, int viewCnt, int pageCnt) {
		int endPcount = 0;
		int maxPcount = getMaxPcount(maxCount, viewCnt);
		
		endPcount = getStartPcount(page, pageCnt) + pageCnt - 1;
		
		if(endPcount >= maxPcount){
			endPcount = maxPcount;
		}
		
		return endPcount;
	}
	
	//map 형식으로 취득
	// 이 메소드만 컨트롤러에서 호출하여 메소드안에서 알맞게 값을 바꿔서 return 해줌.
	@Override
	public HashMap<String, Integer> getPagingData(int page, int maxCount, int viewCnt, int pageCnt) {
		// 현재 page, 데이터 총 갯수, 보여질 데이터 개수, 페이징 개수(UI)
		HashMap<String, Integer> pd = new HashMap<String, Integer>();
		
		pd.put("start", getStartCount(page, viewCnt));
		pd.put("end", getEndCount(page, viewCnt));
		pd.put("maxP", getMaxPcount(maxCount, viewCnt));
		pd.put("startP", getStartPcount(page, pageCnt));
		pd.put("endP", getEndPcount(page, maxCount, viewCnt, pageCnt));
		
		return pd;
	}
}
