var pageNum = 0;
window.onload = function() { 
	booklist(pageNum) 
}

function booklist(page) {

	var t = document.getElementById("ty1").innerHTML
    var types = document.getElementById("ty2").innerHTML
    var table = document.getElementById("ty3").innerHTML
   
    var bname = document.getElementById("bname")
    var author = document.getElementById("author")

    if (t == 1) {
        document.getElementById("books_query").innerHTML = table
        document.getElementById("books").style.display = "none"
        document.getElementById("foot_outer").style.display = "none"

	    if (types == "author") author.checked = "checked"
	    if (types == "bname") bname.checked = "checked"
    }
	
	else {
		author.checked = ""
    	bname.checked = ""	

		var kind = document.getElementById("kindofbook").innerHTML
		var url = "../jsp/GetBooksOfkind.jsp?pageNum=" + page + "&kind=" + kind
		var xmlhttp = new XMLHttpRequest()
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status >= 304) {
					var returnValue = xmlhttp.responseText
					var info = returnValue.split("~")
					pageNum = parseInt(info[0])
					document.getElementById("books").innerHTML = info[1]
					document.getElementById("pageNum").innerHTML = pageNum + 1
				}
				else {
					alert("Request was unsuccessful:" + xmlhttp.status)
				}
			}
		}
		xmlhttp.open("Get", url, true)
		xmlhttp.send(null)
	}
}

function add() {
	pageNum = pageNum + 1
	booklist(pageNum)
}

function sub() {
	if (pageNum > 0)
		pageNum = pageNum - 1
	else 
		alert("当前为第一页")
	booklist(pageNum)
}