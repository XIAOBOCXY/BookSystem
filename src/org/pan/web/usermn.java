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
    private int page = 1;//��ʾ��ҳ��					
    private int pageSize=8;//ÿҳ�����ʾ�����ݵ�����		
    private int pageCount =0;//ҳ����
    private long recordCount =0;//��ѯ�ļ�¼��	
    private String message = "";
    private String username = "";//ע��󷵻ص��û���			
    private long userid = 0;//ע��󷵻ص��û����
    
    public int getPage() {	//��ʾ��ҳ��		
        return page;
    }
    public void setPage(int newpage) {
        page = newpage;
    }
    
    public int getPageSize(){	//ÿҳ��ʾ��ͼ����	
        return pageSize;
    }
    public void setPageSize(int newpsize) {
        pageSize = newpsize;
    }
    
    public int getPageCount() {	//ҳ������	
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
     //��ҳ��������������л�ȡ��Ҫ������
    public boolean getRequest(javax.servlet.http.HttpServletRequest newrequest) {
        boolean flag = false;
        try {
            request = newrequest;
            String ID = request.getParameter("userid");//��ȡuserid����
            if (ID!=null ) {
                userid = 0;
                try {
                    userid = Long.parseLong(ID);
                    user.setId(userid);
                } catch (Exception e) {
                    message = message + "��Ҫ�޸ĵ��û��ų���";
                }
            }
            
            username = request.getParameter("username");//��ȡusername����
            if (username==null || username.equals("")) {
                username = "";
                message = message + "�û���Ϊ��!";
            }
            user.setUserName(getGbk(username));
            String password = request.getParameter("passwd");//��ȡpasswd����
            if (password==null || password.equals("")) {
                password = "";
                message = message + "����Ϊ��!";
            }
            String pwdconfirm = request.getParameter("passconfirm");//��ȡpassconfirm����
            if (!password.equals(pwdconfirm)) {
                message = message + "ȷ�����벻��ͬ!";
            }
            user.setPassWord(getGbk(password));
            String names = request.getParameter("names");//��ȡnames����
            if (names==null) {
                names = "";
            }
            user.setNames(getGbk(names));//ת����ʽΪgbk
            String sex = request.getParameter("sex");//��ȡsex����
            user.setSex(getGbk(sex));
            String address = request.getParameter("address");//��ȡaddress����
            if (address == null) {
                address = "";
            }
            user.setAddress(getGbk(address));
            String post = request.getParameter("post");//��ȡpost����
            if (post == null) {
                post = "";
            }
            user.setPost(getGbk(post));
            String phone = request.getParameter("phone");//��ȡphone����
            if (phone== null) {
                phone = "";
            }
            user.setPhone(phone);
            String email = request.getParameter("email");//��ȡemail����
            if (email == null) {
                email = "";
            }
            user.setEmail(getGbk(email));
            String IP = request.getRemoteAddr();//��ȡ�û�ip
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
        sqlStr = "select * from My_Users order by Id";//�ñ������еļ�¼
        return sqlStr;
    }
    
    
    public boolean execute() throws Exception {
        sqlStr = "select count(*) from My_Users";//��ȡ�������еļ�¼������  
        int rscount = pageSize;
        try {
            ResultSet rs1 = stmt.executeQuery(sqlStr);
            if (rs1.next()) recordCount = rs1.getInt(1);
            rs1.close();
        } catch (SQLException e) {
            close();
            return false;
        }
       
        if (recordCount < 1)//��¼��С��1
            pageCount = 0;//ҳ����Ϊ0
        else
            pageCount = (int)(recordCount - 1) / pageSize + 1;//��ȡҳ����Ϊ����
        //ȷ��ҳ�����Ƿ�����ȷ�ķ�Χ��
        if (page < 1)
            page = 1;
        else if (page > pageCount)
            page = pageCount;
        
        rscount = (int) recordCount % pageSize;	//���һҳ�ļ�¼�� 
        
        //ȡ�����з��������ļ�¼��id��������
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
            sqlStr = "select * from My_Users where UserName = '" + user.getUserName() +"'";//ȡ������username�ļ�¼
            rs = stmt.executeQuery(sqlStr);//ִ��sql���
            if (rs.next()) {
                message = message + "���û����Ѵ���!";
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
            sqlStr="select * from My_Users where Id = " + newid ;//����newidȡ�����ϲ�ѯ�����ļ�¼
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

