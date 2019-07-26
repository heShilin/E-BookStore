var pageNum = 0
window.onload = function() {
	replace(pageNum)
}

function replace(page) {
	var url = "../jsp/DeliverList.jsp?pageNum=" + page

	var xmlhttp = new XMLHttpRequest()
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status >= 304) {
				var returnValue = xmlhttp.responseText
				var info = returnValue.split("~")
				var pageMax = parseInt(info[0]) / 5

				if (pageNum > pageMax) {
					pageNum = pageNum - 1
					alert("当前为最后一页！")
				}
				else {
					document.getElementById("List").innerHTML = info[1]
				}
				document.getElementById("pageNum").innerHTML = pageNum + 1
			}
			else
				alert("Request was unsuccessful : " + xmlhttp.status)
		}
	}
	xmlhttp.open("Get", url, true)
	xmlhttp.send(null)
}

function add() {
	pageNum = pageNum + 1
	replace(pageNum)
}

function sub() {
	if (pageNum <1 ) 
		alert("当前为第一页 ！")
	else {
		pageNum = pageNum - 1
		replace(pageNum)
	}
}