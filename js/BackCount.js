function back() {
	var url = "../jsp/Back.jsp"
	var xmlhttp = new XMLHttpRequest()
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status >= 304) {
				alert("已成功注销账号！")
				window.location.reload()
			}
			else 
				alert("Request was unsuccessful : " + xmlhttp.status)
		}
	}
	xmlhttp.open("Get", url, true)
	xmlhttp.send(null)
}