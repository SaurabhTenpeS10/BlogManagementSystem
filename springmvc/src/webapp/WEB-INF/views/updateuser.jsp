<%@page import="com.jspiders.springmvc.dto.Role"%>
<%@page import="com.jspiders.springmvc.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Account</title>
<link rel="stylesheet" href="styles.css">
<style type="text/css">
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Arial', sans-serif;
}

body {
	background-color: #f0f2f5;
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 100vh;
}

nav {
	width: 100%;
	display: flex;
	justify-content: center;
	background-color: #fff;
	padding: 15px 0;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	position: fixed;
	top: 0;
	z-index: 1000;
}

nav a {
	width: 120px;
	padding: 10px;
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
	background-color: #367a3b;
}

.container {
	width: 500px;
	padding: 30px;
	background-color: white;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	margin-top: 110px; /* Space for the fixed navbar */
}

.form-container h2 {
	text-align: center;
	margin-bottom: 20px;
	color: #333;
}

input[type="text"], input[type="email"], input[type="password"], input[type="number"] {
	width: 100%;
	padding: 12px;
	margin: 10px 0;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #f9f9f9;
}

button {
	width: 100%;
	padding: 12px;
	margin-top: 10px;
	background-color: #5cb85c;
	border: none;
	color: white;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

button:hover {
	background-color: #4cae4c;
}

p {
	text-align: center;
	margin-top: 15px;
}

a {
	color: #5cb85c;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<% UserDTO user = (UserDTO) request.getAttribute("user"); %>
	
	<nav>
		<a href="./home" id="home">Home</a>
		<a href="./update" id="edit">Update Profile</a>
		<% if (user.getRole().equals(Role.ADMIN)) { %>
			<a href="./blogs">All Blogs</a>
			<a href="users">All Users</a>
		<% } else { %>
			<a href="./add-blog-page">Add Blog</a>
			<a href="./my-blogs">My Blogs</a>
			<a href="./blogs">All Blogs</a>
		<% } %>
		<a href="./logout">Logout</a>
		<a href="./delete">Delete Account</a>
	</nav>
	
	<section>
		<div class="container" id="signUpContainer">
			<div class="form-container">
				<h2>Update Profile Details</h2>
				<form action="./update-user" method="post">
					<input type="text" name="id" placeholder="Id" value="<%= user.getId() %>" readonly>
					<input type="text" name="role" placeholder="Role" value="<%= user.getRole() %>" readonly>
					<input type="text" name="username" placeholder="Username" value="<%= user.getUserName() %>" required>
					<input type="email" name="email" placeholder="Email" value="<%= user.getEmail() %>" required>
					<input type="number" name="mobile" placeholder="Mobile" value="<%= user.getMobile() %>" required>
					<input type="password" name="password" placeholder="Password" value="<%= user.getPassword() %>" required>
					<button type="submit">Update</button>
				</form>
			</div>
		</div>
	</section>
</body>
</html>
