package com.jspiders.springmvc.service;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.jspiders.springmvc.dao.UserDAO;
import com.jspiders.springmvc.dao.WebBlogDAO;
import com.jspiders.springmvc.dto.CommentDTO;
import com.jspiders.springmvc.dto.UserDTO;
import com.jspiders.springmvc.dto.WebBlogDTO;

@Component
public class WebBlogService {

	@Autowired
	private WebBlogDAO webBlogDAO;

	@Autowired
	private UserDAO userDAO;

	public WebBlogDTO addBlog(String title, String content, String author, String category ,UserDTO user, HttpSession httpSession) {
		WebBlogDTO webBlog = new WebBlogDTO();
		webBlog.setTitle(title);
		webBlog.setContent(content);
		webBlog.setCategory(category);
		webBlog.setAuthor(author);
		webBlog.setDate(new Date(System.currentTimeMillis()));
		webBlog.setUserId(user.getId());
		try {
			WebBlogDTO blog = webBlogDAO.addBlog(webBlog);
			userDAO.mapBlogToUser(blog.getId(), user.getId());
			return blog;
		} catch (Exception e) {
			return null;
		}
	}

	public List<WebBlogDTO> findAllWebBlogs() {
		List<WebBlogDTO> blogs = webBlogDAO.findAllWebBlogs();
		if (blogs.size() > 0) {
			return blogs;
		} else {
			return null;
		}
	}
	
	public WebBlogDTO findWebBlogById(int blogId) {
		WebBlogDTO blog = webBlogDAO.findWebBlogById(blogId);
		if (blog != null)
			return blog;
		else
			return null;
	}
	
	public WebBlogDTO findWebBlog(int blogId) {

		try {
			WebBlogDTO blog = webBlogDAO.findWebBlogById(blogId);
			return blog;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	public WebBlogDTO updateBlog(int id, String title, String content, String author) {

		try {
			WebBlogDTO blog = webBlogDAO.updateBlog(id, title, content, author);
			return blog;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
//
//	public List<WebBlogDTO> findMyBlogs(HttpSession httpSession, ModelMap modelMap) {
//		UserDTO user = (UserDTO) httpSession.getAttribute("user");
//		if (user != null) {
//			List<WebBlogDTO> blogs = user.getWebBlogs();
//			return blogs;
//		}
//		return null;
//	}

	public WebBlogDTO deleteBlog(int blogId, long userId) {
		try {
			return webBlogDAO.deleteBlog(blogId, userId);
		} catch (Exception e) {
			return null;
		}

	}

	public List<WebBlogDTO> findMyBlogs(long userId) {
		List<WebBlogDTO> blogs = webBlogDAO.findMyBlogs(userId);
		if (blogs.size() > 0) {
			return blogs;
		} else {
			return null;
		}
	}

	public List<WebBlogDTO> sortBlogs(int index) {
		List<WebBlogDTO> blogs = webBlogDAO.findAllWebBlogs();
		Collections.sort(blogs);
		if (index == 1) {
			Collections.reverse(blogs);
			return blogs;
		} else {
			return blogs;
		}
	}

	public List<WebBlogDTO> searchBlogs(String query) {
		List<WebBlogDTO> blogs = webBlogDAO.searchBlogs(query);
		if (blogs.size() > 0) {
			return blogs;
		} else
			return null;
	}

	public WebBlogDTO addLike(int blogId) {
		WebBlogDTO blog = webBlogDAO.addLike(blogId);
		return blog;
	}

	 public CommentDTO addComment(int blogId, String content, String author) {
	        CommentDTO comment = new CommentDTO();
	        comment.setContent(content);
	        comment.setAuthor(author);
	        comment.setDate(new Date());
	        comment.setBlogId(blogId);

	        return webBlogDAO.addComment(comment);
	    }

	    public List<CommentDTO> findCommentsByBlogId(int blogId) {
	        return webBlogDAO.findCommentsByBlogId(blogId);
	    }
	

}