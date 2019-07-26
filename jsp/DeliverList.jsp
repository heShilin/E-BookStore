<%@page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uname = "";
	String msg = "";
	Integer pageNum = 0;
	Integer pgcnt = 5;
	String table = "";
	boolean flage = true;

	String temp = (String)session.getAttribute("login_name");
	if (temp != null && !temp.isEmpty()) {
		uname = temp;
	}
	else { 
		out.print("<script type='text/javascript'>alert('请您先登录！'); window.location.href='http://localhost:8080/Project/jsp/Login.jsp'</script>");
	}

	temp = request.getParameter("pageNum");
	if (temp != null && !temp.isEmpty()) pageNum = Integer.parseInt(temp);

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = String.format("select * from deliverhistory limit %d, %d;", pageNum*pgcnt, pgcnt);

		Statement stmt = con.createStatement();

		ResultSet allrs = stmt.executeQuery("select * from deliverhistory");
		allrs.last();
		Integer count=allrs.getRow();	//获取总记录数

		ResultSet rs = stmt.executeQuery(sql);
		
		table += Integer.toString(count) + "~";
		while (rs.next()) {
			table += String.format(
				"<div style='height:7rem; width:45rem; border:1px solid black; margin-bottom:1rem;'><a href='GoodsDetail.jsp?isbn=%d'><div style='float:left;border-right:1px solid green;height:7rem;width:7rem'><img src='%s'></img></div></a><div style='float:rigtht; height:7rem; overflow: hidden;'><div style='height:1.3rem;border-bottom:1px solid blue;overflow: hidden;' id='date'>下单人：%s   |   发货时间： %s</div><div style='height:1.3rem;border-bottom:1px solid blue;overflow: hidden;' id='bname'>书名： %s</div><div style='height:1.3rem;border-bottom:1px solid green;overflow: hidden;' id='bauthor'>作者： %s</div><div style='height:1.3rem;border-bottom:1px solid yellow' id='price'>价格： %.2f</div><div style='height:1.3rem;float:left' id='cnt'>数量： %d</div></div></div>", rs.getInt("isbn"), rs.getString("picture"), rs.getString("username"), rs.getString("date_buy"), rs.getString("bname"), rs.getString("author"), rs.getDouble("price"),rs.getInt("count")
				);
		}

		rs.close();
		allrs.close();
		stmt.close();
		con.close();

		out.print(table);
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>