<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Calendar Sample</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- calendar select css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />

<!-- Fullcalendar css -->
<link rel="stylesheet" type="text/css" href="resources/script/fullcalendar/fullcalendar.css" />

<!-- calendar css -->
<link rel="stylesheet" type="text/css" href="resources/css/calendar/calendar.css" />

<style type="text/css">
.wrap {
	width: 800px;
	margin: 0 auto;
	font-size: 10.5pt;
}

#fullCalendarArea {
	height: 400px;
}
</style>

<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
<!-- Moment Script -->
<script type="text/javascript" src="resources/script/jquery/moment.js"></script>


<!-- Fullcalendar Script -->
<script type="text/javascript" src="resources/script/fullcalendar/fullcalendar.js"></script>
<script type="text/javascript" src="resources/script/fullcalendar/locale-all.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var data = [
        {
            title: 'All Day Event',
            start: '2019-01-01',
            color : 'yellow', // 기타 옵션들
			textColor : 'black',
          },
          {
            title: 'Long Event',
            start: '2019-01-07',
            end: '2019-01-10'
          },
          {
            id: 999,
            title: 'Repeating Event',
            start: '2019-01-09T16:00:00'
          },
          {
            id: 999,
            title: 'Repeating Event',
            start: '2019-01-16T16:00:00'
          }
        ];
	
	$("#fullCalendarArea").fullCalendar({
		header: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'month,agendaWeek,agendaDay,listMonth'
	      },
	      defaultDate: '2019-01-12',
	      locale: "ko",
	      editable: false,
	      height: 450,
	      events: data,
	      eventClick: function(event) { // 이벤트 클릭
	    	  alert(event.start);
	      },
	      dayClick: function(date, js, view) { // 일자 클릭
	    	  alert('Clicked on: ' + date.format());

	    	  //alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);

	    	  //alert('Current view: ' + view.name);
	      }
	});
	
	$("#eventChangeBtn").on("click", function() {
		var newEvents = [ {
			title : "계획1",
			start : "2019-01-02",
			end : "2019-01-08",
			color : 'yellow', // 기타 옵션들
			textColor : 'black',

		}, {
			title : "계획2",
			start : "2019-01-02",
			end : "2019-01-08",
			color : 'green', // 기타 옵션들
			textColor : 'black',
		} ];
		
		var oldEvents = $("#fullCalendarArea").fullCalendar("getEventSources");
		//기존 이벤트 제거
		$("#fullCalendarArea").fullCalendar("removeEventSources", oldEvents);
		$("#fullCalendarArea").fullCalendar("refetchEvents");
		//신규이벤트 추가
		$("#fullCalendarArea").fullCalendar("addEventSource", newEvents);
		$("#fullCalendarArea").fullCalendar("refetchEvents");
	});
});
</script>

<!-- calendar Script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	showCalendar(d.getFullYear(),(d.getMonth() + 1));
});
</script>

<!-- calendar select script -->
<script type="text/javascript">
$(document).ready(function() {
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		showOn: 'button',
		closeText: '닫기',
		buttonImage: 'resources/images/calender.png',
		buttonImageOnly: true,
		dateFormat: 'yy/mm/dd'    
	}); 
	
	$("#date_start").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#date_end").val().replace("-", '').replace("-", ''));
			var endDate = parseInt(dateText.replace(/-/g,''));
			
            if (endDate > startDate) {
            	alert("조회 기간은 과거로 설정하세요.");
            	//달력에 종료 날짜 넣어주기
        		$("#date_start").val($("#stdt").val());
			} else {
				$("#stdt").val($("#date_start").val());
			}
		}
	});
	
	$("#date_end").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#date_start").val().replace("-", '').replace("-", ''));
			var endDate = parseInt(dateText.replace(/-/g,''));
			
            if (startDate > endDate) {
            	alert("조회 기간은 과거로 설정하세요.");
            	//달력에 종료 날짜 넣어주기
        		$("#date_end").val($("#eddt").val());
			} else {
				$("#eddt").val($("#date_end").val());
			}
		}
	});
});
</script>
</head>
<body>
	<div class="cmn_title">달력 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
	<div class="wrap">
	<div class="headline">jQuery Datepicker</div>
	<input type="hidden" id="stdt" name="stdt" value="${stdt}" />
	<input type="hidden" id="eddt" name="eddt" value="${eddt}" />
	<div>
	<input type="text" width="80px" title="시작기간선택" id="date_start" name="date_start" value="" readonly="readonly" />
	~
	<input type="text" title="종료기간선택" id="date_end" name="date_end" value="" readonly="readonly" />
	</div>
	<div class="headline">Javascript custom calendar</div>
	<div id="calendarArea"></div>
	<div class="headline">Full Calendar</div>
	<div class="cmn_btn_ml float_right_btn" id="eventChangeBtn">이벤트 교체</div>
	<div id="fullCalendarArea"></div>
	</div>
</body>
</html>













