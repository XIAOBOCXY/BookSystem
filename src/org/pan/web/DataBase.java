//把对数据库进行的各种操作封装到一个DataBase.java类中
package org.pan.web;
import java.sql.*;
import org.pan.util.*;
public class DataBase {
	protected Connection conn = null;//Connection接口	
	protected Statement stmt = null;//Statement接口		
	protected ResultSet rs = null;//结果集
	protected String sqlStr;		
	protected boolean isConnect=true;//是否连接数据库	
	public DataBase() {
		try
		{
			sqlStr = "";
			DBConnectionManager dcm = new DBConnectionManager();
			conn = dcm.getConnection();
			stmt = conn.createStatement();
		}
		catch (Exception e)
		{
			System.out.println(e);
			isConnect=false;
		}
	}

	public Statement getStatement() {
		return stmt;
	}
	public Connection getConnection() {
		return conn;
	}
	public ResultSet getResultSet() {
		return rs;
	}
	public String getSql() {
		return sqlStr;
	}
	public boolean execute() throws Exception  {
		return false;
	}
	public boolean insert() throws Exception {
		return false;
	}
	public boolean update() throws Exception  {
		return false;
	}
	public boolean delete() throws Exception  {
		return false;
	}
	public boolean query() throws Exception {
		return false;
	}
	public void close() throws SQLException {
		if ( stmt != null )
		{
			stmt.close();
			stmt = null;
		}
		if ( conn != null )
		{
			conn.close();
			conn = null;
		}
		if(rs!=null) {
			rs.close();
			rs=null;
		}
	}
};



