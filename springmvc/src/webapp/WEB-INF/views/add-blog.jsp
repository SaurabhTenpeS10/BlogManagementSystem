<%@page import="com.jspiders.springmvc.dto.Role"%>
<%@page import="com.jspiders.springmvc.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Blog</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	margin: 0;
}

nav {
	display: flex;
	justify-content: center;
	background-color: #fff;
	padding: 15px 0;
	margin-bottom: 20px;
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

.form-group input[type="text"], .form-group textarea, .form-group select
	{
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

.form-group input[type="text"]:focus, .form-group textarea:focus,
	.form-group select:focus {
	border-color: #6200ea;
	outline: none;
}

.btn {
	display: block;
	width: 100%;
	padding: 12px;
	background-color: #5cb85c;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 18px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn:hover {
	background-color: #5cb85c;
}

.form-group small {
	font-size: 12px;
	color: #999;
}

#custom-category-container {
	display: none;
}
</style>
</head>

<body>
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
		<h2>Add a New Blog</h2>

		<form action="./add-blog" method="POST"
			onsubmit="return setFinalCategory()">
			<!-- Title -->
			<div class="form-group">
				<label for="title">Blog Title</label> <input type="text" id="title"
					name="title" required placeholder="Enter the blog title">
			</div>

			<!-- Content -->
			<div class="form-group">
				<label for="content">Content</label>
				<textarea id="content" name="content" required
					placeholder="Write your blog content here"></textarea>
			</div>

			<!-- Author -->
			<div class="form-group">
				<label for="author">Author</label> <input type="text" id="author"
					name="author" required placeholder="Author's name"> <small>By
					default, this field will be pre-filled with your logged-in username
					(if applicable).</small>
			</div>

			<!-- Category Selection -->
			<div class="form-group">
				<label for="category">Category:</label> <select name="category"
					id="category" required onchange="toggleCustomCategoryInput(this)">
					<option value="" disabled selected>Select a category</option>
					<option value="Technology">Technology</option>
					<option value="Lifestyle">Lifestyle</option>
					<option value="Travel">Travel</option>
					<option value="Education">Education</option>
					<option value="Health">Health</option>
					<option value="Business">Business</option>
					<option value="Food">Food</option>
					<option value=" ">Random</option>
				</select>

				<!-- Input field for custom category -->
				<div id="custom-category-container" style="display: none;">
					<input type="text" id="customCategory" name="customCategory"
						placeholder="Enter custom category"
						oninput="updateFinalCategory()">
				</div>
			</div>

			<!-- Hidden Input Field to Store Final Category -->
			<input type="hidden" id="finalCategory" name="finalCategory">

			<!-- Add Blog Button -->
			<button type="submit" class="btn">Add Blog</button>
		</form>
	</div>

	<script>
		function toggleCustomCategoryInput(select) {
			const customCategoryContainer = document
					.getElementById('custom-category-container');
			const customCategoryInput = document
					.getElementById('customCategory');

			if (select.value === 'custom') {
				customCategoryContainer.style.display = 'block'; // Show the custom category input
				customCategoryInput.required = true; // Make custom category input required
			} else {
				customCategoryContainer.style.display = 'none'; // Hide the custom category input
				customCategoryInput.required = false; // Remove required attribute
				document.getElementById('finalCategory').value = select.value; // Set the selected category value
			}
		}

		function updateFinalCategory() {
			const customCategoryInput = document
					.getElementById('customCategory').value.trim();
			const finalCategoryInput = document.getElementById('finalCategory');

			// Update the hidden field with the custom category input
			finalCategoryInput.value = customCategoryInput;
		}

		function setFinalCategory() {
			const categorySelect = document.getElementById('category');
			const customCategoryInput = document
					.getElementById('customCategory').value.trim();
			const finalCategoryInput = document.getElementById('finalCategory');

			// If "Add Custom Category" is selected and the user has input a custom category, use that value
			if (categorySelect.value === 'custom' && customCategoryInput !== "") {
				finalCategoryInput.value = customCategoryInput;
			} else {
				// Use the selected category from the dropdown
				finalCategoryInput.value = categorySelect.value;
			}

			// Validate that a category value is set
			if (finalCategoryInput.value === ""
					|| finalCategoryInput.value === "custom") {
				alert("Please select a category or enter a custom category.");
				return false; // Prevent form submission
			}

			return true; // Allow form submission
		}
	</script>

</body>

</html>
