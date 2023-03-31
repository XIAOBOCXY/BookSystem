<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<jsp:useBean id="alogin" scope="page" class="org.pan.web.login" />

<%
int f=1;
if( request.getParameter("username")!=null){
	String username =request.getParameter("username");
	String passwd = request.getParameter("passwd");
	username = new String(username.getBytes("ISO8859-1"));
	passwd = new String(passwd.getBytes("ISO8859-1"));
	alogin.setUsername(username);
	alogin.setPasswd(passwd);
	alogin.setIsadmin(true);
	if (alogin.excute()){
		session.setAttribute("admin",username);
		response.sendRedirect("main.jsp");//进入用户信息页面		
	}else {
		f=0;
	}
}
%>

<html>
<head>
<style type="text/css">
</style>
<title>购书网管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script>
	function checkform() {
		if(document.form1.username.value==""){/* 表单控件直接取值 */
			alert("用户名不能为空！");
			return false;
		}
		if (document.form1.passwd.value==""){
			alert("密码不能为空！");
			return false;
		}
		return true;
	  }
</script>

</head>

<body>
<div align="center">
  <table height="50%" >
    <tr> 
      <td align="center"> 
        <form name="form1" method="post" action="login.jsp">
       
          <table>
          
            <tr align="center"> 
              <td colspan="2"> 
                <p><br>购书网管理员登录界面</p><br>
                <p><% if (f==0){%><script>alert("用户名或密码错误！");</script><%}%></p>
              </td>
            </tr>
            
            <tr> 
              <td align="right" width="60%">管理员用户名：</td>
              <td> 
                <input type="text" name="username" size="12" maxlength="20">
              </td>
            </tr>
            
            <tr> 
              <td align="right" width="60%">管理员密码：</td>
              <td> 
                <input type="password" name="passwd" size="12" maxlength="20">
              </td>
            </tr>
            
            <tr align="center"> 
              <td colspan="2"> 
                <input type="submit" name="Submit" value="登录" onClick="javascript:return(checkform());">
                <input type="reset" name="Submit2" value="取消">
              </td>
            </tr>
            
            <tr align="center">
              <td colspan="2"><A HREF="../login.jsp">返回用户登录界面</A></td>
            </tr>
            
          </table>
	    </form>

      </td>
    </tr>
  </table>
</div>
</body>
</html>
