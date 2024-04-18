package com.doit.dao;


import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;

import javax.servlet.http.HttpServletResponse;

public class ProfileImageDAO {
	 public static byte[] getProfileImage(Blob img, HttpServletResponse response) {
	        try {
	            // Convert Blob to byte array
	            byte[] byteArray = null;
	            if (img != null) {
	                try (InputStream inputStream = img.getBinaryStream();
	                     ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
	                    byte[] buffer = new byte[4096];
	                    int bytesRead;
	                    while ((bytesRead = inputStream.read(buffer)) != -1) {
	                        outputStream.write(buffer, 0, bytesRead);
	                    }
	                    byteArray = outputStream.toByteArray();
	                }
	            }
	            return byteArray;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }
}
