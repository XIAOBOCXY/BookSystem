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
		mesg = "ע��ʱ���ִ������Ժ�����";
}


%>

<html>
<head>
<title>������--�û�ע��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}

function checkform() {
	if (document.form1.username.value==""){
		alert("�û�������Ϊ��");
		document.form1.username.focus();
		return false;
	}
	if (document.form1.passwd.value==""){
		alert("���벻��Ϊ��");
		document.form1.passwd.focus();
		return false;
	}
	if (document.form1.passwd.value!=document.form1.passconfirm.value){
		alert("������������벻��ͬ");
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
	<p>������</p>
<hr>

  <form name="form1" method="post" action="">
  <%if (!mesg.equals("")) out.println("<p>"+ mesg + "</p>");%>
    <table>
      <tr> 
        <td colspan="2" align="center">�û�ע��</td>
      </tr>
      <tr> 
        <td width="170" align="right">�û�����</td>
        <td width="270"> 
          <input type="text" name="username" maxlength="20" size="20" >
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">���룺</td>
        <td width="270">
          <input type="password" name="passwd" maxlength="20" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">�ٴ�ȷ�����룺</td>
        <td width="270">
          <input type="password" name="passconfirm" maxlength="20" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">�û�������</td>
        <td width="270">
          <input type="text" name="names" maxlength="20" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">�Ա�</td>
        <td width="270">
          <select name="sex">
            <option>��</option>
            <option>Ů</option>
          </select>
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">��ϵ��ַ��</td>
        <td width="270">
          <input type="text" name="address" maxlength="150" size="20">
        </td>
      </tr>
	  <tr> 
        <td width="170" align="right">��ϵ�ʱࣺ</td>
        <td width="270">
          <input type="text" name="post" maxlength="8" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">��ϵ�绰��</td>
        <td width="270">
          <input type="text" name="phone" maxlength="25" size="20">
        </td>
      </tr>
      <tr> 
        <td width="170" align="right">�����ʼ���</td>
        <td width="270">
          <input type="text" name="email" maxlength="50" size="20">
        </td>
      </tr>
      <tr>
        <td width="170" align="right">&nbsp; </td>
        <td width="270" algin="center">
          <input type="submit" name="Submit" value="ע��" onClick="javascript:return(checkform());">
          <input type="reset" name="reset" value="ȡ��">
        </td>
      </tr>
    </table>  
  </form>
  </table>
   <p><a href="login.jsp">ȥ��¼</a> </p>
</div>
</body>
</html>
<% user.close();  //�ر����ݿ����� %>