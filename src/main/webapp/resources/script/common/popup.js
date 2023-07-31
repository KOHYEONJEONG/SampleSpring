/**
 * popup.js
 * create date : 2022.03.15
 * create by : YS.Lee
 */

/**
 * makeAlert(title, contents, event)
 * : 알림창 생성
 * title - 제목
 * contents - 내용
 * event - 팝업 닫을 시 이벤트(없을경우 null입력)
 */
function makeAlert(title, contents, event) {
	var depth = 0;
	
	$(".popup").each(function() {
		let no = $(this).attr("id").substring(5) * 1;
		
		if(depth < no) {
			depth = no;
		}
	});
	
	depth++;
	
	// 해당 depth에 팝업 없을 시
	if(!popupCheck(depth)) {
		var html = "";
		
		html += "<div class=\"popup_bg_clear\" id=\"popup" + depth + "Bg\"></div>";
		html += "<div class=\"popup\" id=\"popup" + depth + "\">";
		html += "	<div class=\"popup_title\">" + title + "</div>";
		html += "	<div class=\"popup_cont\">";
		html += contents;
		html += "	</div>";
		html += "	<div class=\"popup_btn_area\">";
		html += "		<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn1\">확인</div>";
		html += "	</div>";
		html += "</div>";
		
		$("body").prepend(html);
		
		$("#popup" + depth).css("z-index", depth * 120);
		$("#popup" + depth + "Bg").css("z-index", depth * 110);
		
		$("#popup" + depth).hide();
		
		$("#popup" + depth).fadeIn("fast");
		
		$("#popup" + depth + "Btn1").off("click");
		$("#popup" + depth + "Btn1").on("click", function(){
			if(event != null) {
				event.call();
			}
			
			closePopup(depth);
		});
		
		$("#popup" + depth + "Bg").off("click");
		$("#popup" + depth + "Bg").on("click", function(){
			closePopup(depth);
		});
	}
}


/**
 * makePopup(option)
 * : 팝업 생성
 * 
 * - 옵션정보 -
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * width - 팝업너비 (숫자)
 * height - 팝업높이 (숫자)
 * bg - 백그라운드 존재여부(true : 존재-기본값, flase : 비존재)
 * bgClose - 백그라운드 클릭 시 닫기여부(true : 존재-기본값, flase : 비존재)
 * title - 제목
 * contents - 내용
 * contentsEvent - 내용 추가이벤트
 * 
 * buttons - 버튼추가(배열옵션객체 : 버튼다수, 옵션객체 : 버튼한개)
 * draggable - 드래그 가능여부(true : 가능, flase : 불가능-기본값)
 * - buttons 옵션정보 -
 * name - 버튼명
 * func - 동작이벤트
 */
