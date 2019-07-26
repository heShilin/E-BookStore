var pgno = 0
window.onload = function() { 
	goodsList(pgno)
}

function goodsList(pg) {
	var t = document.getElementById("ty1").innerHTML
    var types = document.getElementById("ty2").innerHTML
    var table = document.getElementById("ty3").innerHTML
   
    var bname = document.getElementById("bname")
    var author = document.getElementById("author")

    if (t == 1) {
        document.getElementById("recommend").innerHTML = "搜索结果"
        document.getElementById("goods_query").innerHTML = table
        document.getElementById("goods").style.display = "none"
        document.getElementById("foot_outer").style.display = "none"

	    if (types == "author") author.checked = "checked"
	    if (types == "bname") bname.checked = "checked"	
    }
    else {
    	author.checked = ""
    	bname.checked = ""	

        document.getElementById("recommend").innerHTML = "今日推荐"

        var url = "../jsp/GetBooks.jsp?pgno=" + pg
		var xmlhttp = new XMLHttpRequest()
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status >= 200 && xmlhttp.status < 300 || xmlhttp.status >= 304) {
					var returnValue = xmlhttp.responseText
					//alert(xmlhttp.responseText)
					var info = returnValue.split("~")
					pgno = parseInt(info[0])
					document.getElementById("goods").innerHTML = info[1]
					document.getElementById("pageNum").innerHTML = pgno + 1
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
	if (pgno < 9) 
		pgno = pgno + 1
	else 
		alert("当前为最后一页")
	goodsList(pgno)
}

function sub() {
	if (pgno > 0)
		pgno = pgno - 1
	else 
		alert("当前为第一页")
	goodsList(pgno)
}