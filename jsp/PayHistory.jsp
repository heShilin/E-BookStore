<%@page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=utf-8"%>
<%!String table = ""; int count=0;%>
<%
	request.setCharacterEncoding("utf-8");
	String uname = "";
	String msg = "";
	Integer pageno = 0;
	Integer pagecnt = 4;

	String param = request.getParameter("pageno");
    if(param != null && !param.isEmpty()){
        pageno = Integer.parseInt(param);
    }
    int pgprev = (pageno>0)?pageno-1:0;
    int pgnext = pageno+1;
    int pageno_max = (pageno+1)*pagecnt;
    if (pageno_max <= count) pgnext=pgnext-1;

	String temp = (String)session.getAttribute("login_name");
	if (temp != null && !temp.isEmpty()) {
		uname = temp;
	}
	else { 
		out.print("<script type='text/javascript'>alert('请您先登录！'); window.location.href='http://localhost:8080/Project/jsp/Login.jsp'</script>");
	}

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");

		Statement stmt = con.createStatement();
		ResultSet allrs = stmt.executeQuery("select * from payhistory where username='%s'");
		allrs.last();
		count = allrs.getRow();	//获取总记录数
		
		String sql = String.format("select * from payhistory where username='%s' limit %d, %d;", uname, pageno*pagecnt, pagecnt);
		ResultSet rs = stmt.executeQuery(sql);
		table = "";
		while (rs.next()) {
			table += String.format(
				"<div style='height:7rem; width:45rem; border:1px solid black; margin-bottom:1rem;'><a href='GoodsDetail.jsp?isbn=%d'><div style='float:left;border-right:1px solid green;height:7rem;width:7rem'><img src='%s'></img></div></a><div style='float:rigtht; height:7rem; overflow: hidden;'><div style='height:1.3rem;border-bottom:1px solid blue;overflow: hidden;' id='bname'>购买时间： %s</div><div style='height:1.3rem;border-bottom:1px solid blue;overflow: hidden;' id='bname'>书名： %s</div><div style='height:1.3rem;border-bottom:1px solid green;overflow: hidden;' id='bauthor'>作者： %s</div><div style='height:1.3rem;border-bottom:1px solid yellow' id='price'>价格： %.2f</div><div style='height:1.3rem;float:left' id='cnt'>数量： %d</div></div></div>", rs.getInt("isbn"), rs.getString("picture"), rs.getString("date_buy"), rs.getString("bname"), rs.getString("author"), rs.getDouble("price"),rs.getInt("count")
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
	<title>查看购买历史</title>
	<link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<link rel="stylesheet" href="../css/Header.css">
	<link rel="stylesheet" type="text/css" href="../css/Nav.css">
	<style type="text/css">
		* { margin:0; padding:0; font-size:12px; font-family:kaiti; line-height:1.2em }
		
		.pic { float: left; width: 15rem; height: 5rem;}
		
		#tip { float: right; }
		#tip:hover { color: red; }

		.header_outer { height: 120px; background: url("../images/header_bg.png") repeat-x; }
		
		.header { width: 45rem; height: 120px; margin: 0 auto;}
		
		.logo { float: left; margin-top: 10px; }

		.wrapper { margin: 0 auto; width:45rem; } 

		img { width: auto; height: auto; width: 100%; height: 100%; }

		.goodsList { width: 45rem; margin: 0 auto; border: 1px solid red; }

		a { text-decoration: none; color: black; }

		* { font-size: 1rem; }
	</style>
	<script type="text/javascript">
		function Back() {
			window.location.href="../jsp/HomePage.jsp"
		}
	</script>
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
	<div id="info" style="display: none;"></div>
	<div style="text-align: center; border: 1px solid black; <%=count<=0?"visibility:hidden;":""%>">
        <button><a href="PayHistory.jsp?pageno=<%=pgprev%>">上一页</a></button>
    	<%=pageno+1%>
        <button><a href="PayHistory.jsp?pageno=<%=pgnext%>">下一页</a></button>
    </div>
  
</body>
</html>