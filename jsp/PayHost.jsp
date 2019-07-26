<%@ page language="java" import="java.util.*, java.sql.*, java.text.*" contentType="text/html; charset=utf-8" %>
<%
	request.setCharacterEncoding("utf-8");

	String msg = "";
	String uname = "";
	String temp = (String)session.getAttribute("login_name");
	if (temp != null && !temp.isEmpty()) uname = temp;

	Integer isbn = 0;
	String temp_isbn = request.getParameter("isbn");
	if (temp_isbn != null && !temp_isbn.isEmpty()) isbn = Integer.parseInt(temp_isbn);

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date = new java.util.Date();
	String strDate = sdf.format(date);

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		
		String sql = String.format("select * from shopcar where username='%s' and isbn=%d;", uname, isbn);
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		rs.next();
		sql = String.format("call payGoods('%s', %d, '%s', '%s', %.2f, %d, '%s', %d, '%s');", uname, isbn, rs.getString("picture"), rs.getString("bname"), rs.getDouble("price"), rs.getInt("kind"), rs.getString("author"), rs.getInt("count"), strDate);
		
		ResultSet rs_new = stmt.executeQuery(sql);

		rs_new.next();
		msg = rs_new.getString("message");
		out.print(msg);
		
		rs.close();
		rs_new.close();
		stmt.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>