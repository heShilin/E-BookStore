<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*, java.util.*,java.sql.*,org.apache.commons.io.*" %> 
<%@ page import="org.apache.commons.fileupload.*" %> 
<%@ page import="org.apache.commons.fileupload.disk.*" %> 
<%@ page import="org.apache.commons.fileupload.servlet.*" %> 
<%! String path = new String(); String fname = new String(); String uname=""; %>
<%
	request.setCharacterEncoding("utf-8");
	String msg = "";
	String uname = "";
	String temp = (String)session.getAttribute("login_name");
	if (temp != null && !temp.isEmpty()) {
		uname = temp;
	}
	else { 
		out.print("<script type='text/javascript'>alert('请您先登录！'); window.location.href='http://localhost:8080/Project/jsp/Login.jsp'</script>");
	}

	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	path = "../data/class_new/none.png";
	fname = "";
    //检查表单中是否包含文件 
    if (isMultipart) { 
        FileItemFactory factory = new DiskFileItemFactory(); 
        ServletFileUpload upload = new ServletFileUpload(factory); 
        List items = upload.parseRequest(request); 
        for (int i = 0; i < items.size(); i++) { 
            FileItem fi = (FileItem) items.get(i);
            if (fi.isFormField()) {//如果是表单字段 
                
            } 
            else {//如果是文件
                DiskFileItem dfi = (DiskFileItem) fi; 
                if (!dfi.getName().trim().equals("")) {
                    //out.print("文件被上传到服务上的实际位置："); 
                    
                    String fileName = application.getRealPath("/data/class_new") 
                                    + System.getProperty("file.separator") 
                                    + FilenameUtils.getName(dfi.getName()); 
                    //out.println(new File(fileName).getAbsolutePath());
                    dfi.write(new File(fileName)); 
                    fname = FilenameUtils.getName(dfi.getName());
                    path = "../data/class_new/" + FilenameUtils.getName(dfi.getName());
                }
            }
        }
    }
	
%>

<!DOCTYPE HTML>
<html>
<head>
	<link rel="icon" href="../images/book.ico" type="image/x-ico"/>
	<link rel="stylesheet" href="../css/Header.css">
	<style>
		* { margin:0; padding:0; line-height:1.2em; font-family:楷体; }

		.header_outer { height: 120px; background: url("../images/header_bg.png") repeat-x; }
		
		.header { width: 45rem; height: 120px; margin: 0 auto;}
		
		.logo { float: left; margin-top: 10px; }
		
		#tip { float: right; }
		#tip:hover { color: red; }

		#nav_outer { height:30px; position:relative; background-image:url(../images/nav_bg.jpg); background-repeat:repeat-x; }

		.container { background: url("../images/header_bg.png") repeat-x; margin: 0 auto; }
		
		.content{ position: absolute; top: 10px; margin: 0 auto; width:40rem; text-align: center; }
		
		.colsl { width: 20rem; height: 14rem; border: 1px solid red; float: left; text-align: center; }
		
		.colsr { width: 19.5rem; height: 14rem; border: 1px solid blue;float: right; text-align: left; }
		
		button:hover { color: red; }
		
		img { width: 100%; height: 100%; max-width: auto; max-height: auto; }

		a { text-decoration: none; color: black; }
		
		a:hover { color: red; }
	</style>

	<title>新增商品</title>
	<script type="text/javascript">
		function Back() {
			window.location.href = "HomePage.jsp"
		}
	</script>
</head>
<body>
<div class="container">
	<div class="header_outer">
		<div class="header">
			<div style="height: 20px">
	            <div style="float: left;">当前管理员为： <%=uname%></div>
            </div>
			<div class="logo" style="width: 10rem; height: 7rem">
            	<img src="../images/logo.png">
        	</div>
		</div>
	</div>
	<div id="nav_outer"></div>

	<div class="content" style="padding:0 10px; position:relative;">
		<h1 style="text-align:center">新增商品</h1><br>

		<form action="NewGoods.jsp" method="post" enctype="multipart/form-data">
			<div class="colsl">
				<div style="height: 10rem; width: 10rem; margin: 0 auto;"><img src="<%=path%>"></div>
				<div style="margin-top: 0.5rem">
		            <p>当前图片：<%=fname%><p>
		            <span><input type="file" name="file" size=30 value="<%=fname%>"></span>
		            <span><input type="submit" name="submit" value="确定"></span>
				</div>
			</div>
		</form>

		<div class="colsr">
			<div style="margin-bottom:20px; margin-left: 10px">书名：<input type="text" id="bname" size=30></div>
			<div style="margin-bottom:20px; margin-left: 10px">作者：<input type="text" id="bauthor" size=30></div>
			<div style="margin-bottom:20px; margin-left: 10px">价格：¥ <input type="text" id="price" size=20></div>
			<div style="margin-bottom:20px; margin-left: 10px">库存：<input type="text" id="count" size=20></div>
			<div style="margin-bottom:20px; margin-left: 10px">
				类型：	<select id="kind">
							<option value="少儿读物">少儿读物</option>
							<option value="青春文学">青春文学</option>
							<option value="科技">科技</option>
							<option value="历史">历史</option>
							<option value="管理">管理</option>
							<option value="成功励志">成功励志</option>			
						</select>
			</div>
			<div id="picture" style="display: none;"><%=path%></div>
		</div>
		<div class="bottom">
			<div style="margin-bottom:20px; margin-left: 10px">简介：<textarea id="detail" rows="12" cols="72" style="vertical-align: top;"></textarea></div>
		</div>
		<button style="width: 5rem" onclick="addNewGoods()">确定</button> <button style="width: 5rem;"><a href="HomePage.jsp">返回</a></button>
	</div>
	<script type="text/javascript" src="../js/AddNewGoods.js"></script>
	<div class="footer">
		<div id="info1" style="display: none;"></div>
	</div>
</div>
</body>
</html>
