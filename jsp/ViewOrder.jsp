<%@page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=utf-8"%>
<%!String table = "";%>
<%
	request.setCharacterEncoding("utf-8");
	String date = "";
	String msg = "";
	table = "";
	String uname = "";
	String temp = (String)session.getAttribute("login_name");
	if (temp != null && !temp.isEmpty()) uname = temp ;
	else out.print("<script type='text/javascript'>alert('请您先登录！'); window.location.href='http://localhost:8080/Project/jsp/Login.jsp'</script>");

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = "select * from purchaseorder;";

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
			date = "\"" + rs.getString("date_buy") + "\"";
			table += String.format(
				"<div style='height:7rem; width:45rem; border:1px solid black; margin-bottom:1rem;'><a href='GoodsDetail.jsp?isbn=%d'><div style='float:left;border-right:1px solid green;height:7rem;width:7rem'><img src='%s'></img></div></a><div style='float:rigtht; height:7rem; overflow: hidden;'><div style='height:1.3rem;border-bottom:1px solid red;overflow: hidden;' id='bname'>下单人： %s  下单时间： %s</div><div style='height:1.3rem;border-bottom:1px solid blue;overflow: hidden;' id='bname'>书名： %s</div><div style='height:1.3rem;border-bottom:1px solid green;overflow: hidden;' id='bauthor'>作者： %s</div><div style='height:1.3rem;border-bottom:1px solid yellow' id='price'>价格： %.2f</div><div style='height:1.3rem;float:left' id='cnt'>数量： %d</div><div style='float:right'><button onclick='delivergoods(%s, %d, %d, %s)'>发货</button></div></div></div>", 
				rs.getInt("isbn"), rs.getString("picture"), rs.getString("username"), rs.getString("date_buy"), rs.getString("bname"), rs.getString("author"), rs.getDouble("price"),rs.getInt("count"),"\""+rs.getString("username")+"\"", rs.getInt("isbn"), rs.getInt("count"), date
				);
		}
		rs.close();
		stmt.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>

<!DOCTYPE html>
<html>
<head>
	<title>查看订单</title>
	<link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<link rel="stylesheet" href="../css/Header.css">
	<link rel="stylesheet" type="text/css" href="../css/Nav.css">
	<style type="text/css">
		* { margin:0; padding:0; font-family:楷体; line-height:1.2em }
		
		.header_outer { height: 120px; background: url("../images/header_bg.png") repeat-x; }
		
		.header { width: 45rem; height: 120px; margin: 0 auto;}
		
		.logo { float: left; margin-top: 10px; }
		
		#tip:hover{ color: red; }
		
		.wrapper { margin: 0 auto; width:45rem;} 
		
		img { width: auto; height: auto; width: 100%; height: 100%; }

		a { text-decoration: none; color: black; }

		* { font-size: 1rem; }
	</style>
	<script type="text/javascript">
		function Back() {
			window.location.href = "HomePage.jsp"
		}
	</script>
	<script type="text/javascript" src="../js/Delivergoods.js"></script>
</head>
<body>
	<div class="header_outer">
		<div class="header">
			<div style="height: 20px">
	            <div style="float: left;">当前用户为： <%=uname%></div>
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
            <%=table%>
        </div> 
    </div> 
	<div id="info" style="display: none;"><%=date%></div>
	<!-- <div id="info"><%=date%></div>  -->
</body>
</html>