package com.jspiders.springmvc.controller;

import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.jspiders.springmvc.service.EmailService;

import com.jspiders.springmvc.dto.UserDTO;
import com.jspiders.springmvc.dto.WebBlogDTO;
import com.jspiders.springmvc.service.UserService;
import com.jspiders.springmvc.service.WebBlogService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private WebBlogService webBlogService;

	@Autowired
	private EmailService emailService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	protected String getLogInPage() {
		return "login";
	}

	@RequestMapping("/signup")
	protected String getSignUpPage() {
		return "signup";
	}

	@RequestMapping(value = "/users", method = RequestMethod.POST)
	protected String addUser(@RequestParam(name = "username") String userName,
			@RequestParam(name = "email") String email, @RequestParam(name = "mobile") long mobile,
			@RequestParam(name = "password") String password, @RequestParam(name = "role") String role,
			ModelMap modelMap) {

		UserDTO addedUser = userService.addUser(userName, email, mobile, role, password);

		if (addedUser != null) {
			modelMap.addAttribute("message", "User added..");
			return "login";
		} else {
			modelMap.addAttribute("message", "Something went wrong..");
			return "signup";
		}
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	protected String login(@RequestParam(name = "email") String email, @RequestParam(name = "password") String password,
			ModelMap modelMap, HttpSession httpSession) {

		UserDTO user = userService.login(email, password);
		if (user != null) {
			if (user.isBlocked()) {
				modelMap.addAttribute("message", "User is Blocked");
				return "login";
			} else {
				httpSession.setAttribute("user", user);
				httpSession.setMaxInactiveInterval(3 * 24 * 60 * 60); // 3 Days
				List<WebBlogDTO> blogs = webBlogService.findAllWebBlogs();
				modelMap.addAttribute("blogs", blogs);

				modelMap.addAttribute("user", user);
				return "home";
			}
		} else {
			modelMap.addAttribute("message", "Invalid Email or Password");
			return "login";
		}

	}

	@RequestMapping(value = "/resetpassword", method = RequestMethod.GET)
	protected String resetPassword() {
		return "resetpassword";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	protected String logout(HttpSession httpSession) {
		httpSession.invalidate();
		return "login";
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	protected String getHomePage(HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		List<WebBlogDTO> blogs = webBlogService.findAllWebBlogs();
		if (user != null) {
			modelMap.addAttribute("user", user);
			modelMap.addAttribute("blogs", blogs);
			return "home";
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	protected String getUpdatePage(HttpSession httpSession, ModelMap map) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if (user != null) {
			map.addAttribute("user", user);
			return "updateuser";
		} else {
			return "home";
		}
	}

	@RequestMapping(value = "/update-user", method = RequestMethod.POST)
	protected String updateUser(@RequestParam(name = "id") long id, @RequestParam(name = "role") String role , @RequestParam(name = "username") String username,
			@RequestParam(name = "email") String email, @RequestParam(name = "mobile") long mobile,
			@RequestParam(name = "password") String password, ModelMap modelMap) {

		UserDTO updatedUser = userService.updateUser(id,role,username, email, mobile, password);
		if (updatedUser != null) {
			modelMap.addAttribute("message", "User Updated Successfully");

		} else {
			modelMap.addAttribute("message", "Something went wrong..");
		}
		modelMap.addAttribute("user", updatedUser); 
		return "home";

	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	protected String deleteUser(HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if (user != null) {
			userService.deleteUser(user.getId());
			httpSession.invalidate();
			modelMap.addAttribute("message", "Account Deleted Successfully!");
		}
		return "login";
	}

	@RequestMapping(value = "/users", method = RequestMethod.GET)
	protected String findAllUsers(HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if (user != null) {
			List<UserDTO> users = userService.findAllUsers();
			modelMap.addAttribute("users", users);
			modelMap.addAttribute("user", user);
			return "all-users";
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/block-user", method = RequestMethod.GET)
	protected String blockOrUnblockUser(@RequestParam(name = "id") long id, HttpSession httpSession,
			ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");

		if (user != null) {
			UserDTO blockUser = userService.blockOrUnblockUser(id);

			if (blockUser != null) {
				List<UserDTO> users = userService.findAllUsers();
				modelMap.addAttribute("users", users);
			}
			return "all-users";
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/verifyemail", method = RequestMethod.GET)
	protected String getVerifyEmailPage() {

		return "verifyemail";

	}

	@RequestMapping(value = "/send-verification", method = RequestMethod.POST)
	protected String sendVerificationEmail(@RequestParam("email") String email, HttpSession session,
			ModelMap modelMap) {

			UserDTO user = userService.findUserByEmail(email);
			if (user != null) {
				// Generate a 6-digit verification code
				String verificationCode = String.format("%06d", new Random().nextInt(999999));

				// Send the verification email
				emailService.sendVerificationEmail(email, verificationCode);

				// Store the code in the session for verification later
				session.setAttribute("verificationCode", verificationCode);
				session.setAttribute("email", email);

				modelMap.addAttribute("message", "Verification code sent to your email.");
				return "verify"; // Redirect to verification page
			} else {
				modelMap.addAttribute("error", "User not found with this Email");
				modelMap.addAttribute("email", ""+email);
				return "verifyemail";
			}
		
	}

	@RequestMapping(value = "/verify-code", method = RequestMethod.POST)
	protected String verifyCode(@RequestParam("code") String code, HttpSession session, ModelMap modelMap) {
		// Retrieve stored code and email from the session
		String storedCode = (String) session.getAttribute("verificationCode");
		String email = (String) session.getAttribute("email");

		if (storedCode != null && storedCode.equals(code)) {
			session.removeAttribute("verificationCode"); // Clear verification code after successful verification
			modelMap.addAttribute("email", email);
			return "resetpassword"; // Redirect to reset password page
		} else {
			modelMap.addAttribute("error", "Invalid verification code.");
			return "verify"; // Stay on verification page if the code doesn't match
		}
	}

	@RequestMapping(value = "/reset-password", method = RequestMethod.POST)
	protected String resetPassword(@RequestParam("newPassword") String password, HttpSession session,
			ModelMap modelMap) {
		String email = (String) session.getAttribute("email");

		if (email != null) {
			UserDTO user = userService.findUserByEmail(email);
			if (user != null) {
				userService.updatePassword(user.getId(), password);
				modelMap.addAttribute("message", "Password reset successfully.");
				session.removeAttribute("email"); // Clear email after password reset
				return "login"; // Redirect to login page
			} else {
				modelMap.addAttribute("message", "User not found.");
				return "login";
			}
		} else {
			return "login"; // Redirect to login if session expired
		}
	}
}
