function addNewGoods() {
	var bname = document.getElementById("bname").value
	var author = document.getElementById("bauthor").value
	var price = document.getElementById("price").value
	var cnt = document.getElementById("count").value
	var picture = document.getElementById("picture").innerHTML
	var info = document.getElementById("detail").value
	var kind = 0;
	var val = document.getElementById("kind").value;

    if (val == "少儿读物") kind = 1;
    else if (val == "青春文学") kind = 2;
    else if (val == "科技") kind = 3;
    else if (val == "历史") kind = 4;
    else if (val == "管理") kind = 5;
    else if (val == "成功励志") kind = 6;
        
    if (bname==null || bname=="") {
    	alert('书名不能为空！')
    }
    else if (author==null || author=="") {
    	alert('作者名不能为空！')
    }
    else if (price==null || price=="") {
    	alert('价格不能为空！')
    }
    else if (cnt==null || cnt=="") {
    	alert('库存不能为空！')
    }
    else if (picture=="" || picture==null) {
    	alert('未选择图片！')
    }

    else {

		var url = "../jsp/AddNewgoods.jsp?bname="+bname+"&author="+author+"&price="+price+"&cnt="+cnt+"&picture="+picture+"&detail="+info+"&kind="+kind

		// alert(url)

		var xmlhttp = new XMLHttpRequest()
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status >= 200 && xmlhttp.status <300 || xmlhttp.status>=304) {
					alert(xmlhttp.responseText)
					document.getElementById("info1").innerHTML = xmlhttp.responseText
				}
				else
					alert("Request was unsuccessful : " + xmlhttp.status)
			}
		}
		xmlhttp.open("Get", url, true)
		xmlhttp.send(null)
	}
}