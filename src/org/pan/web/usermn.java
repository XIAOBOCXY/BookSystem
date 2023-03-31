package org.pan.web;

import java.sql.*;
import java.util.Vector;
import org.pan.util.*;
import javax.servlet.http.HttpServletRequest;
import org.pan.web.book.shopuser;
import org.pan.web.book.books;
import java.util.*;

public class usermn extends DataBase {
    private shopuser user = new shopuser();	
    private javax.servlet.http.HttpServletRequest request; 
    private Vector userlist;				
    private int page = 1;//显示的页码					
    private int pageSize=8;//每页最多显示的数据的数量		
    private int pageCount =0;//页面数
    private long recordCount =0;//查询的记录数	
    private String message = "";
    private String username = "";//注册后返回的用户名			
    private long userid = 0;//注册后返回的用户编号
    
    public int getPage() {	//显示的页码		
        return page;
    }
    public void setPage(int newpage) {
        page = newpage;
    }
    
    public int getPageSize(){	//每页显示的图书数	
        return pageSize;
    }
    public void setPageSize(int newpsize) {
        pageSize = newpsize;
    }
    
    public int getPageCount() {	//页面总数	
        return pageCount;
    }
    public void setPageCount(int newpcount) {
        pageCount = newpcount;
    }
    
    public long getRecordCount() {
        return recordCount;
    }
    public void setRecordCount(long newrcount) {
        recordCount= newrcount;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String msg) {
        message = msg;
    }
    
    public void setUserid(long uid) {
        userid = uid;
    }
    public long getUserid() {
        return userid;
    }
    
    public void setUserName(String uName) {
        username = uName;
    }
    
    public String getUserName() {
        return username;
    }
    
    public usermn() throws Exception{
        super();
    }
    
    public Vector getUserlist() {
        return userlist;
    }
    
    public String getGbk( String str) {
        try {
            return new String(str.getBytes("ISO8859-1"));
        } catch (Exception e) {
            return str;
        }
    }
     //从页面表单传来的数据中获取需要的数据
    public boolean getRequest(javax.servlet.http.HttpServletRequest newrequest) {
        boolean flag = false;
        try {
            request = newrequest;
            String ID = request.getParameter("userid");//获取userid参数
            if (ID!=null ) {
                userid = 0;
                try {
                    userid = Long.parseLong(ID);
                    user.setId(userid);
                } catch (Exception e) {
                    message = message + "你要修改的用户号出错！";
                }
            }
            
            username = request.getParameter("username");//获取username参数
            if (username==null || username.equals("")) {
                username = "";
                message = message + "用户名为空!";
            }
            user.setUserName(getGbk(username));
            String password = request.getParameter("passwd");//获取passwd参数
            if (password==null || password.equals("")) {
                password = "";
                message = message + "密码为空!";
            }
            String pwdconfirm = request.getParameter("passconfirm");//获取passconfirm参数
            if (!password.equals(pwdconfirm)) {
                message = message + "确认密码不相同!";
            }
            user.setPassWord(getGbk(password));
            String names = request.getParameter("names");//获取names参数
            if (names==null) {
                names = "";
            }
            user.setNames(getGbk(names));//转化格式为gbk
            String sex = request.getParameter("sex");//获取sex参数
            user.setSex(getGbk(sex));
            String address = request.getParameter("address");//获取address参数
            if (address == null) {
                address = "";
            }
            user.setAddress(getGbk(address));
            String post = request.getParameter("post");//获取post参数
            if (post == null) {
                post = "";
            }
            user.setPost(getGbk(post));
            String phone = request.getParameter("phone");//获取phone参数
            if (phone== null) {
                phone = "";
            }
            user.setPhone(phone);
            String email = request.getParameter("email");//获取email参数
            if (email == null) {
                email = "";
            }
            user.setEmail(getGbk(email));
            String IP = request.getRemoteAddr();//获取用户ip
            user.setRegIpAddress(IP);
            if (message.equals("")) {
                flag = true;
            }
            return flag;
        } catch (Exception e) {
            return flag;
        }
    }
    
