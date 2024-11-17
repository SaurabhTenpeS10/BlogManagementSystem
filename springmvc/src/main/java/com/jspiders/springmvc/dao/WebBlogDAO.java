package com.jspiders.springmvc.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

import com.jspiders.springmvc.dto.CommentDTO;
import com.jspiders.springmvc.dto.UserDTO;
import com.jspiders.springmvc.dto.WebBlogDTO;

@Component
public class WebBlogDAO {

	private EntityManagerFactory entityManagerFactory;
	private EntityManager entityManager;
	private EntityTransaction entityTransaction;

	public WebBlogDTO addBlog(WebBlogDTO webBlog) {
		openConnection();
		entityTransaction.begin();
		entityManager.persist(webBlog);
		entityTransaction.commit();
		closeConnection();
		return webBlog;
	}
	
	@SuppressWarnings("unchecked")
	public List<WebBlogDTO> findAllWebBlogs() {
		openConnection();
		Query query = entityManager.createQuery("select blogs from WebBlogDTO blogs");
		List<WebBlogDTO> blogs = query.getResultList();
		closeConnection();
		return blogs;
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

	public WebBlogDTO findWebBlogById(int blogId) {
		openConnection();
		WebBlogDTO blog = entityManager.find(WebBlogDTO.class, blogId);
		closeConnection();
		return blog;
	}

	
	
	public WebBlogDTO updateBlog(int blogId, String title, String content, String author) {
		openConnection();
		WebBlogDTO blog = entityManager.find(WebBlogDTO.class, blogId);
		blog.setTitle(title);
		blog.setContent(content);
		blog.setAuthor(author);
		blog.setDate(new Date(System.currentTimeMillis()));
		
		entityTransaction.begin();
		entityManager.persist(blog);
		entityTransaction.commit();
		closeConnection();
		return blog;
	}

	public List<WebBlogDTO> findMyBlogs(long userId) {
		openConnection();
		UserDTO user = entityManager.find(UserDTO.class, userId);
		List<WebBlogDTO> blogs = user.getWebBlogs();
		closeConnection();
		return blogs;
	}

	public WebBlogDTO deleteBlog(int blogId, long userId) {
		openConnection();
		WebBlogDTO blog = entityManager.find(WebBlogDTO.class, blogId);
		UserDTO user = entityManager.find(UserDTO.class, userId);
		List<WebBlogDTO> blogs  = user.getWebBlogs();
		WebBlogDTO blogToBeDeleted = null;
		for(WebBlogDTO b : blogs) {
			if(b == blog) {
				blogToBeDeleted = b;
				break;
			}
		}
		blogs.remove(blogToBeDeleted);
		user.setWebBlogs(blogs);
		
		entityTransaction.begin();
		entityManager.persist(user);
		entityManager.remove(blog);
		entityTransaction.commit();
		
		return blog;
	}

	@SuppressWarnings("unchecked")
	public List<WebBlogDTO> searchBlogs(String query) {
		openConnection();
		Query query2 = entityManager.createQuery("SELECT blogs FROM WebBlogDTO blogs WHERE blogs.title LIKE '%" + query
				+ "%' OR blogs.content LIKE '%" + query + "%' OR blogs.author LIKE '%" + query + "%'");
		List<WebBlogDTO> blogs = query2.getResultList();
		closeConnection();
		return blogs;
	}

	public WebBlogDTO addLike(int blogId) {
		openConnection();
		WebBlogDTO blog = entityManager.find(WebBlogDTO.class, blogId);
		blog.setLikes(blog.getLikes() + 1);
		entityTransaction.begin();
		entityManager.persist(blog);
		entityTransaction.commit();
		closeConnection();
		return blog;
	}

	 public CommentDTO addComment(CommentDTO comment) {
	        openConnection();
	        entityTransaction.begin();
	        entityManager.persist(comment);
	        entityTransaction.commit();
	        closeConnection();
	        return comment;
	    }

	    @SuppressWarnings("unchecked")
	    public List<CommentDTO> findCommentsByBlogId(int blogId) {
	        openConnection();
	        Query query = entityManager.createQuery("SELECT c FROM CommentDTO c WHERE c.blogId = :blogId");
	        query.setParameter("blogId", blogId);
	        List<CommentDTO> comments = query.getResultList();
	        closeConnection();
	        return comments;
	    }
}
