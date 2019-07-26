<%@ page language="java" import="java.util.*, java.sql.*" contentType = "text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	
	int pgcnt = 12;
	Integer kind = 0;
	Integer pageno = 0;
	Integer page_temp = 0;
	String msg = "";
	String table = "";

	String param = request.getParameter("pageNum");
	if (param != null && !param.isEmpty()) pageno = Integer.parseInt(param);

	param = request.getParameter("kind");
	if (param != null && !param.isEmpty()) kind = Integer.parseInt(param);

	page_temp = (Integer)session.getAttribute("pageNum");
	if (page_temp != null && page_temp != 0) {
		pageno = page_temp;
		session.setAttribute("pageNum", 0);
	}
	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String temp = Integer.toString(pageno) + "~";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = String.format("select * from books where kind=%d and cnt>0 limit %d, %d", kind, pageno*pgcnt, pgcnt);

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);

		table += temp;
		while (rs.next()) {
			table += (String.format(
				"<div style='float:left; height:15rem; width:12rem; border:1px solid red; margin:1rem 0.5rem 0 2.5rem; text-align:center;'><a href='GoodsDetail.jsp?isbn=%d&page=%d&kind=%d'><div><img src='%s'></img></div><div style='height:2.4rem; overflow: hidden;'>%s</div></div>", rs.getInt("isbn"), pageno, kind, rs.getString("picture"),rs.getString("bookname")
				)
			);
		}
		out.print(table);
		rs.close();
		stmt.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>