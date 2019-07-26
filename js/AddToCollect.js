function addTocollect(isbn) {
	var url = "../jsp/AddTocollect.jsp?isbn=" + isbn
	var uname = document.getElementById("user_name").innerHTML
	if (uname=="" || uname==null) {
		alert('请您先登录 ！')
		window.location.href="../jsp/Login.jsp"
	}
	else {
		var xmlhttp = new XMLHttpRequest()
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status > 304) {
					alert(xmlhttp.responseText)
				}
				else 
					alert("Request was unsuccessful : " + xmlhttp.status)
			}
		}
		xmlhttp.open("Get", url, true)
		xmlhttp.send(null)
	}
}