function makePopup(option) {
	if(option != null) {
		var depth = 0;
		
		if(Object.keys(option).includes("depth")) { // depth가 넘어오는 경우
			if(option.depth > 0) { // 정상적 depth
				depth = option.depth;
			} else { // 비정상 depth
				depth = $(".popup").length + 1;
			}
		} else {
			depth = $(".popup").length + 1;
		}
		
		// 해당 depth에 팝업 없을 시 팝업 drawing
		if(!popupCheck(depth)) {
			var html = "";
			
			// 배경 설정
			var bgFlag = true;
			
			if(Object.keys(option).includes("bg") && typeof option.bg == "boolean") { // depth가 넘어오는 경우
				bgFlag = option.bg;
			}
			
			if(bgFlag) {
				html += "<div class=\"popup_bg\" id=\"popup" + depth + "Bg\"></div>";
			} else {
				html += "<div class=\"popup_bg_clear\" id=\"popup" + depth + "Bg\"></div>";
			}
			
			// 팝업 타이틀과 내용확인
			var title = "";
			
			if(Object.keys(option).includes("title")) { // depth가 넘어오는 경우
				title = option.title;
			}
			
			var contents = "";
			
			if(Object.keys(option).includes("contents")) { // depth가 넘어오는 경우
				contents = option.contents;
			}
			
			html += "<div class=\"popup\" id=\"popup" + depth + "\">";
			html += "	<div class=\"popup_title\">" + title + "</div>";
			html += "	<div class=\"popup_cont\">";
			html += contents;
			html += "	</div>";
			html += "	<div class=\"popup_btn_area\">";
			
			// 버튼그리기
			if(Object.keys(option).includes("buttons")) { // 버튼이 넘어오는 경우
				if(Array.isArray(option.buttons)) {
					for(var i = 0 ; i < option.buttons.length ; i++) {
						if(Object.keys(option.buttons[i]).includes("name")) { // 이름이 넘어오는 경우
							html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn" + i + "\">" + option.buttons[i].name + "</div>";
						} else {
							html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn" + i + "\">버튼" + (i + 1) + "</div>";
						}
					}
				} else {
					if(Object.keys(option.buttons).includes("name")) { // 이름이 넘어오는 경우
						html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn\">" + option.buttons.name + "</div>";
					} else {
						html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn\">버튼</div>";
					}
				}
			} else {
				html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn\">확인</div>";
			}
			
			html += "	</div>";
			html += "</div>";
			
			$("body").prepend(html);
			
			if(Object.keys(option).includes("contentsEvent")) {
				option.contentsEvent.call();
			}
			
			if(Object.keys(option).includes("draggable")) {
				if(option.draggable) {
					$("#popup" + depth).draggable({containment: "body"});
				}
			}
			
			$("#popup" + depth).css("z-index", depth * 120);
			$("#popup" + depth + "Bg").css("z-index", depth * 110);
			
			// 크기 조절
			if(Object.keys(option).includes("width") && !isNaN(option.width * 1)) {
				$("#popup" + depth).css("width", option.width + "px");
				$("#popup" + depth).css("left", "calc(50% - " + (option.width / 2) + "px");
			}
			if(Object.keys(option).includes("height") && !isNaN(option.height * 1)) {
				$("#popup" + depth).css("height", option.height + "px");
				$("#popup" + depth).css("top", "calc(50% - " + (option.height / 2) + "px");
			}
			
			$("#popup" + depth).hide();
			
			$("#popup" + depth).fadeIn("fast");
			
			// 버튼이벤트
			if(Object.keys(option).includes("buttons")) { // 버튼이 넘어오는 경우
				if(Array.isArray(option.buttons)) { // 버튼이 배열인 경우
					for(var i = 0 ; i < option.buttons.length ; i++) {
						if(Object.keys(option.buttons[i]).includes("func") && typeof option.buttons[i].func == "function") { // 함수가 넘어오는 경우
							$("#popup" + depth + " #popup" + depth + "Btn" + i + "").off("click");
							$("#popup" + depth + " #popup" + depth + "Btn" + i + "").on("click", option.buttons[i].func);
						} else { // 함수가 넘어오지 않는 경우
							$("#popup" + depth + " #popup" + depth + "Btn" + i + "").off("click");
							$("#popup" + depth + " #popup" + depth + "Btn" + i + "").on("click", function(){
								closePopup(depth);
							});
						}
					}
				} else { // 버튼이 배열이 아닌 경우
					if(Object.keys(option.buttons).includes("func") && typeof option.buttons.func == "function") { // 함수가 넘어오는 경우
						$("#popup" + depth + " #popup" + depth + "Btn").off("click");
						$("#popup" + depth + " #popup" + depth + "Btn").on("click", option.buttons.func);
					} else { // 함수가 넘어오지 않는 경우
						$("#popup" + depth + " #popup" + depth + "Btn").off("click");
						$("#popup" + depth + " #popup" + depth + "Btn").on("click", function(){
							closePopup(depth);
						});
					}
				}
			} else { // 버튼이 넘어오지 않는 경우
				$("#popup" + depth + " #popup" + depth + "Btn").off("click");
				$("#popup" + depth + " #popup" + depth + "Btn").on("click", function(){
					closePopup(depth);
				});
			}
			
			// 배경 클릭 닫기 이벤트 여부
			var bgClose = true;
			
			if(Object.keys(option).includes("bgClose") && typeof option.bgClose == "boolean") { // depth가 넘어오는 경우
				bgClose = option.bgClose;
			}
			
			if(bgClose) {
				$("#popup" + depth + "Bg").off("click");
				$("#popup" + depth + "Bg").on("click", function(){
					closePopup(depth);
				});
			}
		}
	} else { // option이 넘어오지 않은 경우
		console.error("Empty Option : makePopup function's option is empty");
	}
}

