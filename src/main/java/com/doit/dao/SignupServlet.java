package com.doit.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.rowset.serial.SerialBlob;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.doit.dto.UserDTO;

/**
 * Servlet implementation class SignupServlet
 */
@MultipartConfig(maxFileSize = 16177215) 
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email");
		String pass= request.getParameter("pass");
		long phone = Long.parseLong(request.getParameter("phone"));
		Part part = request.getPart("profileImage");
	    InputStream inputStream = part.getInputStream();
	    Blob profileImageBlob = null;
	    if (inputStream != null) {
	        try {
				profileImageBlob = new SerialBlob(inputStream.readAllBytes());
			} catch (SQLException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	    
	    UserDTO user = new UserDTO();
	    user.setEmail(email);
	    user.setPass(pass);
	    user.setPhone(phone);
	    user.setProfileImage(profileImageBlob);
	    
	    try {
			Configuration cgf = new Configuration().configure().addAnnotatedClass(UserDTO.class);
			SessionFactory sf = cgf.buildSessionFactory();
			Session session = sf.openSession();
			Transaction tx = session.beginTransaction();
			try {
				session.save(user);
				tx.commit();
				response.sendRedirect("index.jsp?message=signupSuccess");
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("Transction time ::: "+e);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Parent  "+e);
		}
		
	}

}
