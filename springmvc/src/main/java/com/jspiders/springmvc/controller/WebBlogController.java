package com.jspiders.springmvc.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jspiders.springmvc.dto.CommentDTO;
import com.jspiders.springmvc.dto.Role;
import com.jspiders.springmvc.dto.UserDTO;
import com.jspiders.springmvc.dto.WebBlogDTO;
import com.jspiders.springmvc.service.UserService;
import com.jspiders.springmvc.service.WebBlogService;

@Controller
public class WebBlogController {

	@Autowired
	private WebBlogService webBlogService;

	@RequestMapping(value = "/add-blog-page", method = RequestMethod.GET)
	protected String getAddBlogPage(HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		modelMap.addAttribute("user", user);
		return "add-blog";
	}
	

	@RequestMapping(value = "/add-blog", method = RequestMethod.POST)
	protected String addBlog(@RequestParam(name = "title") String title, @RequestParam(name = "content") String content,
			@RequestParam(name = "author") String author, @RequestParam (name="category") String category, ModelMap modelMap, HttpSession httpSession) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		WebBlogDTO addedBlog = webBlogService.addBlog(title, content, author, category, user, httpSession);

		if (addedBlog != null) {
			List<WebBlogDTO> blogs = webBlogService.findMyBlogs(user.getId());
			modelMap.addAttribute("user", user);
			modelMap.addAttribute("blogs", blogs);
			return "my-blogs";
		} else {
			modelMap.addAttribute("message", "Something went wrong..");
			modelMap.addAttribute("user", user);
			return "add-blog";
		}
	}

	@RequestMapping(value = "/blogs", method = RequestMethod.GET)
	protected String findAllBlogs(HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if (user != null) {
			List<WebBlogDTO> blogs = webBlogService.findAllWebBlogs();
			if (blogs != null) {
				modelMap.addAttribute("role", user.getRole());
				modelMap.addAttribute("blogs", blogs);
			} else {
				modelMap.addAttribute("message", "Blogs Not Found..");
			}
			modelMap.addAttribute("role", user.getRole());
			modelMap.addAttribute("user", user);
			return "blogs";
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/my-blogs", method = RequestMethod.GET)
	protected String findMyBlogs(HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if (user != null) {
			List<WebBlogDTO> blogs = user.getWebBlogs();
			modelMap.addAttribute("blogs", blogs);
			modelMap.addAttribute("user", user);
			return "my-blogs";
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/read-blog", method = RequestMethod.GET)
	protected String readBlog(@RequestParam(name = "id") int blogId, HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if (user != null) {
			WebBlogDTO blog = webBlogService.findWebBlogById(blogId);
			List<CommentDTO> comments = webBlogService.findCommentsByBlogId(blogId);
			modelMap.addAttribute("blog", blog);
			modelMap.addAttribute("comments",comments);
			return "read-blog";

		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/update-blog-page", method = RequestMethod.GET)
	protected String getUpdateBlogPage(@RequestParam(name = "id") int id, HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if (user != null) {
			WebBlogDTO blog = webBlogService.findWebBlog(id);
			modelMap.addAttribute("blog", blog);
			return "update-blog";
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/update-blog", method = RequestMethod.POST)
	protected String updateBlog(@RequestParam(name = "id") int id, @RequestParam(name = "title") String title,
			@RequestParam(name = "content") String content, @RequestParam(name = "author") String author,
			HttpSession httpSession, ModelMap modelMap) {
		WebBlogDTO updatedBlog = webBlogService.updateBlog(id, title, content, author);

		if (updatedBlog != null) {
			modelMap.addAttribute("message", "Blog updated..");
		} else {
			modelMap.addAttribute("message", "Something went wrong..");
		}

		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		modelMap.addAttribute("user", user);
		List<WebBlogDTO> blogs = webBlogService.findMyBlogs(user.getId());
		modelMap.addAttribute("blogs", blogs);
		return "my-blogs";

	}

	@RequestMapping(value = "delete-blog", method = RequestMethod.GET)
	protected String deleteBlog(@RequestParam(name = "blogId") int blogId, @RequestParam(name = "userId") long userId,
			HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");

		if (user != null) {
			WebBlogDTO deletedBlog = webBlogService.deleteBlog(blogId, userId);

			if (deletedBlog == null) {
				modelMap.addAttribute("message", "Somethinng Went Wrong");
			}
			List<WebBlogDTO> blogs = null;
			if (user.getRole().equals(Role.USER)) {
				blogs = webBlogService.findMyBlogs(userId);
				if (blogs != null) {
					modelMap.addAttribute("user", user);
					modelMap.addAttribute("blogs", blogs);
				} else {
					modelMap.addAttribute("message", "Blogs not Found");
				}
				return "my-blogs";
			} else {
				blogs = webBlogService.findAllWebBlogs();
				if (blogs != null) {
					modelMap.addAttribute("blogs", blogs);
				} else {
					modelMap.addAttribute("message", "Blogs not Found");
				}
				return "blogs";
			}
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/sort", method = RequestMethod.GET)
	protected String sortBlogs(@RequestParam(name = "index") int index, HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if (user != null) {
			List<WebBlogDTO> sortedBlogs = webBlogService.sortBlogs(index);
			modelMap.addAttribute("blogs", sortedBlogs);
			modelMap.addAttribute("role", user.getRole());
			return "blogs";
		} else {
			return "login";
		}
	}

	@RequestMapping(value = "/searchBlog", method = RequestMethod.GET)
	protected String searchBlogs(@RequestParam(name = "query") String query, HttpSession httpSession,
			ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if (user != null) {
			List<WebBlogDTO> blogs = webBlogService.searchBlogs(query);
			if (blogs != null) {
				modelMap.addAttribute("blogs", blogs);
			} else {
				modelMap.addAttribute("message", "Blogs not Found..");
			}
			modelMap.addAttribute("role", user.getRole());
			return "blogs";
		} else {
			return "login";
		}
	}
	
	@RequestMapping(value = "/add-like")
	protected String addLike(@RequestParam(name = "blog-id") int blogId , HttpSession httpSession, ModelMap modelMap) {
		UserDTO user = (UserDTO) httpSession.getAttribute("user");
		if(user != null) {
			WebBlogDTO blog =  webBlogService.addLike(blogId);
			List<CommentDTO> comments = webBlogService.findCommentsByBlogId(blogId);
			modelMap.addAttribute("blog",blog);
			modelMap.addAttribute("comments",comments);
			return "read-blog";
		} else {
			return "login";
		}
		
	}
	
	
	@RequestMapping(value = "/add-comment", method = RequestMethod.POST)
    protected String addComment(@RequestParam(name = "blogId") int blogId, 
                                @RequestParam(name = "content") String content, 
                                @RequestParam(name = "author") String author, 
                                HttpSession httpSession, ModelMap modelMap) {
        UserDTO user = (UserDTO) httpSession.getAttribute("user");

        if (user != null) {
            CommentDTO comment = webBlogService.addComment(blogId, content, author);

            WebBlogDTO blog = webBlogService.findWebBlogById(blogId);
            List<CommentDTO> comments = webBlogService.findCommentsByBlogId(blogId);
      

            modelMap.addAttribute("blog", blog);
            modelMap.addAttribute("comments", comments);

            return "read-blog";
        } else {
            return "login";
        }
    }
	
	

}
