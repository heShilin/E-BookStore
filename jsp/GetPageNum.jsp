<%@ page language="java" import="java.util.*, java.sql.*" contentType = "text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	Integer pgno = 0;
	Integer pgno_temp = 0;

	String param = request.getParameter("pgno");
	if (param != null && !param.isEmpty()) pgno = Integer.parseInt(param);

	pgno_temp = (Integer)session.getAttribute("page");
	if (pgno_temp != null && pgno_temp != 0) {
		pgno = pgno_temp;
		session.setAttribute("page", 0);
	}

	try {
		out.print(pgno);
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>