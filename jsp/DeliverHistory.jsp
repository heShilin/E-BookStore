<%@page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=utf-8"%>
<%!String table = "";%>
<%
	request.setCharacterEncoding("utf-8");
	String uname = "";

	String temp = (String)session.getAttribute("login_name");
	if (temp != null && !temp.isEmpty()) {
		uname = temp;
	}
	else { 
		out.print("<script type='text/javascript'>alert('请您先登录！'); window.location.href='http://localhost:8080/Project/jsp/Login.jsp'</script>");
	}

%>

<!DOCTYPE html>
<html>
<head>
	<title>查看发货历史</title>
	<link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<link rel="stylesheet" href="../css/Header.css">
	<link rel="stylesheet" type="text/css" href="../css/Nav.css">
	<style type="text/css">
		* { margin:0; padding:0; font-family:楷体; line-height:1.2em; }
		
		#tip { float: right; }
		#tip:hover { color: red; }

		.header_outer { height: 120px; background: url("../images/header_bg.png") repeat-x; }
		
		.header { width: 45rem; height: 120px; margin: 0 auto;}
		
		.logo { float: left; margin-top: 10px; }

		.wrapper { margin: 0 auto; width:45rem;} 

		img { width: auto; height: auto; width: 100%; height: 100%; }

		a { text-decoration: none; color: black; }

		* { font-size: 1rem; }

		#footer { width: 10rem; margin: 0 auto; }
	</style>
	<script type="text/javascript">
		function Back() {
			window.location.href = "HomePage.jsp"
		}
	</script>
</head>
<body>
	<div class="header_outer">
		<div class="header">
			<div style="height: 20px">
	            <div style="float: left;">当前管理员为： <%=uname%></div>
	            <div id="tip" style="float: right;" onclick="Back()">返回</div>
            </div>
			<div class="logo" style="width: 10rem; height: 7rem">
            	<img src="../images/logo.png">
        	</div>
		</div>
	</div>
	<div id="nav_outer"></div>
	<div id = "main_outer">
        <div class = "wrapper" id="main" style="color: black" style="margin: 0 auto;"> 
            <div id="List"></div>
			<div id="footer">
				<button onclick="sub()">上一页</button> <div id="pageNum" style="display: inline;"></div> <button onclick="add()">下一页</button>
			</div>
        </div> 
    </div> 

	<div id="info"></div>
	
	<script type="text/javascript" src="../js/Deliverhistory.js"></script>
	
</body>
</html>