/**
 * closePopup(depth)
 * : 팝업 닫기
 * val - 팝업깊이 (1부터 시작하며, z-index가 커짐), 생략 시 가장 밖 팝업 제거
 */
function closePopup(val) {
	var depth = 0;
	
	if(typeof val != "undefined") {
		depth = val;
	} else {
		depth = $(".popup")[$(".popup").length - 1].id.substring(5);
	}
	
	$("#popup" + depth + "Bg").fadeOut("fast", function(){
		$("#popup" + depth + "Bg").remove();
	});
	
	$("#popup" + depth).fadeOut("fast", function(){
		$("#popup" + depth).remove();
	});
}

/**
 * popupCheck(depth)
 * : 팝업 존재여부
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 */
function popupCheck(depth) {
	if($("#popup" + depth).length > 0) {
		return true;
	} else {
		return false;
	}
}

/**
 * popupContentsChange(depth, contents, contentsEvent)
 * : 팝업 존재여부
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * contents - 내용
 * contentsEvent - 내용 추가이벤트(없을경우 제외)
 */
function popupContentsChange(depth, contents, contentsEvent) {
 	$("#popup" + depth + " .popup_cont").html(contents);
 	
 	if(typeof contentsEvent != "undefined" && typeof contentsEvent == "function") {
 		contentsEvent.call();
 	}
 }

/**
 * popupBtnChange(buttons)
 * : 팝업 버튼 교체
 * depth - 팝업깊이 (1부터 시작하며, z-index가 커짐)
 * buttons - 버튼추가(배열옵션객체 : 버튼다수, 옵션객체 : 버튼한개)
 * 
 * - buttons 옵션정보 -
 * name - 버튼명
 * func - 동작이벤트
 */
function popupBtnChange(depth, buttons) {
	// 버튼그리기
	if(typeof buttons != "undefined") { // 버튼이 넘어오는 경우
		if(Array.isArray(option.buttons)) {
			for(var i = 0 ; i < buttons.length ; i++) {
				if(Object.keys(buttons[i]).includes("name")) { // 이름이 넘어오는 경우
					html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn" + i + "\">" + buttons[i].name + "</div>";
				} else {
					html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn" + i + "\">버튼" + (i + 1) + "</div>";
				}
			}
		} else {
			if(Object.keys(buttons).includes("name")) { // 이름이 넘어오는 경우
				html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn\">" + buttons.name + "</div>";
			} else {
				html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn\">버튼</div>";
			}
		}
	} else {
		html += "<div class=\"cmn_btn_mr\" id=\"popup" + depth + "Btn\">확인</div>";
	}
	
	$("#popup" + depth + " .popup_btn_area").html(html);
	
	//버튼이벤트
	if(typeof buttons != "undefined") { // 버튼이 넘어오는 경우
		if(Array.isArray(buttons)) { // 버튼이 배열인 경우
			for(var i = 0 ; i < buttons.length ; i++) {
				if(Object.keys(buttons[i]).includes("func") && typeof buttons[i].func == "function") { // 함수가 넘어오는 경우
					$("#popup" + depth + " #popup" + depth + "Btn" + i + "").off("click");
					$("#popup" + depth + " #popup" + depth + "Btn" + i + "").on("click", buttons[i].func);
				} else { // 함수가 넘어오지 않는 경우
					$("#popup" + depth + " #popup" + depth + "Btn" + i + "").off("click");
					$("#popup" + depth + " #popup" + depth + "Btn" + i + "").on("click", function(){
						closePopup(depth);
					});
				}
			}
		} else { // 버튼이 배열이 아닌 경우
			if(Object.keys(buttons).includes("func") && typeof buttons.func == "function") { // 함수가 넘어오는 경우
				$("#popup" + depth + " #popup" + depth + "Btn").off("click");
				$("#popup" + depth + " #popup" + depth + "Btn").on("click", buttons.func);
			} else { // 함수가 넘어오지 않는 경우
				$("#popup" + depth + " #popup" + depth + "Btn").off("click");
				$("#popup" + depth + " #popup" + depth + "Btn").on("click", function(){
					closePopup(depth);
				});
			}
		}
	} else { // 버튼이 넘어오지 않는 경우
		$("#popup" + depth + " #popup" + depth + "Btn").off("click");
		$("#popup" + depth + " #popup" + depth + "Btn").on("click", function(){
			closePopup(depth);
		});
	}
}