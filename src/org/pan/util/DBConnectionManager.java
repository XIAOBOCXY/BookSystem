//将连接数据库操作封装成一个类DBConnectionManager.java
package org.pan.util;
import java.sql.*;

public class DBConnectionManager {
	private String driverName="com.mysql.jdbc.Driver";//mysql驱动
	private String url="jdbc:mysql://localhost:3306/dbhouse?useSSL=false&useUnicode=true&characterEncoding=utf-8&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai";//数据库地址
	private String user = "root";//用户名
    private String password = "123456";//口令
    
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
            Class.forName(driverName);//加载驱动程序
            Connection con=DriverManager.getConnection(url, user, password);//连接数据库
            return con;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
	}
}