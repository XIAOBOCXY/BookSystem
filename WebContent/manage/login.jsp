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
		response.sendRedirect("main.jsp");//�����û���Ϣҳ��		
	}else {
		f=0;
	}
}
%>

<html>
<head>
<style type="text/css">
</style>
<title>����������ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script>
	function checkform() {
		if(document.form1.username.value==""){/* ���ؼ�ֱ��ȡֵ */
			alert("�û�������Ϊ�գ�");
			return false;
		}
		if (document.form1.passwd.value==""){
			alert("���벻��Ϊ�գ�");
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
                <p><br>����������Ա��¼����</p><br>
                <p><% if (f==0){%><script>alert("�û������������");</script><%}%></p>
              </td>
            </tr>
            
            <tr> 
              <td align="right" width="60%">����Ա�û�����</td>
              <td> 
                <input type="text" name="username" size="12" maxlength="20">
              </td>
            </tr>
            
            <tr> 
              <td align="right" width="60%">����Ա���룺</td>
              <td> 
                <input type="password" name="passwd" size="12" maxlength="20">
              </td>
            </tr>
            
            <tr align="center"> 
              <td colspan="2"> 
                <input type="submit" name="Submit" value="��¼" onClick="javascript:return(checkform());">
                <input type="reset" name="Submit2" value="ȡ��">
              </td>
            </tr>
            
            <tr align="center">
              <td colspan="2"><A HREF="../login.jsp">�����û���¼����</A></td>
            </tr>
            
          </table>
	    </form>

      </td>
    </tr>
  </table>
</div>
</body>
</html>
