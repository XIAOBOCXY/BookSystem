<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<jsp:useBean id="alogin" scope="page" class="org.pan.web.login" />
<!-- jsp:useBean是一个JSP动作指令，表示装载一个将在JSP页面中使用的JavaBean id表示定义的JavaBean的唯一标识，class表示定义的JavaBean的类 -->
<%
int f=1;//是否登录成功 

if( request.getParameter("username")!=null){//request.getParameter()从Web客户端传到Web服务器端，代表HTTP请求数据
	String username =request.getParameter("username");
	String passwd = request.getParameter("passwd");
	
	//转换成ISO8859-1编码，要不然不能为中文
	username = new String(username.getBytes("ISO8859-1"));//通过getBytes（）方法将其解码成ISO8859_1编码方式
	passwd = new String(passwd.getBytes("ISO8859-1"));
	
	alogin.setUsername(username);
	alogin.setPasswd(passwd);
	
	if (alogin.excute()){//调用方法来获取sql查询结果
		session.setAttribute("username",username);//把值存在session里
		String userid = Long.toString(alogin.getUserid());
		session.setAttribute("userid",userid);
		response.sendRedirect("index.jsp");//进入用户信息页面
	}
	else {
		f=0;
	}
}
%>

<html>
<head>
<title>购书网--用户登录</title>
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

	<br>
	<br>
	<p>购书网</p>
  	<br>
  	
  <form name="form1" method="post" action="login.jsp"><!-- 表单 -->
    <table>
    <tr> 
      <td width="100" align="right">用户名：<br>
      </td>
      <td width="200" ><input type="text" name="username" size="16" maxlength="20">
      </td>
    </tr>
    
    <tr> 
      <td width="100" align="right">密码：
      </td>
      <td width="200" ><input type="password" name="passwd" maxlength="20" size="16">
      </td>
    </tr> 
    
    <tr> 
      <td width="300" colspan="2" align="center">
          <input type="submit" name="Submit" value="登录" onClick="javascript:return(checkform());">
          <input type="reset" name="Submit2" value="重置">
      </td>
    </tr>
    
    <% if (f==0){%><script>alert("用户名或密码错误！");</script><%}%> 
    
    <tr> 
      <td colspan="2" align="center">
        <p><a href="reg.jsp">注册</a> <a href="manage/login.jsp">我是管理员</a>
      </td>
    </tr>
    
  	</table>
  </form>  
  
</div>
</body>
</html>
