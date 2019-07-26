<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=utf-8" %>
<%!Integer isbn = 0; String picAdd = ""; String bname = ""; String bauthor = ""; double bprice = 0; String binfo = ""; Integer bcount = 0; String uname = "";%>
<%
    request.setCharacterEncoding("utf-8");
    String temp = (String)session.getAttribute("login_name");
	if (temp != null && !temp.isEmpty()) {
		uname = temp;
	}
	else { 
		out.print("<script type='text/javascript'>alert('请您先登录！'); window.location.href='http://localhost:8080/Project/jsp/Login.jsp'</script>");
	}

	String msg = "";

	String param = request.getParameter("isbn");
	if (param != null && !param.isEmpty()) isbn = Integer.parseInt(param);

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = String.format("select * from books where isbn=%d;", isbn);

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			picAdd = rs.getString("picture");
			bname = rs.getString("bookname");
			bauthor = rs.getString("author");
			bprice = rs.getDouble("price");
			bcount = rs.getInt("cnt");
			binfo = rs.getString("info");
		}
		stmt.close();
		rs.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>修改商品信息</title>
	<link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<link rel="stylesheet" href="../css/Header.css">
	<link rel="stylesheet" type="text/css" href="../css/Nav.css">
	<style type="text/css">
		* { margin: 0; padding: 0; font-family: 楷体; }
		
		.wrapper { margin: 0 auto; width:980px; position: relative;} 

        #header_outer { height: 140px; background: url("../images/header_bg.png") repeat-x; }

        #header {height: 140px;}

		.Detail_Page { height: 21rem; width: 55rem; position: relative; top: 1rem; margin: 0 auto; border: 1px red solid}
		
		.goods { height: 17.6rem; width: 55rem; border: 1px solid red; position: relative; margin: 0 auto; }
		
		.goodsName { font-size:1rem; border-bottom: 1px solid yellow; }

		.author { border-bottom: 1px solid green; }
		
		.goodsPri { color: red; border-bottom: 1px solid blue; }
		
		.coleft { float: left; height: 15rem; width: 15rem; }
		
		.colright { line-height:1.5rem; }
		
		.Bttn_new { margin: 1rem auto;  border: 1px solid black; text-align: center; height: 2rem; width: 55rem}
		
		a { text-decoration: none; color: black; } 
		
		.detail { text-align:justify; height: 15rem; }
		
		#comf, #cancel{ width: 5rem; height: 1.5rem }
		#comf:hover { color: red; }
		#cancel:hover { color: red; }
		
		img { width: 100%; height: 100%; max-width: auto; max-height: auto; }
	</style>
	<script type="text/javascript">
		function Back() {
			window.history.go(-1)
		}
	</script>
</head>
<body>
	<div id="header_outer">
	    <div id="header" class="wrapper">
	        <div style="height: 20px">
	            <div style="float: left;">当前管理员为： <%=uname%></div>
            </div>
	        <div id="logo" style="width: 10rem; height: 7rem">
            	<img src="../images/logo.png">
        	</div>
        </div><!--header-->
    </div> <!--header_outer-->

	<div id="nav_outer"></div>
	<div id="main_outer">
		<div class="Detail_Page">
			<div class="goods">
				<div class="coleft"><img src="<%=picAdd%>"></div>
				<div class="colright">
					<div class="goodsName">书名： <input type="text" id="bookname" value="<%=bname%>" size="70"></div>
					<div class="author">作者： <input type="text" id="bauthor" value="<%=bauthor%>" size="70"></div>
					<div class="goodsPri">价格： ¥ <input type="text" id="bprice" value="<%=bprice%>" size="4"> 库存： <input type="text" id="bcount" value="<%=bcount%>" size="2"></div> 
					简介：<div class="detail"><textarea id="bdetail" cols="77" rows="10"><%=binfo%></textarea></div>
				</div>
			</div>	
		</div>
		<div class="Bttn_new">
			<div id="info" style="display: none;"><%=isbn%></div>
			<button onclick="modify()" id="comf">确认</button>
			<button onclick="Back()" id="cancel">返回</button>
			<div id="info1" style="display: none;"></div>
		</div>
	</div>
	<script type="text/javascript" src="../js/Modify.js"></script>
</body>
</html>