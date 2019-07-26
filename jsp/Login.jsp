<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String username = request.getParameter("username");
	String pass = request.getParameter("password");
	String kind = request.getParameter("kind");
	String msg = "";
	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	
	if(request.getMethod().equalsIgnoreCase("post")) {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection(connectString, "root", "root");
		Statement stmt=con.createStatement();
		try{
			if (username.isEmpty()) {
				msg = "用户名不能为空";
			}
			else if (pass.isEmpty()) {
				msg = "密码不能为空";
			}
			else {
				String sql = "";
				int shift = 3;
				//String pass1 = pass.toLowerCase();
				String newpass = "";
				for(int i=0; i<pass.length(); i++) {
					char tp = pass.charAt(i);
					if ('a' <= tp && tp <= 'z') {
						char t = (char)((tp-'a' + shift)%26 + 'a');
						newpass += t;
					}
					if ('A' <= tp && tp <= 'Z') {
						char t = (char)((tp-'A' + shift)%26 + 'A');
						newpass += t;
					}
					else {
						char t = '!';
						if(tp-'0' >= 6) t = (char)('!'+(tp-'0')+1);
						else t = (char)('!'+(tp-'0'));
						newpass += t;
					}
				}
				if (kind.equals("管理员")) {
					sql = String.format("call login_admin('%s', '%s');", username, newpass);
					session.setAttribute("login_kind", 1);
				}
				else {
					sql = String.format("call login_user('%s', '%s');", username, newpass);
					session.setAttribute("login_kind", 2);
				}
				ResultSet rs = stmt.executeQuery(sql);
				rs.next();
				msg = rs.getString("message");
				rs.close();
			}
			stmt.close();
			con.close();
		}
		catch (Exception e) {
			msg = e.getMessage();
		}
		out.print("<script type='text/javascript'> alert('"+msg+"'); </script>");
		String text = "登录成功";
		
		if (msg.equals("登录成功") == true) {
			session.setAttribute("login_name", username);
			response.sendRedirect("HomePage.jsp");
		}
	}
%>


<!DOCTYPE HTML>
<html>
<head>
	<link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<title>账号登录</title>
	<style>
		* { margin:0; padding:0; line-height:1.2em; font-family: 楷体; }

		.container {
			background: url("../images/header_bg.png") repeat-x;
			margin: 0 auto;
		}
		.content{
			position: absolute; top: 5rem;
			margin: 0 auto;
			width:33rem;
			text-align:center;
			font-size: 1.3rem 
		}
		.footer {
			height: 23.5rem;
			background: url("../images/bg.png") repeat-x;
			margin-top: -0.5rem
		}
		a { color: black; text-decoration: none; }
		a:hover { color: red; }
	</style>
</head>
<body>
<div class="container">
	<div class="header"></div>

	<div class="content" style="padding:0 10px 100px 10px; position:relative; text-align:center;">
		<h1 style="text-align:center;">账号登录</h1><br>

		<form action="Login.jsp" method="post">
			<div style="margin-bottom:20px">账号：<input type="text" name="username" size=20 maxlength="10"></div>
			<div style="margin-bottom:20px">密码：<input type="password" name="password" size=20 maxlength="10"></div>
			<input type="radio" name="kind" value="管理员" checked="checked"> 管理员
			<input type="radio" name="kind" value="用户"> 用户
			<input type="submit" name="login" value="登录" style="position:absolute;left:200px;bottom:40px; width: 4rem;">
		</form>
		
		<form action="HomePage.jsp">
			<input type="submit" name="exit" value="退出"  style="position:absolute;right:200px;bottom:40px; width: 4rem;">
		</form>
		<br>
		
		<button style="text-align:center; width: 10rem;"><a href="Register.jsp">没有账号，点击注册</a></button>
	</div>

	<div class="footer"></div>
</div>
</body>
</html>
