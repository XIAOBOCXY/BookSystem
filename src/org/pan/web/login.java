package org.pan.web;


public class login extends DataBase
{
  private String username;//�û�����
  private String passwd;//�û�����
  private boolean isadmin;//�Ƿ�Ϊ����Ա
  private int userid = 0;//�û�id��

  public login()
    throws Exception//�ڷ�����������ʹ�ã���ʾ�÷������ܲ������쳣������ڷ���������ʹ����throws�����쳣����÷��������쳣Ҳ���ز��񣬻�ֱ�Ӱ��쳣�׳������ø÷����ĵط���
  {
    this.username = "";
    this.passwd = "";
    this.isadmin = false;//Ĭ�����û�
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
    if (this.isadmin) {//�ǹ���Ա����ѯMy_BookAdminuser��
    	this.sqlStr = ("select * from My_BookAdminuser where AdminUser = '" + this.username + "' and AdminPass = '" + this.passwd + "'");
    }
    else {//���û�����ѯMy_Users��
    	this.sqlStr = ("select * from My_Users where UserName = '" + this.username + "' and PassWord = '" + this.passwd + "'");
    }
    return this.sqlStr;
  }
  
  public boolean excute() throws Exception {
    boolean flag = false;
    this.rs = this.stmt.executeQuery(getSql());//��ȡsql��ѯ�������sql��䷢�͵�Ҫ���ʵ����ݿ��У����ؽ��
    if (this.rs.next()) {//��ָ��ӵ�ǰλ������һ�С�ResultSet ָ�����λ�ڵ�һ��֮ǰ����һ�ε��� next ����ʹ��һ�г�Ϊ��ǰ�У�
      if (!this.isadmin)
      {
        this.userid = this.rs.getInt("Id");//���û��Ļ���Ҫ��ȡResultSet�ж�Ӧ�û���id
      }
      flag = true;
    }
    this.rs.close();//�ر�ResultSet����
    this.stmt.close();//�ر�Statement����
    this.conn.close();//�ر�Connection����
    return flag;
  }

}