<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<%! String kind = ""; %>
<%
	request.setCharacterEncoding("utf-8");
	String msg = "";
	
	String uname = request.getParameter("usename");
	String pass1 = request.getParameter("pass1");
	String pass2 = request.getParameter("pass2");
	String uemail = request.getParameter("uemail");
	kind = request.getParameter("kind");

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	if(request.getMethod().equalsIgnoreCase("post")) {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		Statement stmt = con.createStatement();
		try{
			if (uname.isEmpty()) {
				msg = "用户名不能为空!";
			}
			else if (pass1.isEmpty()) {
				msg = "密码不能为空!";
			}
			else if (pass1.equals(pass2) == false) {
				msg = "密码不匹配！";
			}
			else {
				String sql = "";
				int flag = 0;
				String newpass = "";
				int shift = 3;
				for(int i=0; i<pass1.length(); i++) {
					char tp = pass1.charAt(i);
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
					String rpass = request.getParameter("rpass");
					if (rpass == null || rpass.isEmpty() || rpass.equals("root") == false) flag = 1;
					
					else {
						sql = String.format("call register_admin('%s', '%s', '%s');",uname, newpass, uemail);
					}
				}
				else if (kind.equals("用户"))
					sql = String.format("call register_user('%s', '%s', '%s');",uname, newpass, uemail);
				out.print(sql);
				if(flag>0) msg="无管理员权限！";
				else {
					ResultSet r = stmt.executeQuery(sql); 
					r.next();
					msg = r.getString("message");
				}
				stmt.close();
				con.close();
			}
		}
		catch (Exception e) {
			msg = e.getMessage();
		}
		if (msg.equals("注册成功") == false) out.print("<script type='text/javascript'>alert('"+msg+" !');</script>");

		else {
			session.setAttribute("register_name", uname); 
			session.setAttribute("password", pass1); 
			out.print("<script type='text/javascript'>alert('注册成功 !'); window.location.href='http://localhost:8080/Project/jsp/Success.jsp'</script>");
		}
	}
%>

<style>
	* { margin:0; padding:0; line-height:1.2em; font-family: 楷体; }
	.container {
		background: url("../images/header_bg.png") repeat-x;
		margin: 0 auto;
	}
	.content{ 
		font-size: 1.3rem;
		position: absolute; top: 50px; 
		margin: 0 auto;
		width:35rem;
		text-align:center;
	}
	.footer {
		height: 25.6rem;
		background: url("../images/bg.png") repeat-x;
		margin-top: -10rem; 
	}
	a { color: black; text-decoration: none; }
	a:hover { color: red; }
</style>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<title>账号注册</title>
</head>
<body>
<div class="container">
	<div class="header"></div>

	<div class="content" style="padding:0 10px 100px 10px; position:relative">
		<h1 style="text-align:center">账号注册</h1><br>
		<form action="Register.jsp" method="post">
			<div style="margin-bottom:20px">&nbsp;&nbsp;&nbsp;&nbsp;请输入账号：<input type="text" name="usename" size=20 maxlength="10"></div>
			<div style="margin-bottom:20px">&nbsp;&nbsp;&nbsp;&nbsp;请输入密码：<input type="password" name="pass1" maxlength="10" onkeyup="value=value.replace(/[^\w\/]/ig,'')" placeholder="字母与数字的组合"></div>
			<div style="margin-bottom:20px">&nbsp;&nbsp;再次输入密码：<input type="password" name="pass2" maxlength="10" onkeyup="value=value.replace(/[^\w\/]/ig,'')" placeholder="字母与数字的组合"></div>
			<div style="margin-bottom:20px">请输入邮箱地址：<input type="text" name="uemail" size=20 maxlength="50"></div>

			<input type="radio" name="kind" value="管理员" checked="checked" onclick="replace()"> 管理员
			<input type="radio" name="kind" value="用户" onclick="replace1()"> 用户
			<div style="margin-top:10px;" id="rootpass">管理员权限密码：<input type="text" name="rpass" size=20></div>
			<input type="submit" name="register" value="注册" style="position:absolute; left:200px; bottom:40px; width: 5rem;">
		</form>
		<script type="text/javascript">
		function replace() {
			document.getElementById("rootpass").style.visibility = ""
		}
		function replace1() {
			document.getElementById("rootpass").style.visibility = "hidden"
		}
		</script>
		<form action="HomePage.jsp">
			<input type="submit" name="exit" value="退出"  style="position:absolute;right:200px;bottom:40px;width: 5rem;">
		</form>
		<br>
		<button style="text-align:center; width: 10rem;"><a href="Login.jsp">已有账号，点击登录</a></button>
	</div>
	<div class="footer"></div>
</div>
</body>
</html>
