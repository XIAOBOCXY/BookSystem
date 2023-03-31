package org.pan.web;


public class login extends DataBase
{
  private String username;//用户姓名
  private String passwd;//用户密码
  private boolean isadmin;//是否为管理员
  private int userid = 0;//用户id号

  public login()
    throws Exception//在方法声明部分使用，表示该方法可能产生此异常，如果在方法声明处使用了throws声明异常，则该方法产生异常也不必捕获，会直接把异常抛出到调用该方法的地方。
  {
    this.username = "";
    this.passwd = "";
    this.isadmin = false;//默认是用户
  }

  public String getUsername() {
    return this.username;
  }
  public void setUsername(String newusername) {
    this.username = newusername;
  }

  public String getPasswd() {
    return this.passwd;
  }
  public void setPasswd(String newpasswd) {
    this.passwd = newpasswd;
  }

  public boolean getIsadmin() {
    return this.isadmin;
  }
  public void setIsadmin(boolean newIsadmin) {
    this.isadmin = newIsadmin;
  }

  public long getUserid() {
    return this.userid;
  }
  public void setUserid(int uid) {
    this.userid = uid;
  }

  public String getSql() {
    if (this.isadmin) {//是管理员，查询My_BookAdminuser表
    	this.sqlStr = ("select * from My_BookAdminuser where AdminUser = '" + this.username + "' and AdminPass = '" + this.passwd + "'");
    }
    else {//是用户，查询My_Users表
    	this.sqlStr = ("select * from My_Users where UserName = '" + this.username + "' and PassWord = '" + this.passwd + "'");
    }
    return this.sqlStr;
  }
  
  public boolean excute() throws Exception {
    boolean flag = false;
    this.rs = this.stmt.executeQuery(getSql());//获取sql查询结果，将sql语句发送到要访问的数据库中，返回结果
    if (this.rs.next()) {//将指针从当前位置下移一行。ResultSet 指针最初位于第一行之前；第一次调用 next 方法使第一行成为当前行；
      if (!this.isadmin)
      {
        this.userid = this.rs.getInt("Id");//是用户的话，要获取ResultSet中对应用户的id
      }
      flag = true;
    }
    this.rs.close();//关闭ResultSet对象
    this.stmt.close();//关闭Statement对象
    this.conn.close();//关闭Connection对象
    return flag;
  }

}