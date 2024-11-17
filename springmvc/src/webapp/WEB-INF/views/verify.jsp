<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Email Verification</title>
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
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .container {
        width: 400px;
        padding: 30px;
        background-color: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    .form-container h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #333;
    }

    input[type="text"], input[type="email"] {
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
    .msg{
	color: red;
	padding-top: 10px;
	text-align: center;
}
</style>
</head>
<body>
    <div class="container" id="verifyEmailContainer">
        <div class="form-container">
           <h2>Email Verification</h2>
    
    <!-- Form to verify the code entered by the user -->
    <form action="./verify-code" method="post">
        <input type="text" name="code" placeholder="Enter Verification Code" required><br><br>
        <button type="submit">Verify</button>
    	
                <p><a href="./login">Login</a></p>
                <p>Don't have an account? <a href="./signup">Sign up here</a></p>
            </form>
        </div>
         <%
		String error = (String) request.getAttribute("error");
		if (error != null) {
		%>
		<h3 class="msg"><%=error%></h3>
		<%
		}
		%>
    </div>
</body>
</html>
