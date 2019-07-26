<%@ page language="java" import="java.util.*, java.sql.*" contentType = "text/html; charset=utf-8"%>
<%!String uname = ""; Integer login_kind = 0; String querytext = ""; String table = ""; Integer tt = 0; String types = ""; %>
<%
    request.setCharacterEncoding("utf-8");
    
    tt = 0;
    table = "";
    types = "";
    uname = ""; 
    login_kind = 0;
    querytext = "";
    String msg = "";

    String temp = (String)session.getAttribute("login_name");
    if (temp != null && !temp.isEmpty()) uname = temp;

    Integer temp1 = (Integer)session.getAttribute("login_kind");
    if (temp1 != null) login_kind = temp1;

    temp = request.getParameter("querytext");
    if (temp != null && !temp.isEmpty()){
        tt = 1;
        querytext = temp;
    }
    else tt = 0;

    types = request.getParameter("types");

    Class.forName("com.mysql.jdbc.Driver");
    String connectString = "jdbc:mysql://172.18.93.162:3306/bookstore?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    Connection con=DriverManager.getConnection(connectString, "root", "root");
    Statement stmt=con.createStatement();
    try{
         String sql = "";
        if (types.equals("bname")) sql = "select * from books where bookname like '%" + querytext + "%';";
        else sql = "select * from books where author like '%" + querytext + "%';";

        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()) {
            table += (String.format(
                "<div style='float:left; height:20rem; width:17rem; border:1px solid red; margin:1rem 0.5rem 0 2.5rem; text-align:center;'><a href='GoodsDetail.jsp?isbn=%s'><div><img src='%s'></img></div><div style='height:2.4rem; overflow: hidden;'>%s</div></a></div>", 
                rs.getString("isbn"), rs.getString("picture"),rs.getString("bookname")
                )
            );
        }

        stmt.close();
        con.close();
    }
    catch (Exception e) {
        msg = e.getMessage();
    }
%>

<!DOCTYPE HTML>
<html>
<head>
    <link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<title>E+书店</title>
	<meta content="text/html;charset=utf-8">
	<link rel="stylesheet" href="../css/Header.css">
	<link rel="stylesheet" type="text/css" href="../css/Nav.css">
	<style>
        * { margin:0; padding:0; font-family:楷体; line-height:1.2em; }

        a:link, a:visited, a:hover, a:active { text-decoration: none; color: black; }

        .wrapper { margin: 0 auto; width:980px; position: relative;} 

        #header_outer { height: 140px; background: url("../images/header_bg.png") repeat-x; }

		/*#cnsearchbotton { background: url(../images/cnsearchbotton.png) repeat-x; }*/

        #header {height: 140px;}

        #name { float: left; vertical-align: middle;}

		#login { float: right; font-size: 1rem;}

		#login a:hover { color: red; }

		a { color: black; }

        #main {border: 1px solid blue;}

        #footer { margin:20px auto; text-align: center; }

        #searchbox { position: absolute; left: 300px; bottom: 10px; width: 350px; height: 40px; }

        img { width: 100%; height: 100%; max-width: auto; max-height: auto; }
        
        span{ display:none; }

    </style>  
    
    <script type="text/javascript" src="../js/BackCount.js"></script>
    
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
                    else if (login_kind == 2) out.print("| <a href='Collect.jsp'>收藏栏</a> | <a href='ShopCar.jsp'>查看购物车</a> | <a href='PayHistory.jsp'>查看购买历史</a>");
                    else out.print("");
                    
                    if (uname.isEmpty()) 
                        out.print("| <a href='Login.jsp'>登录</a> | <a href='Register.jsp'>注册</a> |");
                    else 
                        out.print(" | <a href='Reset.jsp'>修改密码</a> | <a onclick='back()'>退出</a> |");
                %>
            </div>
	        <div id="logo" style="width: 10rem; height: 7rem">
            	<img src="../images/logo.png">
        	</div>
	        
            <form action="HomePage.jsp">
                <div id="searchbox">
                    <input name="querytext" type="text" id="search" placeholder="超惠购书，满100减50" value="<%=querytext%>">
                    <button><input type="submit" id="cnsearchbotton" name="sbtn" value="搜索"></button>
                    <input type="radio" name="types" value="bname" id="bname">书名
                    <input type="radio" name="types" value="author" id="author">作者
                </div>
            </form>
        </div><!--header-->
    </div> <!--header_outer-->

    <div id="nav_outer">
        <ul class="wrapper" id="nav">
            <li><a href="HomePage.jsp" class="nav_hover">网站首页</a></li>
            <li><a href="Category.jsp?kind=1">少儿读物</a></li>
            <li><a href="Category.jsp?kind=2">青春文学</a></li>
            <li><a href="Category.jsp?kind=3">科技</a></li>
            <li><a href="Category.jsp?kind=4">历史</a></li>
            <li><a href="Category.jsp?kind=5">管理</a></li>
            <li><a href="Category.jsp?kind=6">成功励志</a></li>
        </ul>
    </div>

    <div id = "main_outer">
        <div id="ty1" style="display: none;"><%=tt%></div>
        <div id="ty2" style="display: none;"><%=types%></div>
        <div id="ty3" style="display: none;"><%=table%></div>
        <div class = "wrapper" id = "main" style="color: black"> 
            <div id="recommend"></div>
            <div id = "goods"></div>
            <div id = "goods_query"></div>
        </div> <!--main wrapper-->
    </div> <!--main_outer-->
    <div id = "foot_outer" style="clear: left;">
        <br>
        <div class="wrapper" id="footer">
            <button onclick="sub()" style="display: inline;"> 上一页</button>
            <div id="pageNum" style="display: inline;"></div>
            <button onclick="add()" style="display: inline;"> 下一页</button>
        </div>
    </div>
    <script type="text/javascript" src="../js/GoodsList.js"></script>
</body>