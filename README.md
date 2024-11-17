# Blog Management System

The Blog Management System is a comprehensive web application built using Spring MVC, JSP, Hibernate, and MySQL. It enables users to create, update, delete, and view blogs, with role-based access control to ensure secure and efficient functionality. Key features include user authentication, blog interaction through comments and likes, and email verification during signup. The application leverages Hibernate for seamless database management and employs JSP with custom CSS to deliver a responsive and user-friendly interface, offering a streamlined solution for blogging and user engagement.

---

## Features

- **User Authentication**: Login, Signup, and Password Reset functionalities.
- **Role-Based Access Control**: Admin and User roles for controlled access.
- **Blog Management**: Create, update, delete, and view blogs.
- **Comments and Likes**: Users can interact by commenting on and liking blogs.
- **Email Verification**: Verify email addresses during signup for added security.

---

## Directory Structure

### Project Structure
```
springmvc/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/jspiders/springmvc/
│   │   │       ├── App.java
│   │   │       ├── controller/
│   │   │       │   ├── UserController.java
│   │   │       │   └── WebBlogController.java
│   │   │       ├── dao/
│   │   │       │   ├── UserDAO.java
│   │   │       │   └── WebBlogDAO.java
│   │   │       ├── dto/
│   │   │       │   ├── CommentDTO.java
│   │   │       │   ├── Role.java
│   │   │       │   ├── UserDTO.java
│   │   │       │   └── WebBlogDTO.java
│   │   │       ├── service/
│   │   │       │   ├── EmailService.java
│   │   │       │   ├── UserService.java
│   │   │       │   └── WebBlogService.java
│   │   └── resources/
│   │       └── META-INF/persistence.xml
│   └── webapp/
│       ├── index.jsp
│       ├── WEB-INF/
│       │   ├── Dispatcher-servlet.xml
│       │   ├── resources/
│       │   │   └── images/logo.png
│       │   ├── views/
│       │   │   ├── add-blog.jsp
│       │   │   ├── all-users.jsp
│       │   │   ├── blogs.jsp
│       │   │   ├── css/
│       │   │   │   ├── blogStyles.css
│       │   │   │   ├── logo.png
│       │   │   │   └── styles.css
│       │   │   ├── home.jsp
│       │   │   ├── login.jsp
│       │   │   ├── my-blogs.jsp
│       │   │   ├── read-blog.jsp
│       │   │   ├── resetpassword.jsp
│       │   │   ├── signup.jsp
│       │   │   ├── update-blog.jsp
│       │   │   ├── updateuser.jsp
│       │   │   ├── verify.jsp
│       │   │   └── verifyemail.jsp
│       │   └── web.xml
└── target/
    └── classes/
```

---

## Key Components

### Backend
- **Controllers**:
  - `UserController.java`: Handles user-related operations.
  - `WebBlogController.java`: Manages blog-related functionality.
- **Services**:
  - `UserService.java`, `WebBlogService.java`: Business logic for users and blogs.
  - `EmailService.java`: Sends verification and notification emails.
- **DAOs**:
  - `UserDAO.java`, `WebBlogDAO.java`: Data access objects for user and blog entities.
- **DTOs**:
  - `UserDTO`, `WebBlogDTO`, `CommentDTO`, `Role`: Data transfer objects for encapsulating data.

### Frontend
- **Views**: JSP pages for user interface, located under `/WEB-INF/views/`.
  - Authentication pages: `login.jsp`, `signup.jsp`, `verify.jsp`.
  - Blog management: `add-blog.jsp`, `update-blog.jsp`, `blogs.jsp`.
  - Styles: `styles.css`, `blogStyles.css`.

### Configuration
- **Dispatcher-servlet.xml**: Spring MVC configurations.
- **persistence.xml**: Hibernate persistence setup.
- **web.xml**: Web application deployment descriptor.

---

## Prerequisites

- **Java**: JDK 8 or above
- **Maven**: For dependency management
- **MySQL**: Database
- **Tomcat**: Server to deploy the application
- **Spring MVC**: Framework

---

## Setup and Deployment

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd springmvc
   ```
3. Configure the database connection in `persistence.xml`.
4. Build the project using Maven:
   ```bash
   mvn clean install
   ```
5. Deploy the application on Tomcat:
   - Copy the WAR file from `target/` to Tomcat's `webapps` folder.
6. Access the application at `http://localhost:8080/springmvc`.

---

## License

This project is licensed under the [MIT License](LICENSE).

---


```

This `README.md` is structured to provide an overview of the project, its features, and instructions to set it up and deploy. Add actual screenshots and links as needed.
