<%@page import="com.jspiders.springmvc.dto.Role"%>
<%@page import="java.util.List"%>
<%@page import="com.jspiders.springmvc.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	color: #333;
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


div {
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin: auto;
	margin-top: 30px;
	max-width: 800px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #007BFF;
	color: white;
}

tr:hover {
	background-color: #f1f1f1;
}

a {
	color: #007BFF;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

.action-button {
	color: #ff4d4d; /* red color for BLOCK action */
	font-weight: bold;
}
</style>
</head>
<body>

	<%
	UserDTO user1 = (UserDTO) request.getAttribute("user"); %>
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
	
	<%
	@SuppressWarnings("unchecked")
	List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
	%>
	<div align="center">
		<table>
			<tr>
				<th>ID</th>
				<th>NAME</th>
				<th>EMAIL</th>
				<th>MOBILE</th>
				<th>ROLE</th>
				<th>ACTION</th>
			</tr>
			<%
			for (UserDTO user : users) {
				if (user.getRole().equals(Role.USER)) {
			%>
			<tr>
				<td><%=user.getId()%></td>
				<td><%=user.getUserName()%></td>
				<td><%=user.getEmail()%></td>
				<td><%=user.getMobile()%></td>
				<td><%=user.getRole()%></td>
				<%
				if (user.isBlocked()) {
				%>
				<td><a href="block-user?id=<%=user.getId()%>">UNBLOCK</a></td>
				<%
				} else {
				%>
				<td><a href="block-user?id=<%=user.getId()%>">BLOCK</a></td>
				<%
				}
				%>
			</tr>
			<%
			} else {
			%>
			<tr style="color: red;">
				<td><%=user.getId()%></td>
				<td><%=user.getUserName()%></td>
				<td><%=user.getEmail()%></td>
				<td><%=user.getMobile()%></td>
				<td><%=user.getRole()%></td>
				<td>YOU</td>
			</tr>
			<%
			}
			}
			%>
		</table>
		<!--   <a class="home-link" href="home">HOME</a> -->
	</div>
</body>
</html>