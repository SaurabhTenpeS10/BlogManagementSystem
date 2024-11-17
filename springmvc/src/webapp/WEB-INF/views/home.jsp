<%@page import="com.jspiders.springmvc.dto.WebBlogDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.jspiders.springmvc.dto.Role"%>
<%@page import="com.jspiders.springmvc.dto.UserDTO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BlogVerse</title>
<style>
/* General Styling */
body {
	font-family: 'Arial', sans-serif;
	background-color: #f7f9fc;
	margin: 0;
	padding: 0;
	color: #333;
}

header {
	background-color: #3e8e41;
	color: white;
	padding: 20px;
	text-align: center;
}

#logo {
	width: 120px;
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
	background-color: #367a3b;
}

.hero {
	background: url('logo.png') no-repeat center center;
	background-size: cover;
	color: black;
	padding: 60px 20px;
	text-align: center;
}

.hero h1 {
	font-size: 3em;
	margin: 0;
}

.hero p {
	font-size: 1.2em;
	margin-top: 10px;
	max-width: 800px;
	margin: 0 auto;
}

.content {
	max-width: 1200px;
	margin: 20px auto;
	padding: 20px;
}

.blog-preview {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: space-evenly;
}

.blog-card {
	background-color: #ffffff;
	border-radius: 8px;
	padding: 20px;
	width: 100%;
	max-width: 30%;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	min-height: 200px;
}

.blog-card:hover {
	transform: translateY(-5px);
}

.blog-card h3 {
	color: #3e8e41;
	margin-bottom: 10px;
}

.blog-card p {
	color: #666;
	font-size: 0.95em;
	line-height: 1.6;
	flex-grow: 1;
	margin-bottom: 15px;
}

.blog-card a {
	align-self: flex-start;
	padding: 10px 15px;
	background-color: #3e8e41;
	color: white;
	text-decoration: none;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.blog-card a:hover {
	background-color: #367a3b;
}
.mission-section {
	background-color: #ffffff;
	padding: 40px 20px;
	text-align: center;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.mission-section h2 {
	color: #3e8e41;
	font-size: 2em;
}

.mission-section p {
	font-size: 1.1em;
	color: #555;
	max-width: 800px;
	margin: 0 auto;
}


.view-all-blogs {
	text-align: center;
	margin-top: 110px;
	
	
}

.view-all-blogs a {
	display: inline-block;
	padding: 10px 20px;
	background-color: #3e8e41;
	color: white;
	text-decoration: none;
	border-radius: 5px;
	font-size: 1.1em;
	transition: background-color 0.3s;
}

.view-all-blogs a:hover {
	background-color: #367a3b;
}

/* Responsive adjustments */
@media (max-width: 768px) {
	.blog-card {
		width: 45%;
	}
}

@media (max-width: 480px) {
	.blog-card {
		width: 100%;
	}
}

footer {
	text-align: center;
	padding: 20px;
	background-color: #333;
	color: white;
}

footer .social-links a {
	margin: 0 10px;
	color: white;
	text-decoration: none;
}

footer p {
	margin: 5px;
}
</style>
</head>

<body>

	<%
	UserDTO user = (UserDTO) request.getAttribute("user");
	List<WebBlogDTO> blogs = (List<WebBlogDTO>) request.getAttribute("blogs");
	%>

	<header>

		<h1>Welcome to BlogVerse</h1>
	</header>

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

	<div class="hero">
		<h1>Explore, Write, Share!</h1>
		<p>Your journey in blogging starts here. Dive into the world of
			creativity, share your stories, and connect with a vibrant community
			of readers and writers.</p>
	</div>

	<section class="content">
		<h2>Recent Blogs</h2>
		<!-- Blog Preview Section -->
		<div class="blog-preview">
			<!-- Fetch and display recent blog posts -->
			<%
			if (blogs != null && !blogs.isEmpty()) {
				int blogCount = 0;
				for (WebBlogDTO blog : blogs) {
					if (blogCount >= 10) {
				break;
					}
			%>
			<div class="blog-card">
				<h3><%=blog.getTitle()%></h3>
				<p><%=blog.getContent().length() > 150 ? blog.getContent().substring(0, 150) + "..." : blog.getContent()%></p>
				<a href="read-blog?id=<%=blog.getId()%>">Read More</a>
			</div>
			<%
			blogCount++;
			}
			%>
			<div class="view-all-blogs">
				<a href="./blogs">View All Blogs</a>
			</div>
			<%
			} else {
			%>
			<p>No blogs found yet.</p>
			<%
			}
			%>
		</div>
	</section>


	<!-- Our Mission Section -->
	<section class="mission-section">
		<h2>Our Mission</h2>
		<p>We aim to provide a platform for bloggers to express their
			creativity, share insights, and connect with readers. Whether you're
			here to write or to read, our goal is to build a community that
			thrives on knowledge sharing.</p>
	</section>

	<!-- Why This Site Section -->
	<section class="mission-section">
		<h2>Why This Site?</h2>
		<p>Our blog platform offers a unique combination of simplicity and
			functionality. It’s designed for both casual writers and
			professionals to create beautiful, engaging blogs with ease. Your
			voice matters, and we provide the tools to amplify it.</p>
	</section>

	<footer>
		<p>&copy; 2024 BlogVerse. All rights reserved.</p>
		<div class="social-links">
			<a href="https://www.facebook.com" target="_blank">Facebook</a> <a
				href="https://www.twitter.com" target="_blank">Twitter</a> <a
				href="https://www.linkedin.com" target="_blank">LinkedIn</a>
		</div>
	</footer>

</body>
</html>
