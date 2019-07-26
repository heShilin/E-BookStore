<%@ page language="java" import="java.util.*, java.sql.*, java.text.*" contentType = "text/html; charset=utf-8"%>
<%
    request.setCharacterEncoding("utf-8");
   
    String msg = "";
	Integer isbn = 0; 
	String uname = ""; 
	String pic_temp = "";

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date = new java.util.Date();
	String strDate = sdf.format(date);

	String param = request.getParameter("isbn");
	if (param != null && !param.isEmpty()) isbn = Integer.parseInt(param);

	param = (String)session.getAttribute("login_name");
	if (param != null && !param.isEmpty()) uname = param;

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = String.format("select * from books where isbn=%d;", isbn);

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		rs.next();
		sql = String.format("call addtoshopcar('%s', %d, '%s', '%s', %.2f, %d, '%s', '%s');" , uname, isbn, rs.getString("picture"), rs.getString("bookname"), rs.getDouble("price"), rs.getInt("kind"), rs.getString("author"), strDate);
		
		Statement stmt_buy = con.createStatement();
		ResultSet rs_buy = stmt_buy.executeQuery(sql);
		
		rs_buy.next();
		msg = rs_buy.getString("message");
		out.print(msg);
		
		rs.close();
		rs_buy.close();
		stmt.close();
		stmt_buy.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>