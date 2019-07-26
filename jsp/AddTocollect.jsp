<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=utf-8" %>
<%
	request.setCharacterEncoding("utf-8");

	Integer isbn = 0;
	String msg = "";
	String uname = (String)session.getAttribute("login_name");
	String temp = request.getParameter("isbn");
	if (temp != null && !temp.isEmpty()) isbn = Integer.parseInt(temp);

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = String.format("select * from books where isbn=%d;", isbn);
		

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
	
		rs.next();
		
		String sql_insert = String.format("call addtocollect('%s', %d, '%s', '%s', %f, '%s');", uname, isbn, rs.getString("picture"), rs.getString("bookname"), rs.getDouble("price"), rs.getString("author"));
		
		Statement stmt_insert = con.createStatement();
		ResultSet rs_insert = stmt_insert.executeQuery(sql_insert);
	
		rs_insert.next();
		msg = rs_insert.getString("message");
		out.print(msg);

		rs.close();
		rs_insert.close();
		stmt.close();
		stmt_insert.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}

%>