<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chart Sample</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<style type="text/css">
.wrap {
	width: 700px;
	margin: 0 auto;
	font-size: 10.5pt;
}

.btn_wrap {
	height: 30px;
	margin: 10px 0px;
}
</style>
<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
		
<!-- highcharts Script -->
<script src="resources/script/highcharts/highcharts.js"></script>
<script src="resources/script/highcharts/modules/exporting.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	getData();
	
	$("#reloadBtn").on("click", function() {
		getData();
	});
	
	$("body").on("click", "div[name='typeBtn']", function(){
		$("#chartType").val($(this).attr("id"));
		getData();
	});
});

function getData() {
	var params =  $("#getForm").serialize();
	$.ajax({
		type : "post",
		url : "getChartData",
		dataType : "json",
		data : params,
		success : function(result) {
			makeChart(result.list);
		},
		error : function(request,status,error) {
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function makeChart(list) {
	$('#container').highcharts({
        chart: {
            type: $("#chartType").val(),
            zoomType: 'x'
        },
        colors: ['#5CB3FF', '#D462FF', '#FBB917', '#00B3A2', '#FB558A', 
                 '#2870E3', '#FF8F00', '#B5BF07', '#3F9D00', '#CE3C92'],
        title: {
            text: 'SampleChart'
        },
        subtitle: {
            text: '- Sample -'
        },
        xAxis: {
            labels: {
                formatter: function() {
                    return this.value; // clean, unformatted number for year
                }
            }
        },
        yAxis: {
            title: {
                text: 'yPos'
            },
            labels: {
                formatter: function() {
                    return this.value +'k';
                }
            }
        },
        tooltip: {
            pointFormat: '{series.name} produced <b>{point.y:,.0f}</b><br/>in {point.x}'
        },
        plotOptions: {
            area: {
                pointStart: 1,
                marker: {
                    enabled: false,
                    symbol: 'circle',
                    radius: 2,
                    states: {
                        hover: {
                            enabled: true
                        }
                    }
                }
            }
        },
        series: list
    });
}
</script>
</head>
<body>
<div class="cmn_title">Highchart 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
<div class="wrap">
<input type="hidden" id="chartType" value="column"/>
<form action="#" id="getForm">
사이즈 : <input type="text" name="size" value="5" />
시리즈 : <input type="text" name="series" value="2" />
</form>
<div class="btn_wrap">
<div class="cmn_btn_mr" id="reloadBtn">리로드</div>
<div class="cmn_btn_mr" id="column" name="typeBtn">컬럼</div>
<div class="cmn_btn_mr" id="bar" name="typeBtn">바</div>
<div class="cmn_btn_mr" id="area" name="typeBtn">에리어</div>
<div class="cmn_btn_mr" id="line" name="typeBtn">라인</div>
</div>
<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</div>
</body>
</html>