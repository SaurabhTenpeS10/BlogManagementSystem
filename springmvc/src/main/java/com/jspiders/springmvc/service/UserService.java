package com.jspiders.springmvc.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.jspiders.springmvc.dao.UserDAO;
import com.jspiders.springmvc.dto.Role;
import com.jspiders.springmvc.dto.UserDTO;
import com.jspiders.springmvc.dto.WebBlogDTO;

@Component
public class UserService {
	
	@Autowired
	private UserDAO userDAO;

	public UserDTO addUser(String userName, String email, long mobile,String role, String password) {

		if (role.equals("ADMIN")) {
			boolean flag = false;
			List<UserDTO> users = userDAO.findAllUsers();
			for (UserDTO user : users) {
				if (user.getRole().equals(Role.ADMIN)) {
					flag = true;
				}
			}
			if (flag) {
				return null;
			}

		}

		UserDTO user = new UserDTO();
		user.setUserName(userName);
		user.setEmail(email);
		user.setMobile(mobile);
		user.setPassword(password);
		if (role.equals("USER")) {
			user.setRole(Role.USER);
		} else {
			user.setRole(Role.ADMIN);
		}
		user.setBlocked(false);
		user.setWebBlogs(new ArrayList<WebBlogDTO>());

		try {
			return userDAO.addUser(user);
		} catch (Exception e) {
			e.getMessage();
			return null;
		}

	}

	public UserDTO login(String email, String password) {
		try {
			return userDAO.login(email, password);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public UserDTO updateUser(long id, String role, String username, String email, long mobile, String password) {
		
		
		try {
			return userDAO.updateUser(id,role, username, email, mobile, password);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public void deleteUser(long id) {
		userDAO.deleteUser(id);

	}

	public List<UserDTO> findAllUsers() {

		return userDAO.findAllUsers();
	}

	public UserDTO blockOrUnblockUser(long id) {
		
		 try {
			 return userDAO.blockOrUnblockUser(id);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	 public UserDTO findUserByEmail(String email) {
	        try {
	            return userDAO.findUserByEmail(email);
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }

	    public boolean updatePassword(long id, String password) {
	        try {
	            userDAO.updatePassword(id, password);
	            return true;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
}
