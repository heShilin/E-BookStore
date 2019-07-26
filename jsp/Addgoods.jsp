<%@ page language="java" import="java.util.*, java.sql.*, java.text.*" contentType = "text/html; charset=utf-8"%>
<%

    request.setCharacterEncoding("utf-8");
    
    String isbn = ""; 
	String msg = "";

	String param = request.getParameter("isbn");
	if (param != null && !param.isEmpty()) isbn = param;

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = "update books set cnt=cnt+1 where isbn="+isbn+";";
		Statement stmt = con.createStatement();
		int rs = stmt.executeUpdate(sql);
		
		stmt.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>