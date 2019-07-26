<%@ page language="java" import="java.util.*, java.sql.*, java.text.*" contentType="text/html; charset=utf-8" %>
<%
	request.setCharacterEncoding("utf-8");

	Integer cnt = 0;
	String msg = "";
	Integer isbn = 0;
	String uname ="";
	String date_buy = "";

	String temp = request.getParameter("uname");
	if (temp != null && !temp.isEmpty()) uname = temp;

	temp = request.getParameter("isbn");
	if (temp != null && !temp.isEmpty()) isbn = Integer.parseInt(temp);

	temp = request.getParameter("cnt");
	if (temp != null && !temp.isEmpty()) cnt = Integer.parseInt(temp);

	temp = request.getParameter("date");
	if (temp != null && !temp.isEmpty()) date_buy = temp;

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date = new java.util.Date();
	String strDate = sdf.format(date);

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		Statement stmt = con.createStatement();
		Statement stmt_new = con.createStatement();

		String sql = String.format("select * from purchaseorder where username='%s' and date_buy='%s';", uname, date_buy);
		ResultSet rs = stmt.executeQuery(sql);
		
		rs.next();

		String pic = rs.getString("picture");
		String bname = rs.getString("bname");
		double price = rs.getDouble("price");
		int k = rs.getInt("kind");
		String author = rs.getString("author");
		String sql_new = String.format("call deliver('%s', %d, '%s', '%s', %f, %d, '%s', %d,'%s','%s');", uname, isbn, pic, bname, price, k, author, cnt, strDate, date_buy);
		
		ResultSet rs_new = stmt.executeQuery(sql_new);
		
		rs_new.next();
		msg = rs_new.getString("message");
		out.print(msg);

		rs.close();
		rs_new.close();
		stmt.close();
		stmt_new.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}

%>