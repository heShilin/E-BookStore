<%@ page language="java" import="java.util.*, java.sql.*, java.text.*" contentType = "text/html; charset=utf-8"%>
<%
	Integer isbn = 0; String isbn_s = "";
	String bname = ""; 
	String bauthor = ""; 
	double bprice = 0; String bprice_s = "";
	String binfo = ""; 
	Integer bcount = 0; String bcount_s = "";

    request.setCharacterEncoding("utf-8");
    
   
	String msg = "";

	String param = request.getParameter("isbn");
	if (param != null && !param.isEmpty()) isbn_s = param;

	param = request.getParameter("bname");
	if (param != null && !param.isEmpty()) bname = param;

	param = request.getParameter("bauthor");
	if (param != null && !param.isEmpty()) bauthor = param;

	param = request.getParameter("bprice");
	if (param != null && !param.isEmpty()) bprice_s = param;

	param = request.getParameter("bcount");
	if (param != null && !param.isEmpty()) bcount_s = param;

	param = request.getParameter("bdetail");
	if (param != null && !param.isEmpty()) binfo = param;


	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	//out.print(isbn);out.print(bname);out.print(bauthor);out.print(bprice);out.print(bcount);out.print(binfo);

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		
		String sql = "call modifygoods("+isbn_s+", '"+bname+"', '"+bauthor+"', "+bprice_s+", "+bcount_s+", '"+binfo+"');";
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		rs.next();
		msg = rs.getString("message");
		out.print(msg);

		stmt.close();
		rs.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>