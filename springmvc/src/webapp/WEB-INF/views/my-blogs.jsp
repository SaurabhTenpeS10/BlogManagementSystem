<%@page import="com.jspiders.springmvc.dto.Role"%>
<%@page import="com.jspiders.springmvc.dto.UserDTO"%>
<%@page import="com.jspiders.springmvc.dto.WebBlogDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Blogs</title>
<link rel="stylesheet" href="css/blogStyles.css">

<style type="text/css">

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}

nav {
	display: flex;
	justify-content: center;
	background-color: #fff;
	padding: 15px 0;
	align-item: center;
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


/* Container styling */
.container {
	max-width: 1000px;
	margin: 0 auto;
	padding: 20px;
}

/* General styles */
h1 {
	text-align: center;
	margin-bottom: 20px;
	color: #333;
}

p {
	text-align: center;
	color: #555;
}

/* Blog card styling */
.blog-list {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

.blog-card {
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s ease;
}

.blog-card:hover {
	transform: scale(1.02);
}

.blog-card h2 {
	margin-bottom: 10px;
	color: #333;
	font-size: 1.5em;
}

.blog-card .meta {
	margin-bottom: 15px;
	font-size: 0.9em;
	color: #777;
}

.blog-card p {
	font-size: 1em;
	line-height: 1.6;
	color: #555;
}

.blog-card a {
	display: inline-block;
	margin-top: 10px;
	padding: 10px 15px;
	background-color: #5cb85c;
	color: white;
	border-radius: 5px;
	text-decoration: none;
	font-size: 0.9em;
	margin-right: 10px;
}

.blog-card a.update-btn {
	background-color: #5bc0de;
}

.blog-card a.delete-btn {
	background-color: #d9534f;
}

.blog-card a:hover {
	background-color: #4cae4c;
}

.blog-card a.update-btn:hover {
	background-color: #46b8da;
}

.blog-card a.delete-btn:hover {
	background-color: #c9302c;
}
</style>

</head>
<body>
<% UserDTO user1 = (UserDTO) request.getAttribute("user"); %>
	<section>
		<nav>
			<a href="./home" id="home">Home</a> <a href="./update" id="edit">Update
				Profile</a>
			<%
			if (user1.getRole().equals(Role.ADMIN)) {
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
		<h1>My Blogs</h1>

		<%
		@SuppressWarnings("unchecked")
		List<WebBlogDTO> blogs = (List<WebBlogDTO>) request.getAttribute("blogs");
		UserDTO user = (UserDTO) request.getAttribute("user");
		if (blogs != null && !blogs.isEmpty()) {
		%>
		<div class="blog-list">
			<%
			for (WebBlogDTO blog : blogs) {
			%>
			<div class="blog-card">
				<h2><%=blog.getTitle()%></h2>
				<div class="meta">
					<span>Published on <%=blog.getDate()%></span>
				</div>
				<p>
					<%=blog.getContent().length() > 150 ? blog.getContent().substring(0, 150) + "..." : blog.getContent()%>
				</p>
				<a href="read-blog?id=<%=blog.getId()%>">Read More</a> 
				<a	href="update-blog-page?id=<%=blog.getId()%>" class="update-btn">Update</a>
				<a href="delete-blog?blogId=<%=blog.getId()%>&userId=<%=user.getId()%>" class="delete-btn">Delete</a>
			</div>
			<%
			}
			%>
		</div>
		<%
		} else {
		%>
		<p>
			No blogs found! <a href="add-blog">Create a new blog</a>
		</p>
		<%
		}
		%>

		<!-- Display success or error messages -->
		<%
		String message = (String) request.getAttribute("message");
		if (message != null) {
		%>
		<h3><%=message%></h3>
		<%
		}
		%>
	</div>
</body>
</html>