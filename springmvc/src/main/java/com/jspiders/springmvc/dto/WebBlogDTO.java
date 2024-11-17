package com.jspiders.springmvc.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name="blogs")
@Data
public class WebBlogDTO implements Comparable<WebBlogDTO> {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(nullable = false, unique = false)
	private String title;
	@Column(nullable = false, unique = false)
    private String category;
	@Column(nullable = false, unique = false,columnDefinition = "TEXT")
	private String content;
	@Column(nullable = false, unique = false)
	private Date date;
	@Column(nullable = false, unique = false)
	private String author;
	@Column(nullable = false, unique = false)
	private long userId;
	@Column(nullable = false, unique = false)
    private int likes = 0;

	 @OneToMany(mappedBy = "blog", cascade = CascadeType.ALL)
	 private List<CommentDTO> comments;

	@Override
	public int compareTo(WebBlogDTO o) {
		if (this.date.after(o.date)) {
			return 1;
		} else if (this.date.before(o.date)) {
			return -1;
		} else {
			return 0;
		}
	}
}
