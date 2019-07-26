<%@ page language="java" import="java.util.*, java.sql.*, java.text.*" contentType = "text/html; charset=utf-8"%>
<%!Integer isbn = 0; String picAdd = ""; String bname = ""; String bauthor = ""; double bprice = 0; String binfo = ""; Integer bcount = 0; String uname = ""; %>
<%
    request.setCharacterEncoding("utf-8");
    
    Integer kind = 0;
    Integer login_kind = 0;
    Integer page_set = 0;
	String msg = "";
	String msg_q = "";
	uname = "";

	String param = request.getParameter("isbn");
	if (param != null && !param.isEmpty()) isbn = Integer.parseInt(param);

	param = (String)session.getAttribute("login_name");
	if (param !=null && !param.isEmpty()) uname = param;

	param = request.getParameter("kind");
	if (param != null && !param.isEmpty()) kind = Integer.parseInt(param);

	param = request.getParameter("page");
	if (param != null && !param.isEmpty()) page_set = Integer.parseInt(param);

	if (kind == 0) session.setAttribute("page", page_set);
	else session.setAttribute("pageNum", page_set);

	Integer temp = (Integer)session.getAttribute("login_kind");
	if (temp != null) login_kind = temp;

	String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "root");
		String sql = String.format("select * from books where isbn=%d;", isbn);

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			picAdd = rs.getString("picture");
			bname = rs.getString("bookname");
			bauthor = rs.getString("author");
			bprice = rs.getDouble("price");
			bcount = rs.getInt("cnt");
			binfo = rs.getString("info");
		}
		String sql_q = String.format("call isFavorite('%s', %d)", uname, isbn);
		Statement stmt_q = con.createStatement();
		ResultSet rs_q = stmt_q.executeQuery(sql_q);
		rs_q.next();
		msg_q = rs_q.getString("message");

		stmt.close();
		rs.close();
		con.close();
	}
	catch (Exception e) {
		msg = e.getMessage();
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>商品详情页</title>
	<link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<meta content="text/html;charset=utf-8">
	<link rel="stylesheet" href="../css/Header.css">
	<link rel="stylesheet" type="text/css" href="../css/Nav.css">
	<style type="text/css">
		* { margin:0; padding:0; font-family:楷体;}

		.wrapper { margin: 0 auto; width:980px; position: relative;} 

        #header_outer { height: 140px; background: url("../images/header_bg.png") repeat-x; }

        #header {height: 140px;}

        #name { float: left; vertical-align: middle;}

		#login { float: right; font-size: 1rem;}

		#login a:hover { color: red; }

		a { color: black; }
		
		.Detail_Page { height: 25rem; width: 55rem; border: 1px solid red; position: relative;top: 2rem; margin: 0 auto; }
		
		.goods { height: 20rem; width: 55rem; border: 1px solid red; position: relative; margin: 0 auto; }
		
		.goodsName { font-size:1rem; }
		
		.goodsPri { color: red;}
		
		.coleft { float: left; height: 20rem; width: 18rem; border: 1px solid green; }
		
		.colright { line-height:1.5rem; }
		
		.Bttn { margin: 2rem auto; border: 1px solid black; text-align: center; }
		
		a { text-decoration: none; color: black; } 
		
		a:hover { color: red; }

		button:hover { color: red; }
		
		.detail { font-size: 0.9rem; text-align:justify;}
		
		img { width: 100%; height: 100%; max-width: auto; max-height: auto; }
	</style>
	<script type="text/javascript" src="../js/AddToShopcar.js"></script>
	<script type="text/javascript" src="../js/AddGoods.js"></script>
	<script type="text/javascript" src="../js/RemoveGoods.js"></script>
</head>
<body>
	<div id="header_outer">
        <div id="header" class="wrapper">
            <%
                if (uname.isEmpty())  out.print("<p id='name'>请您登录</p> ");
                else out.print("<p id='name'>"+uname+"，欢迎回来！</p> ");
            %>
            <div id="login">
                <%
                    if (login_kind == 1) 
                        out.print("| <a href='ViewOrder.jsp'>查看订单</a> | <a href='DeliverHistory.jsp'>查看发货历史</a> | <a href='NewGoods.jsp'>新增商品</a>");
                    else if (login_kind == 2) out.print("| <a href='Collect.jsp'>收藏夹</a> | <a href='ShopCar.jsp'>查看购物车</a> | <a href='PayHistory.jsp'>查看购买历史</a>");
                    else out.print("");
                    
                    if (uname.isEmpty()) 
                        out.print("| <a href='Login.jsp'>登录 | </a>&nbsp<a href='Register.jsp'>注册</a>");
                    else 
                        out.print(" | <a href='Reset.jsp'>修改密码</a> | <a onclick='back()'>退出</a> |");
                %>
            </div>
	        <div id="logo" style="width: 10rem; height: 7rem">
            	<img src="../images/logo.png">
        	</div>
        </div><!--header-->
    </div> <!--header_outer-->

	<div id="nav_outer"></div>
	<div  id="main_outer">
		<div class="Detail_Page">
			<div class="goods">
				<div class="coleft"><img src="<%=picAdd%>"></div>
				<div class="colright">
					<div class="goodsName">书名： <%=bname%></div>
					<div class="author">作者： <%=bauthor%> </div>
					<div class="goodsPri">价格： ¥ <%=bprice%> 库存： <%=bcount%> </div> 
					<div class="detail">简介： <%=binfo%> </div>
				</div>
			</div>
			<div class="Bttn">
				<div id="user_name" style="display: none;"><%=uname%></div>
				<div id="info" style="display: none;"><%=isbn%></div>
				<%
					if (login_kind == 1) {
						String ssy = String.format("<button><a href='ModifyInfo.jsp?isbn=%d'>修改商品信息</a></button>    <button onclick='addGoods()'>补货</button>   <button onclick='removeGoods()'>下架</button>   ", isbn);
						out.print(ssy);
					}
					else {
						String ssy = "";
						if (msg_q.equals("存在")) {
							ssy = String.format("<button><a href='ShopCar.jsp'>查看购物车</a></button>   <button onclick='addToshopcar()'>加入购物车</button>   <button>已收藏</button>", isbn);
						}
						else {
							ssy = String.format("<button><a href='ShopCar.jsp'>查看购物车</a></button>   <button onclick='addToshopcar()'>加入购物车</button>   <button onclick='addTocollect(%d)' id='favorite'>收藏</button>", isbn);
						}
						
						out.print(ssy);
					}
					if (kind == 0) {
						out.print("    <button><a href='HomePage.jsp'>返回</a></button>");
					}
					else {
						String sy = String.format("     <button><a href='Category.jsp?kind=%d'>返回</a></button>", kind);
						out.print(sy);
					}
				%>
				<!-- <div id="info1" style="display: none;"></div> -->
				<!-- <div id="info1"></div> -->
				<script type="text/javascript" src="../js/AddToCollect.js"></script>
			</div>
		</div>
	</div>
</body>
</html>