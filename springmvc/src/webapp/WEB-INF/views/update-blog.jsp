<%@page import="com.jspiders.springmvc.dto.Role"%>
<%@page import="com.jspiders.springmvc.dto.UserDTO"%>
<%@page import="com.jspiders.springmvc.dto.WebBlogDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Blog</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	padding: 20px;
	margin: 0;
}

nav {
	display: flex;
	justify-content: center;
	background-color: #fff;
	padding: 15px 0;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

nav a {
	width: 120px;
	padding: 12px;
	margin: 0 10px;
	background-color: #3e8e41;
	border: none;
	color: white;
	border-radius: 5px;
	text-align: center;
	text-decoration: none;
	transition: background-color 0.3s;
	font-weight: bold;
}

nav a:hover {
	background-color: #367a3b; /* Darker green */
}

.container {
	width: 100%;
	max-width: 600px;
	margin: 0 auto;
	background-color: white;
	padding: 20px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
	color: #555;
}

.form-group input[type="text"], .form-group textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 16px;
	box-sizing: border-box;
}

.form-group textarea {
	height: 150px;
	resize: vertical;
}

.form-group input[type="text"]:focus, .form-group textarea:focus {
	border-color: #6200ea;
	outline: none;
}

.btn {
	display: block;
	width: 100%;
	padding: 12px;
	background-color: #6200ea;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 18px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn:hover {
	background-color: #45009d;
}

.form-group small {
	font-size: 12px;
	color: #999;
}
</style>
</head>
<body>
	<%
	WebBlogDTO blog = (WebBlogDTO) request.getAttribute("blog");
	%>
	
	<% UserDTO user = (UserDTO) request.getAttribute("user"); %>
	<section>
		<nav>
			<a href="./home" id="home">Home</a> <a href="./update" id="edit">Update
				Profile</a>
			<%
			if (user.getRole().equals(Role.ADMIN)) {
			%>
			<a href="./blogs">All Blogs</a> <a href="users">All Users</a>
			<%
			} else {
			%>
			<a href="./add-blog-page">Add Blog</a> <a href="./my-blogs">My
				Blogs</a> <a href="./blogs">All Blogs</a>
			<%
			}
			%>
			<a href="./logout">Logout</a> <a href="./delete">Delete Account</a>
		</nav>
	</section>
	
	<div class="container">
		<h2>Update Blog</h2>
		<form action="./update-blog" method="POST">
			<div class="form-group">
				<label for="title">Blog Id</label> <input type="text" id="title"
					name="id" value="<%=blog.getId()%>" readonly="readonly">
			</div>
			<!-- Title -->
			<div class="form-group">
				<label for="title">Blog Title</label> <input type="text" id="title"
					name="title" required value="<%=blog.getTitle()%>">
			</div>

			<!-- Content -->
			<div class="form-group">
				<label for="content">Content</label>
				<textarea id="content" name="content" required
					value="<%=blog.getContent()%>"></textarea>
			</div>

			<!-- Author -->
			<div class="form-group">
				<label for="author">Author</label> <input type="text" id="author"
					name="author" required value="<%=blog.getAuthor()%>">

			</div>

			<!-- Add Blog Button -->
			<button type="submit" class="btn">Update Blog</button>
		</form>
	</div>

</body>
</html>
