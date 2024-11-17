<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password</title>
<style type="text/css">
    /* CSS styles (same as before) */
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

    input[type="text"], input[type="email"], input[type="password"] {
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

    /* Error message style */
    .error {
        color: red;
        font-size: 14px;
        margin-top: 5px;
        text-align: center;
    }
</style>
<script>
    function validatePasswords() {
        const newPassword = document.getElementById("newPassword").value;
        const confirmPassword = document.getElementById("confirmPassword").value;
        const errorMessage = document.getElementById("error-message");

        if (newPassword !== confirmPassword) {
            errorMessage.textContent = "Passwords do not match.";
            return false; // Prevent form submission
        } else {
            errorMessage.textContent = ""; // Clear error message
            return true; // Allow form submission
        }
    }
</script>
</head>
<body>
<% String email = (String) request.getAttribute("email"); %>
<div class="container" id="loginContainer">
    <div class="form-container">
        <h2>Reset Password</h2>
        <form action="./reset-password" method="post" onsubmit="return validatePasswords()">
            <input type="email" name="email" placeholder="Email" value="<%= email%>" readonly="readonly">
            <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required>
            <span id="error-message" class="error"></span>
            <button type="submit">Reset Password</button>
            <p><a href="./login">Login</a></p>
            <p>Don't have an account? <a href="./signup">Sign up here</a></p>
        </form>
    </div>
</div>
</body>
</html>
