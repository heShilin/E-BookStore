<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%> 
<% 
    request.setCharacterEncoding("utf-8"); 
    String uname = (String)session.getAttribute("register_name"); 
    String pass =  (String)session.getAttribute("password"); 
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>用户ID</title> 
    <link rel="icon" href="../images/book.ico" type="image/x-ico"/>
    <link rel="stylesheet" href="../css/Header.css">
    <link rel="stylesheet" type="text/css" href="../css/Nav.css">
    <style> 

        a:link,a:visited { color:blue; text-decoration:none; }

		a:hover { text-decoration:none; color: red; }

        .container{ margin:0 auto; width:500px; text-align:center; border: solid red 1px; padding:40px; }  

        * {margin: 0; padding: 0; font-family: 楷体; }

        .header_outer { height: 120px; background: url("../images/header_bg.png") repeat-x; }
        
        .header { width: 45rem; height: 120px; margin: 0 auto;}
        
        .logo { float: left; margin-top: 10px; }
        
        .wrapper { margin: 0 auto; width:45rem; } 

        img { width: auto; height: auto; width: 100%; height: 100%; } 
    </style> 
</head>
<body> 
    <div class="header_outer">
        <div class="header">
            <div class="logo" style="width: 10rem; height: 7rem">
                <img src="../images/logo.png">
            </div>
        </div>
    </div>
    <div id="nav_outer"></div>
    <div id = "main_outer">
        <div class = "wrapper" id="main" style="color: black" style="margin: 0 auto;"> 
            <div class="container">
                <h1>用户ID</h1>
                <div>注册成功，这是您的登录账号：</div>
                <p>账号：<%=uname%></p>
                <p>密码：<%=pass%></p>
                <button><a href='Login.jsp'>返回</a></button>
            </div>
        </div> 
    </div> 
</body> 
</html>

