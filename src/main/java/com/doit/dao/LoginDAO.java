package com.doit.dao;

import java.util.List;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.doit.dto.UserDTO;

public class LoginDAO {
	public static List<UserDTO> li = null;
	 public static boolean userLogin(String email, String pass) {
	        // Initialize variables
	        boolean isLoggedIn = false;
	        List<UserDTO> userList = null;
	        
	        // Create Hibernate configuration
	        Configuration cfg = new Configuration().configure().addAnnotatedClass(UserDTO.class);
	        SessionFactory sessionFactory = cfg.buildSessionFactory();
	        
	        // Open session
	        try (Session session = sessionFactory.openSession()) {
	            // Begin transaction
	            Transaction tx = session.beginTransaction();
	            
	            // Query to check user credentials
	            Query query = session.createQuery("FROM UserDTO WHERE email = :email AND pass = :pass", UserDTO.class);
	            query.setParameter("email", email);
	            query.setParameter("pass", pass);
	            
	            // Execute query
	            userList = query.getResultList();
	            
	            // Commit transaction
	            tx.commit();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        // Check if user exists and credentials are correct
	        if (userList != null && !userList.isEmpty()) {
	            isLoggedIn = true;
	        }

	        return isLoggedIn;
	 }
	 public static List<UserDTO> getAllUserDetails(String email, String pass){
		 
		 Configuration cfg = new Configuration().configure().addAnnotatedClass(UserDTO.class);
	     SessionFactory sessionFactory = cfg.buildSessionFactory();
	     try (Session session = sessionFactory.openSession()) {
	            // Begin transaction
	            Transaction tx = session.beginTransaction();
	            
	            // Query to check user credentials
	            Query query = session.createQuery("FROM UserDTO u WHERE email = :email AND pass = :pass", UserDTO.class);
	            query.setParameter("email", email);
	            query.setParameter("pass", pass);
	            
	            // Execute query
	            li = query.getResultList();
	            
	            // Commit transaction
	            tx.commit();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		 
		 return li;
	 }
	 
}
