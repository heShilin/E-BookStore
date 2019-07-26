<%@page language="java" import="java.util.*, java.sql.*, java.text.*" contentType="text/html; charset=utf-8"%>
<%!String table = ""; String count = "";%>
<%
	request.setCharacterEncoding("utf-8");

	Integer isbn = 0;
	Integer cnt = 0;
	String msg = "";
	String uname = "";
	count = "";
	String temp = (String)session.getAttribute("login_name");
	if (temp!=null && !temp.isEmpty()) uname = temp;
	else { 
		out.print("<script type='text/javascript'>alert('请您先登录！'); window.location.href='http://localhost:8080/Project/jsp/Login.jsp'</script>");
	}

	temp = request.getParameter("isbn");
	if (temp != null && !temp.isEmpty()) isbn = Integer.parseInt(temp);
	
	temp = request.getParameter("cnt");
	if (temp != null && !temp.isEmpty()) cnt = Integer.parseInt(temp);

	table = "";

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");

		String sql = String.format("select * from books where isbn=%d;", isbn);

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);

		if (rs.next()) {
			double p_temp = rs.getDouble("price");
			table += String.format(
				"<div style='width: 55rem; height: 20rem;'><div style='float:left; width:15rem; height: 15rem; border:1px solid blue;'><img src='%s'></img></div><div style='height:1.3rem;border:1px solid yellow;overflow: hidden;'>书名： %s</div><div style='height:1.3rem;border:1px solid green;overflow: hidden;'>作者：%s</div><div style='height:1.3rem;border:1px solid black;overflow: hidden;'>价格：<span style='color: red;'>¥ %.2f</span></div><div style='height:1.3rem;border:1px solid gray;overflow: hidden;'>数目：%d</div><div style='text-align:justify;'>简介：%s</div></div>", rs.getString("picture"), rs.getString("bookname"), rs.getString("author"), p_temp, cnt, rs.getString("info")
				);
			double c = cnt * p_temp;
			DecimalFormat df = new DecimalFormat("#.00");
			count = df.format(c);
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
	<link rel="icon" type="image/x-icon" href="../images/book.ico">
	<title>支付</title>
	<link rel="stylesheet" href="../css/Header.css">
	<link rel="stylesheet" type="text/css" href="../css/Nav.css">
	<style type="text/css">
		* { margin: 0; padding: 0; line-height: 1.2rem; font-family: 楷体; }

		.wrapper { margin: 0 auto; width:980px; position: relative;} 

        #header_outer { height: 140px; background: url("../images/header_bg.png") repeat-x; }

        #header {height: 140px;}

		.foot_outer { width: 55rem; height: 5rem; margin: 1.2rem auto; border: 1px solid pink; text-align: center;}

		.wrapper { margin: 0 auto; width:55rem;} 
		
		#main_outer { height: 300px; }

		img {width: 100%; height: 100%; max-width: auto; max-height: auto; }
	</style>
	<script type="text/javascript">
	function back() {
		window.location.href = "HomePage.jsp"
	}
	</script>
	
</head>
<body>
	<div id="header_outer">
        <div id="header" class="wrapper">
           	<div style="height: 20px">
	            <div style="float: left;">当前用户为： <%=uname%></div>
            </div>
	        <div id="logo" style="width: 10rem; height: 7rem">
            	<img src="../images/logo.png">
        	</div>
        </div><!--header-->
    </div> <!--header_outer-->

	<div id="nav_outer"></div>

	<div id = "main_outer">
        <div class = "wrapper" id="main" style="color: black" style="margin: 0 auto;"> 
            <%=table%>
        </div> 
    </div>

	<div class="foot_outer">
		<div>一共需要支付：<span style="color: red;">¥ <%=count%></span></div>
		<button style="width: 5rem" onclick="pay()">立即支付</button>
		<button onclick="back()" style="width: 5rem">返回</button>
		<div id="info1" style="display: none;"><%=isbn%></div>
		<div id="info2"></div>
	</div>
	<script type="text/javascript" src="../js/Pay.js"></script>
</body>
</html>