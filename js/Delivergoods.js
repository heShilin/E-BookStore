function delivergoods(uname, isbn, cnt, date_buy) {
	var url = "../jsp/DeliverGoods.jsp?uname=" + uname + "&isbn=" + isbn + "&cnt=" + cnt + "&date=" + date_buy
	
	var xmlhttp = new XMLHttpRequest()
	xmlhttp.onreadystatechange = function () {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status <300 || xmlhttp.status >= 304) {
				alert(xmlhttp.responseText)
				document.getElementById("info").innerHTML = xmlhttp.responseText
				window.location.reload()
			}
			else {
				alert("Request was unsuccessful : " + xmlhttp.status)
			}
		}
	}
	xmlhttp.open("Get", url, true)
	xmlhttp.send(null)
}