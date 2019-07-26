<%@ page language="java" import="java.util.*, java.sql.*" contentType = "text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int index = 0;
	int pgcnt = 12;
	Integer pgno = 0;
	Integer pgno_temp = 0;
	String msg = "";
	String table = "";
	String uname = "";

	String param = request.getParameter("pgno");
	if (param != null && !param.isEmpty()) pgno = Integer.parseInt(param);

	pgno_temp = (Integer)session.getAttribute("page");
	if (pgno_temp != null && pgno_temp != 0) {
		pgno = pgno_temp;
		session.setAttribute("page", 0);
	}

	param = (String)session.getAttribute("login_name");
	if (param != null && !param.isEmpty()) uname = param;

	Integer kind = 0;
	Integer temp1 = (Integer)session.getAttribute("login_kind");
    if (temp1 != null) kind = temp1;
 	
	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String temp = Integer.toString(pgno) + "~";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = String.format("select * from books where cnt>0 limit %d, %d;", pgno*pgcnt, pgcnt);
		
		if (kind==2) sql = String.format("call getbooks('%s', %d, %d);", uname, pgno*pgcnt, pgcnt);

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);

		table += temp;
		while (rs.next()) {
			table += (String.format(
				"<div style='float:left; height:15rem; width:12rem; border:1px solid red; margin:1rem 0.5rem 0 2.5rem; text-align:center;'><a href='GoodsDetail.jsp?isbn=%s&page=%d'><div><img src='%s'></img></div><div style='height:2.4rem; overflow: hidden;'>%s</div></div>", rs.getString("isbn"), pgno, rs.getString("picture"),rs.getString("bookname")
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