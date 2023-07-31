var d = new Date();
 
function showCalendar(y, m) { 
    var text = "";
    text += "<div class=\"calendar_wrap\">";
    text += "<table class=\"calendar_table\" border=\"0\" cellspacing=\"0\">";
    text += "<colgroup>";
    text += "<col width=\"50px\" />";
    text += "<col width=\"50px\" />";
    text += "<col width=\"50px\" />";
    text += "<col width=\"50px\" />";
    text += "<col width=\"50px\" />";
    text += "<col width=\"50px\" />";
    text += "<col width=\"50px\" />";
    text += "</colgroup>";
    text += "<thead>";
    text += "<tr>";
    text += "<td colspan=\"7\">"; 
    text += "<span onclick=\"showCalendar(" + (y - 1) + "," + m + ")\"><div><div><img src=\"resources/images/calendar/nav-left-x2.gif\"/></div></div></span>"; 
    text += "<span onclick=\"showCalendar(" + (m == 1 ? (y - 1) + "," + 12 : y + "," + (m - 1))+")\"><div><div><img src=\"resources/images/calendar/nav-left.gif\"/></div></div></span>"; 
    text += "&nbsp;<div class=\"day_info\">" + y + "년&nbsp;" + ((m < 10) ? ("0" + m) : m) + "월</div>&nbsp;"; 
    text += "<span onclick=\"showCalendar(" + (m == 12 ? (y + 1) + "," + 1 : y + "," + (m + 1)) + ")\"><div><div><img src=\"resources/images/calendar/nav-right.gif\"/></div></div></span>"; 
    text += "<span onclick=\"showCalendar(" + (y + 1) + "," + m + ")\"><div><div><img src=\"resources/images/calendar/nav-right-x2.gif\"/></div></div></span>"; 
    text += "</td>";
    text += "</tr>";
    text += "<tr class=\"day\">";
    text += "<td class=\"calendar_red\">일</td>"; 
    text += "<td>월</td>"; 
    text += "<td>화</td>"; 
    text += "<td>수</td>"; 
    text += "<td>목</td>"; 
    text += "<td>금</td>"; 
    text += "<td>토</td>"; 
    text += "</tr>";
    text += "</thead>";
    text += "<tbody id=\"monthArea\">";
 
    var d1 = (y + (y - y % 4) / 4 - (y - y % 100) / 100 + (y - y % 400) / 400 
          + m * 2 + (m * 5 - m * 5 % 9) / 9 - (m < 3 ? y % 4 || y % 100 == 0 && y % 400 ? 2 : 3 : 4)) % 7;
    
    for (var i = 0; i < 42; i++) { 
        if (i % 7==0) {
        	text += "<tr>"; 
        }
        
        if ((i < d1) || i >= d1 + (m * 9 - m * 9 % 8) / 8 % 2 + ( m==2 ? y % 4 || y % 100 == 0 && y % 400 ? 28 : 29 : 30)) {
            text += "<td>&nbsp;</td>"; 
        } else {
        	if(d.getFullYear() == y && (d.getMonth() + 1) == m && d.getDate() == (i + 1 - d1)) {
	        	if(i % 7 == "") {
		            text += "<td class=\"dateArea\" id=\"" + y + "_" + ((m < 10) ? ("0" + m) : m) + "_" + (i + 1 - d1) + "\" class=\"calendar_red\"><b>" + (i + 1 - d1) + "</b></td>"; 
	        	} else {
		            text += "<td class=\"dateArea\" id=\"" + y + "_" + ((m < 10) ? ("0" + m) : m) + "_" + (i + 1 - d1) + "\"><b>" + (i + 1 - d1) + "</b></td>";
	        	}
        	} else {
	        	if(i % 7 == "") {
		            text += "<td class=\"dateArea\" id=\"" + y + "_" + ((m < 10) ? ("0" + m) : m) + "_" + (i + 1 - d1) + "\" class=\"calendar_red\">" + (i + 1 - d1) + "</td>"; 
	        	} else {
		            text += "<td class=\"dateArea\" id=\"" + y + "_" + ((m < 10) ? ("0" + m) : m) + "_" + (i + 1 - d1) + "\">" + (i + 1 - d1) + "</td>"; 
	        	}
        	}
        	
        }
        
        if (i % 7==6) {
        	text += "</tr>"; 
        }
    }
    
    text += "</tr>";
    text += "</tbody>";
    text += "</table>"; 
    text += "</div>"; 
    
    $("#calendarArea").html(text);
    
    $("#monthArea").off("click", ".dateArea");
    $("#monthArea").on("click", ".dateArea", function(){
    	alert($(this).attr("id"));
    });
} 