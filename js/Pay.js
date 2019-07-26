function pay() {
	var isbn = document.getElementById("info1").innerHTML
	var url = "../jsp/PayHost.jsp?isbn=" + isbn

	var xmlhttp = new XMLHttpRequest()
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status >= 304) {
				//document.getElementById("info2").innerHTML = xmlhttp.responseText
				alert("支付成功！")
				//history.go(-1);
				window.history.back(-2)
			}
			else
				alert("Request was unsuccessful : ", xmlhttp.status)
		}
	}
	xmlhttp.open("Get", url, true)
	xmlhttp.send(null)
}