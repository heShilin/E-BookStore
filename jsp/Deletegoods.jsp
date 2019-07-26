<%@page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	Integer isbn = 0;
	String msg = "";
	String uname = "";

	String temp = request.getParameter("isbn");
	if (temp != null && !temp.isEmpty()) isbn = Integer.parseInt(temp);

	temp = (String)session.getAttribute("login_name");
	if (temp != null && !temp.isEmpty()) uname = temp; 
	
	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = String.format("call deleteGoods('%s', %d);", uname, isbn);

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next()) {
			msg = rs.getString("message");
			out.print(msg);
		}
		rs.close();
		stmt.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
	
%>