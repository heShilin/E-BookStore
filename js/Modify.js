function modify() {
	var isbn = document.getElementById("info").innerHTML
	var bookname = document.getElementById("bookname").value
	var bauthor = document.getElementById("bauthor").value
	var bprice = document.getElementById("bprice").value
	var bcount = document.getElementById("bcount").value
	var bdetail = document.getElementById("bdetail").value

	var url = "../jsp/ModifyG.jsp?isbn="+isbn+"&bname="+bookname+"&bauthor="+bauthor+"&bprice="+bprice+"&bcount="+bcount+"&bdetail="+bdetail
	// alert(url)
	var xmlhttp = new XMLHttpRequest()
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status >= 304) {
				alert(xmlhttp.responseText)
				document.getElementById("info1").innerHTML = xmlhttp.responseText
				window.location.reload()
			}
			else
				alert("Request was unsuccessful : " + xmlhttp.status)
		}
	}
	xmlhttp.open("Get", url, true)
	xmlhttp.send(null)
}