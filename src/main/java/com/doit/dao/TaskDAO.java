package com.doit.dao;


import java.util.ArrayList;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.doit.dto.ToDoDTO;
import com.doit.dto.UserDTO;

public class TaskDAO {
	private static List<UserDTO> user = null;

	public static int addTask(int uid, String task, String date, String time) {
		int i =0;
		
		ToDoDTO toDo = new ToDoDTO();
		
		toDo.setTask(task);
		toDo.setStatus(null);
		toDo.setDate(date);
		
		java.util.Date currentDate = new java.util.Date();
		toDo.setCurrentDate(currentDate);
		toDo.setTime(time);
	    user = LoginDAO.li;
	    UserDTO userDetails = user.get(0);
	    toDo.setUser(userDetails);
		
		
		Configuration cgf = new Configuration().configure().addAnnotatedClass(UserDTO.class);
		SessionFactory sf = cgf.buildSessionFactory();
		Session session = sf.openSession();
		Transaction tx = session.beginTransaction();
		
		
		try {
			session.save(toDo);
			tx.commit();
			session.close();
			i = 1;
			return i;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			
		}
		
		return i;
	}
	
    public static List<ToDoDTO> getAllTaskBasedOnUID(int uid) {
        List<ToDoDTO> todos = new ArrayList<>();
        Configuration cfg = new Configuration().configure().addAnnotatedClass(ToDoDTO.class);
        try (SessionFactory sessionFactory = cfg.buildSessionFactory();
             Session session = sessionFactory.openSession()) {
            // Begin transaction
            Transaction tx = session.beginTransaction();

            // Query to retrieve tasks based on uid
            String hql = "FROM ToDoDTO t WHERE t.user.uid = :uid ORDER BY t.tid DESC";
            List<ToDoDTO> tasks = session.createQuery(hql, ToDoDTO.class)
                    .setParameter("uid", uid)
                    .getResultList();

            // Commit transaction
            tx.commit();

            // Populate todos list
            todos.addAll(tasks);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return todos;
    }
    
    public static int completedTask(int tid) {
    	int i = 0;
    	Configuration cfg = new Configuration().configure().addAnnotatedClass(ToDoDTO.class);
    	try {
    		SessionFactory sf = cfg.buildSessionFactory();
    		Session session = sf.openSession();
    		Transaction tx = session.beginTransaction();
    		ToDoDTO toDo = (ToDoDTO) session.get(ToDoDTO.class, tid);
    		toDo.setStatus("accept");
    		session.update(toDo);
    		tx.commit();
    		i = 1;
    		return i;
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
    	
    	return i;
    }
    
    public static int deleteTask(int tid) {
    	int i = 0;
    	Configuration cfg = new Configuration().configure().addAnnotatedClass(ToDoDTO.class);
    	try {
    		SessionFactory sf = cfg.buildSessionFactory();
    		Session session = sf.openSession();
    		Transaction tx = session.beginTransaction();
    		ToDoDTO toDo = (ToDoDTO) session.get(ToDoDTO.class, tid);
    		toDo.setStatus("reject");
    		session.delete(toDo);
    		tx.commit();
    		i = 1;
    		return i;
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
    	
    	return i;
    }
}
