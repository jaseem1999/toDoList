package com.doit.dto;

import java.io.Serializable;
import java.sql.Blob;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "user_table")
public class UserDTO implements Serializable {
    @Id
    @GenericGenerator(name = "ref", strategy = "increment")
    @GeneratedValue(generator = "ref")
    @Column(name = "uid")
    private int uid;

    @Column(name = "email")
    private String email;

    @Column(name = "pass")
    private String pass;

    @Column(name = "phone")
    private Long phone;

    @Lob
    @Column(name = "profile_image")
    private Blob profileImage;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "uid")
    private java.util.Collection<ToDoDTO> col;

    // Constructors, getters, and setters
    // Constructor
    public UserDTO() {
        // TODO Auto-generated constructor stub
    }

    public java.util.Collection<ToDoDTO> getCol() {
        return col;
    }

    public void setCol(java.util.Collection<ToDoDTO> col) {
        this.col = col;
    }

    // Getters and setters
    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public Long getPhone() {
        return phone;
    }

    public void setPhone(Long phone) {
        this.phone = phone;
    }

    public Blob getProfileImage() {
        return profileImage;
    }

    public void setProfileImage(Blob profileImage) {
        this.profileImage = profileImage;
    }
}
