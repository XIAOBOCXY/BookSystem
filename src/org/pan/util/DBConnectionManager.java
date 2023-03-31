//���������ݿ������װ��һ����DBConnectionManager.java
package org.pan.util;
import java.sql.*;

public class DBConnectionManager {
	private String driverName="com.mysql.jdbc.Driver";//mysql����
	private String url="jdbc:mysql://localhost:3306/dbhouse?useSSL=false&useUnicode=true&characterEncoding=utf-8&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai";//���ݿ��ַ
	private String user = "root";//�û���
    private String password = "123456";//����
    
	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Connection getConnection() {
		try {
            Class.forName(driverName);//������������
            Connection con=DriverManager.getConnection(url, user, password);//�������ݿ�
            return con;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
	}
}