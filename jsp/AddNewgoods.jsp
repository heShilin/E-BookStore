<%@ page language="java" import="java.util.*, java.sql.*"  contentType="text/html; charset=utf-8" %>
<%
	request.setCharacterEncoding("utf-8");
	String uname = (String)session.getAttribute("login_name");
	if (uname == null || uname.isEmpty()) {
		out.print("<script type='text/javascript'>alert('请您先登录！'); window.location.href='http://localhost:8080/Project/jsp/Login.jsp'</script>");
	}


	int kind = 0;
	String bookname = "";
	String author = "";
	String picture = "";
	double price = 0;
	Integer cnt = 0;
	String detail = "";
	String msg = "";

	String temp = request.getParameter("banme");
	if (temp != null && !temp.isEmpty()) bookname = temp;

	temp = request.getParameter("author");
	if (temp != null && !temp.isEmpty()) author = temp;

	temp = request.getParameter("picture");
	if (temp != null && !temp.isEmpty()) picture = temp;

	temp = request.getParameter("price");
	if (temp != null && !temp.isEmpty()) price = Double.parseDouble(temp);

	temp = request.getParameter("cnt");
	if (temp != null && !temp.isEmpty()) cnt = Integer.parseInt(temp);

	temp = request.getParameter("kind");
	if (temp != null && !temp.isEmpty()) kind = Integer.parseInt(temp);

	temp = request.getParameter("detail");
	if (temp != null && !temp.isEmpty()) detail = temp;

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = String.format("call newgoods(%d, '%s', '%s', '%s', %f, %d, '%s');", kind, bookname, author, picture, price, cnt, detail);

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);

		rs.next();
		msg = rs.getString("message");
		out.print(msg);

		rs.close();
		stmt.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}

%>