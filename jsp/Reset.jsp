<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String msg = "";
	String uname = "";
	String temp = (String)session.getAttribute("login_name");
	if (temp != null && !temp.isEmpty()) {
		uname = temp;
	}
	else { 
		out.print("<script type='text/javascript'>alert('请您先登录！'); window.location.href='http://localhost:8080/Project/jsp/Login.jsp'</script>");
	}

	String opass = request.getParameter("opass");
	String pass1 = request.getParameter("npass1");
	String pass2 = request.getParameter("npass2");
	Integer kind = (Integer)session.getAttribute("login_kind");

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	if(request.getMethod().equalsIgnoreCase("post")) {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		Statement stmt = con.createStatement();
		try{
			if (opass.isEmpty()) {
				msg = "原密码不能为空!";
			}
			else if (pass1.isEmpty()) {
				msg = "新密码不能为空!";
			}
			else if (pass1.equals(pass2) == false) {
				msg = "新密码不匹配！";
			}
			else {
				String sql = "";
				String newpass = "";
				int shift = 3;
				for(int i=0; i<pass1.length(); i++) {
					char tp = pass1.charAt(i);
					if ('a' <= tp && tp <= 'z') {
						char t = (char)((tp-'a' + shift)%26 + 'a');
						newpass += t;
					}
					else if ('A' <= tp && tp <= 'Z') {
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
				if (kind==1)
					sql = String.format("call reset_admin('%s', '%s');",uname, newpass);
				else
					sql = String.format("call reset_user('%s', '%s');",uname, newpass);
				
				ResultSet r = stmt.executeQuery(sql); 
				r.next();
				msg = r.getString("message");
				
				stmt.close();
				con.close();
			}
		}
		catch (Exception e) {
			msg = e.getMessage();
		}
		if (msg.equals("修改成功") == false) out.print("<script type='text/javascript'>alert('"+msg+" !');</script>");
		else out.print("<script type='text/javascript'>alert('修改成功 !'); window.location.href='http://localhost:8080/Project/jsp/HomePage.jsp'</script>");
	}
%>

<style>
	* { margin:0; padding:0; line-height:1.2em }
	.container {
		background: url("../images/header_bg.png") repeat-x;
		margin: 0 auto;
	}
	.content{
		position: absolute; top: 10rem; 
		margin: 0 auto;
		width:35rem;
		text-align:center;
	}
	.footer {
		height: 26.5rem;
		background: url("../images/bg.png") repeat-x;
		margin-top: 0rem; 
	}
	#comf:hover{ color: red; }
	#ex:hover{ color: red; }
</style>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<title>修改密码</title>
</head>
<body>
<div class="container">
	<div class="header"></div>

	<div class="content" style="padding:0 10px 100px 10px; position:relative">
		<h1 style="text-align:center">修改密码</h1><br>
		<form action="Reset.jsp" method="post">
			<div style="margin-bottom:20px">&nbsp;&nbsp;&nbsp;请输入原密码：<input type="password" name="opass"  maxlength="10" onkeyup="value=value.replace(/[^\w\/]/ig,'')" placeholder="字母与数字的组合"></div>
			<div style="margin-bottom:20px">&nbsp;&nbsp;&nbsp;请输入新密码：<input type="password" name="npass1" maxlength="10" onkeyup="value=value.replace(/[^\w\/]/ig,'')" placeholder="字母与数字的组合"></div>
			<div style="margin-bottom:20px">再次输入新密码：<input type="password" name="npass2" maxlength="10" onkeyup="value=value.replace(/[^\w\/]/ig,'')" placeholder="字母与数字的组合"></div>
			<input type="submit" name="reset" value="确认" style="position:absolute; left:200px; bottom:40px; width: 5rem;" id="comf">
		</form>

		<form action="HomePage.jsp">
			<input type="submit" name="exit" value="退出"  style="position:absolute;right:200px;bottom:40px;width: 5rem;" id="ex">
		</form>

	</div>
	<div class="footer"></div>
</div>
</body>
</html>
