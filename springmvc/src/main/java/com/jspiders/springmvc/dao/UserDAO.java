package com.jspiders.springmvc.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.springframework.stereotype.Component;

import com.jspiders.springmvc.dto.Role;
import com.jspiders.springmvc.dto.UserDTO;
import com.jspiders.springmvc.dto.WebBlogDTO;

@Component
public class UserDAO {

	private EntityManagerFactory entityManagerFactory;
	private EntityManager entityManager;
	private EntityTransaction entityTransaction;

	public UserDTO addUser(UserDTO user) {
		openConnection();
		entityTransaction.begin();
		entityManager.persist(user);
		entityTransaction.commit();
		closeConnection();
		return user;
	}

	public UserDTO login(String email, String password) {
		openConnection();
		Query query = entityManager
				.createQuery("SELECT user from UserDTO user WHERE user.email = ?1 AND user.password = ?2");
		query.setParameter(1, email);
		query.setParameter(2, password);
		UserDTO user = (UserDTO) query.getSingleResult();
		closeConnection();
		return user;
	}

	public UserDTO updateUser(long id, String role, String username, String email, long mobile, String password) {
		openConnection();
		UserDTO user = entityManager.find(UserDTO.class, id);
		user.setUserName(username);
		if (role.equals("USER")) {
			user.setRole(Role.USER);
		} else {
			user.setRole(Role.ADMIN);
		}
		user.setEmail(email);
		user.setMobile(mobile);
		user.setPassword(password);

		entityTransaction.begin();
		entityManager.persist(user);
		entityTransaction.commit();
		closeConnection();
		return user;

	}

	@SuppressWarnings("unchecked")
	public List<UserDTO> findAllUsers() {
		openConnection();

		Query query = entityManager.createQuery("select users from UserDTO users");
		List<UserDTO> users = query.getResultList();
		closeConnection();

		return users;
	}

	public void deleteUser(long id) {
		openConnection();
		UserDTO user = entityManager.find(UserDTO.class, id);
		entityTransaction.begin();
		entityManager.remove(user);
		entityTransaction.commit();
		closeConnection();

	}

	public void mapBlogToUser(int blogId, long userId) {

		openConnection();
		UserDTO user = entityManager.find(UserDTO.class, userId);
		WebBlogDTO blog = entityManager.find(WebBlogDTO.class, blogId);

		List<WebBlogDTO> blogs = user.getWebBlogs();
		blogs.add(blog);

		entityTransaction.begin();
		entityManager.persist(user);
		entityTransaction.commit();
		closeConnection();

	}

	private void openConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		entityManagerFactory = Persistence.createEntityManagerFactory("springmvc");
		entityManager = entityManagerFactory.createEntityManager();
		entityTransaction = entityManager.getTransaction();
	}

	private void closeConnection() {
		if (entityManagerFactory != null) {
			entityManagerFactory.close();
		}
		if (entityManager != null) {
			entityManager.close();
		}
		if (entityTransaction != null) {
			if (entityTransaction.isActive()) {
				entityTransaction.rollback();
			}
		}
	}

	public UserDTO blockOrUnblockUser(long id) {
		openConnection();
		UserDTO user = entityManager.find(UserDTO.class, id);
		if(user.isBlocked()) {
			user.setBlocked(false); // Unblock User
		} else {
			user.setBlocked(true); // Block User 
		}
		entityTransaction.begin();
		entityManager.persist(user);
		entityTransaction.commit();
		closeConnection();
		return user;
	}
	
	public UserDTO findUserByEmail(String email) {
        openConnection();
        Query query = entityManager.createQuery("SELECT user FROM UserDTO user WHERE user.email = :email");
        query.setParameter("email", email);
        
        UserDTO user = null;
        try {
            user = (UserDTO) query.getSingleResult();
        } catch (NoResultException e) {
            System.out.println("No user found with email: " + email);
        } finally {
            closeConnection();
        }
        return user;
    }

    public void updatePassword(long id, String password) {
        openConnection();
        UserDTO user = entityManager.find(UserDTO.class, id);
        if (user != null) {
            user.setPassword(password);
            entityTransaction.begin();
            entityManager.persist(user);
            entityTransaction.commit();
        }
        closeConnection();
    }
}