    public String getSql() {
        sqlStr = "select * from My_Users order by Id";//该表中所有的记录
        return sqlStr;
    }
    
    
    public boolean execute() throws Exception {
        sqlStr = "select count(*) from My_Users";//获取表中所有的记录的数量  
        int rscount = pageSize;
        try {
            ResultSet rs1 = stmt.executeQuery(sqlStr);
            if (rs1.next()) recordCount = rs1.getInt(1);
            rs1.close();
        } catch (SQLException e) {
            close();
            return false;
        }
       
        if (recordCount < 1)//记录数小于1
            pageCount = 0;//页面数为0
        else
            pageCount = (int)(recordCount - 1) / pageSize + 1;//获取页面数为整数
        //确认页面数是否在正确的范围内
        if (page < 1)
            page = 1;
        else if (page > pageCount)
            page = pageCount;
        
        rscount = (int) recordCount % pageSize;	//最后一页的记录数 
        
        //取出所有符合条件的记录按id降序排序
        sqlStr = "select * from My_Users ";
        if (page == 1) {
            sqlStr = sqlStr + " order by Id desc";
        } else {
            sqlStr = sqlStr + " where Id not in ( select Id from My_Users ORDER BY Id) and Id in " +
                    "(select Id from My_Users ORDER BY Id) " + " order by Id desc";
        }
        try {
            rs = stmt.executeQuery(sqlStr);
            userlist = new Vector();
            while (rs.next()){
                shopuser user = new shopuser();
                user.setId(rs.getLong("Id"));
                user.setUserName(rs.getString("UserName"));
                user.setPassWord(rs.getString("PassWord"));
                user.setNames(rs.getString("Names"));
                user.setSex(rs.getString("Sex"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setPost(rs.getString("Post"));
                user.setEmail(rs.getString("Email"));
                user.setRegIpAddress(rs.getString("RegIpAddress"));
                userlist.addElement(user);
            }
            rs.close();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
        
        
    }
    
    public boolean insert(HttpServletRequest req) throws Exception {
        if (getRequest(req)) {
            sqlStr = "select * from My_Users where UserName = '" + user.getUserName() +"'";//取出符合username的记录
            rs = stmt.executeQuery(sqlStr);//执行sql语句
            if (rs.next()) {
                message = message + "该用户名已存在!";
                rs.close();
                return false;
            }
            sqlStr = "insert into My_Users (UserName,PassWord,Names,Sex,Address,Phone,Post,Email,RegIpaddress) values ('";
            sqlStr = sqlStr + user.getUserName() + "','";
            sqlStr = sqlStr + user.getPassWord() + "','";
            sqlStr = sqlStr + user.getNames() + "','";
            sqlStr = sqlStr + user.getSex() + "','";
            sqlStr = sqlStr + user.getAddress() + "','";
            sqlStr = sqlStr + user.getPhone() + "','";
            sqlStr = sqlStr + user.getPost() + "','";
            sqlStr = sqlStr + user.getEmail() + "','";
            sqlStr = sqlStr + user.getRegIpAddress() + "')";
          
              try {
                stmt.execute(sqlStr);
                sqlStr = "select max(Id) from My_Users where UserName = '" +user.getUserName()+ "'";
                rs = stmt.executeQuery(sqlStr);
                while (rs.next()) {
                    userid = rs.getLong(1);
                }
                rs.close();
                return true;
            } catch (SQLException sqle) {
                System.out.println(sqle.toString());
                return false;
            }
        } else	{
            return false;
        }
        
    }
    
    public boolean update(HttpServletRequest req) throws Exception {
        if (getRequest(req)){
            sqlStr = "update My_Users set ";
            sqlStr = sqlStr + "UserName = '" + user.getUserName() + "',";
            sqlStr = sqlStr + "PassWord = '" + user.getPassWord() + "',";
            sqlStr = sqlStr + "Names = '" + user.getNames() + "',";
            sqlStr = sqlStr + "Sex = '" + user.getSex() + "',";
            sqlStr = sqlStr + "Address = '" + user.getAddress() + "',";
            sqlStr = sqlStr + "Phone = '" + user.getPhone() + "',";
            sqlStr = sqlStr + "Post = '" + user.getPost() + "',";
            sqlStr = sqlStr + "Email = '" + user.getEmail() + "' ";
            sqlStr = sqlStr + " where Id = '" + user.getId() + "'";
            try {
                stmt.execute(sqlStr);
                return true;
            } catch (SQLException e) {
                return false;
            }
        } else {
            return false;
        }
        
    }
    
    public boolean delete( long aid ) throws Exception {
        
        sqlStr = "delete from My_Users where Id = "  + aid ;
        try {
            stmt.execute(sqlStr);
            return true;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }
    
    public boolean getUserinfo(long newid ) throws Exception {
        try {
            sqlStr="select * from My_Users where Id = " + newid ;//根据newid取出符合查询条件的记录
            rs = stmt.executeQuery(sqlStr);
            userlist = new Vector();
            while (rs.next()){
                user.setId(rs.getLong("Id"));
                user.setUserName(rs.getString("UserName"));
                user.setPassWord(rs.getString("PassWord"));
                user.setNames(rs.getString("Names"));
                user.setSex(rs.getString("Sex"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setPost(rs.getString("Post"));
                user.setEmail(rs.getString("Email"));
                user.setRegIpAddress(rs.getString("RegIpAddress"));
                userlist.addElement(user);
            }
            rs.close();
            return true;
        } catch (SQLException e) {
            return false;
        }
        
    }
};

