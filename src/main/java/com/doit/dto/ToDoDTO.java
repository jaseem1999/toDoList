package com.doit.dto;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "toDo_table")
public class ToDoDTO implements Serializable{
	@Id
	@GenericGenerator(name = "ref", strategy = "increment")
	@GeneratedValue(generator = "ref")
    @Column(name = "tid")
	private int tid;
	private String task;
	private String date;
	private String time;
	private String status;
	private Date currentDate;
	
	
	
	public Date getCurrentDate() {
		return currentDate;
	}


	public void setCurrentDate(Date currentDate) {
		this.currentDate = currentDate;
	}
	@ManyToOne
    @JoinColumn(name = "uid") // Name of the foreign key column in the toDo_table
    private UserDTO user;
	
	
	public int getTid() {
		return tid;
	}


	public void setTid(int tid) {
		this.tid = tid;
	}

	public String getTask() {
		return task;
	}


	public void setTask(String task) {
		this.task = task;
	}

	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}


	public void setTime(String time) {
		this.time = time;
	}

	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}
	public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }
	public ToDoDTO() {
		System.out.println(this.getClass().getName()+" created");
	}
	
}
