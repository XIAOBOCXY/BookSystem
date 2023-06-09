<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<jsp:useBean id="user" scope="page" class="org.pan.web.usermn" />
<%
String mesg = "";
String submit = request.getParameter("Submit");
if (submit!=null && !submit.equals("")) {
	if(user.insert(request)){
		session.setAttribute("username",user.getUserName());
		session.setAttribute( "userid", Long.toString( user.getUserid() ) ); 
		response.sendRedirect("userinfo.jsp?action=regok");
	} else if (!user.getMessage().equals("")) {
		mesg = user.getMessage();
	} else
		mesg = "注册时出现错误，请稍后再试";
}


%>

<html>
<head>
<title>购书网--用户注册</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}

function checkform() {
	if (document.form1.username.value==""){
		alert("用户名不能为空");
		document.form1.username.focus();
		return false;
	}
	if (document.form1.passwd.value==""){
		alert("密码不能为空");
		document.form1.passwd.focus();
		return false;
	}
	if (document.form1.passwd.value!=document.form1.passconfirm.value){
		alert("两次输入的密码不相同");
		document.form1.passconfirm.focus();
		return false;
	}
	
	return true;
}

</script>
</head>

<body>
<div align="center">
<br><br>
	<p>购书网</p>
<hr>

  <form name="form1" method="post" action="">
  <%if (!mesg.equals("")) out.println("<p>"+ mesg + "</p>");%>
    <table>
      <tr> 
        <td colspan="2" align="center">用户注册</td>
      </tr>
      <tr> 
        <td width="170" align="right">用户名：</td>
        <td width="270"> 
          <input type="text" name="username" maxlength="20" size="20" >
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">密码：</td>
        <td width="270">
          <input type="password" name="passwd" maxlength="20" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">再次确认密码：</td>
        <td width="270">
          <input type="password" name="passconfirm" maxlength="20" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">用户姓名：</td>
        <td width="270">
          <input type="text" name="names" maxlength="20" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">性别：</td>
        <td width="270">
          <select name="sex">
            <option>男</option>
            <option>女</option>
          </select>
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">联系地址：</td>
        <td width="270">
          <input type="text" name="address" maxlength="150" size="20">
        </td>
      </tr>
	  <tr> 
        <td width="170" align="right">联系邮编：</td>
        <td width="270">
          <input type="text" name="post" maxlength="8" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">联系电话：</td>
        <td width="270">
          <input type="text" name="phone" maxlength="25" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">电子邮件：</td>
        <td width="270">
          <input type="text" name="email" maxlength="50" size="20">
        </td>
      </tr>
      <tr>
        <td width="170" align="right">&nbsp; </td>
        <td width="270" algin="center">
          <input type="submit" name="Submit" value="注册" onClick="javascript:return(checkform());">
          <input type="reset" name="reset" value="取消">
        </td>
      </tr>
    </table>  
  </form>
  </table>
   <p><a href="login.jsp">去登录</a> </p>
</div>
</body>
</html>
<% user.close();  //关闭数据库连接 %>