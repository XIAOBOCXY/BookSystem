package org.pan.web;

import java.sql.*;
import java.util.Vector;
import org.pan.web.book.bookclass;



public class bookclasslist extends DataBase {
	private Vector classlist;		
	
	public bookclasslist() throws Exception{
		super();
	}

	public Vector getClasslist() {
		return classlist;
	}
        
	
	public String getSql() {
		this.sqlStr="select Id,ClassName from My_BookClass order by Id";
		return this.sqlStr;
	}

	public boolean excute() throws Exception {
		int id = 0;
		String classname = "";
		int count = 0;
		
		try {		
			rs = stmt.executeQuery(getSql());
            count = stmt.getMaxRows();
			classlist = new Vector(count+1);
			classlist.clear();
			while (rs.next()){				
				id = rs.getInt("Id");
				classname = rs.getString("ClassName");
				bookclass bc = new bookclass(id,classname);
				classlist.addElement(bc);//Ìí¼Óµ½vector
			}
			rs.close();
			return true;
		}
		catch (SQLException sqle){
			System.out.println(sqle+"³ö´í");
            return false;
		}
	}
};

