/**
 * util.js
 */

/*
 * checkEmpty(셀렉터)
 * 셀렉터에 해당하는 값이 비어있는지를 체크
 * true:비어있음, false:값이 존재
 * create date : 2019.05.23
 */
function checkEmpty(selector) {
	if($.trim($(selector).val()) == "") {
		return true;
	} else {
		return false;
	}
}

/*
 * lpad(값, 목표길이, 추가문자)
 * 왼쪽에 비어있는 숫자만큼 문자추가
 * return 문자열
 * create date : 2019.07.03
 */
function lpad(str, length, chr) {
	str += "";
	
	if(str.length < length) {
		for(var i = 0 ; i < length - str.length ; i++) {
				str = chr + str;
		}
	}
	return str;
}