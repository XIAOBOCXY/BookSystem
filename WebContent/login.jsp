<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<jsp:useBean id="alogin" scope="page" class="org.pan.web.login" />
<!-- jsp:useBean��һ��JSP����ָ���ʾװ��һ������JSPҳ����ʹ�õ�JavaBean id��ʾ�����JavaBean��Ψһ��ʶ��class��ʾ�����JavaBean���� -->
<%
int f=1;//�Ƿ��¼�ɹ� 

if( request.getParameter("username")!=null){//request.getParameter()��Web�ͻ��˴���Web�������ˣ�����HTTP��������
	String username =request.getParameter("username");
	String passwd = request.getParameter("passwd");
	
	//ת����ISO8859-1���룬Ҫ��Ȼ����Ϊ����
	username = new String(username.getBytes("ISO8859-1"));//ͨ��getBytes����������������ISO8859_1���뷽ʽ
	passwd = new String(passwd.getBytes("ISO8859-1"));
	
	alogin.setUsername(username);
	alogin.setPasswd(passwd);
	
	if (alogin.excute()){//���÷�������ȡsql��ѯ���
		session.setAttribute("username",username);//��ֵ����session��
		String userid = Long.toString(alogin.getUserid());
		session.setAttribute("userid",userid);
		response.sendRedirect("index.jsp");//�����û���Ϣҳ��
	}
	else {
		f=0;
	}
}
%>

<html>
<head>
<title>������--�û���¼</title>
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

	<br>
	<br>
	<p>������</p>
  	<br>
  	
  <form name="form1" method="post" action="login.jsp"><!-- �� -->
    <table>
    <tr> 
      <td width="100" align="right">�û�����<br>
      </td>
      <td width="200" ><input type="text" name="username" size="16" maxlength="20">
      </td>
    </tr>
    
    <tr> 
      <td width="100" align="right">���룺
      </td>
      <td width="200" ><input type="password" name="passwd" maxlength="20" size="16">
      </td>
    </tr> 
    
    <tr> 
      <td width="300" colspan="2" align="center">
          <input type="submit" name="Submit" value="��¼" onClick="javascript:return(checkform());">
          <input type="reset" name="Submit2" value="����">
      </td>
    </tr>
    
    <% if (f==0){%><script>alert("�û������������");</script><%}%> 
    
    <tr> 
      <td colspan="2" align="center">
        <p><a href="reg.jsp">ע��</a> <a href="manage/login.jsp">���ǹ���Ա</a>
      </td>
    </tr>
    
  	</table>
  </form>  
  
</div>
</body>
</html>
