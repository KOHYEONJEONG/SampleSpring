package com.gdj51.test.common.service;

import java.util.HashMap;

public interface IPagingService {
	// 테이블 시작row
	public int getStartCount(int page);

	// 테이블 종료row
	public int getEndCount(int page);

	// 페이징 최대 크기
	public int getMaxPcount(int maxCount);

	// 현재페이지 기준 시작페이지
	public int getStartPcount(int page);

	// 현재페이지 기준 종료페이지
	public int getEndPcount(int page, int maxCount);

	// 빈형식으로 취득
	public HashMap<String, Integer> getPagingData(int page, int maxCount);

	/*****************
	 * Custom Paging *
	 ******************/
	// 테이블 시작row
	public int getStartCount(int page, int viewCnt);

	// 테이블 종료row
	public int getEndCount(int page, int viewCnt);

	// 페이징 최대 크기
	public int getMaxPcount(int maxCount, int viewCnt);

	// 현재페이지 기준 시작페이지
	public int getStartPcount(int page, int pageCnt);

	// 현재페이지 기준 종료페이지
	public int getEndPcount(int page, int maxCount, int viewCnt, int pageCnt);

	// 빈형식으로 취득
	public HashMap<String, Integer> getPagingData(int page, int maxCount, int viewCnt, int pageCnt);

}
