function removeGoods() {

	var isbn = document.getElementById("info").innerHTML
	var url = "../jsp/Removegoods.jsp?isbn=" + isbn
	
	var xmlhttp = new XMLHttpRequest()
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status >= 304) {
				alert('商品已下架!')
				window.history.back()
			}
			else 
				alert("Request was unsuccessful : "+xmlhttp.status)
		}
		
	}
	xmlhttp.open("Get", url, true)
	xmlhttp.send(null)

}