<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="org.pan.web.book.bookclass" %>
<%@ page session="true" %>
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />

<html>
<head>
<title>������--��ҳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<style type="text/css">
</style></head>

<body>
<div align="center">
<br><br>
	<p>��������ҳ</p>
  <table>
    <tr> 
      <td width="100"><a href="index.jsp">��ҳ</a></td>
      <td width="100"><a href="booklist.jsp">����</a></td>
      <td width="100"><a href="shoperlist.jsp">���ﳵ</a></td>
      <td width="100"><a href="userinfo.jsp">�ҵ�</a></td>
      <td width="100"><a href="login.jsp">�˳�</a></td>
    </tr>
  </table>

<hr>

  <table>
    <tr> 

      <td width="500"><div align="center">
        <p><br>����ͼ�龫Ʒ     </p></div>    
        <table>
          <tr>
            <td width="50%">ʹ��JSP����WEBӦ��</td>
            <td width="50%" rowspan="5"><div align="center"><img src="images/book.jpg" width="100" height="140" "></div></td>
          </tr>
          <tr>
            <td width="50%">���ߣ� ����ï ��</td> 
          </tr>
          <tr>
          	<td width="50%">ISBN��222222</td> 
          </tr>
          <tr>
          	<td width="50%">�������ڣ�2010-1-1</td> 
          </tr>
          <tr>
          	<td width="50%">�����磺�廪��ѧ������</td> 
          </tr>
          <tr> 
            <td colspan="2"> 
              <p>���ݼ�飺</p>            
              <p align="left">����JSP 2.0�淶���������������Ͳ���JSP��������ǩ�ͱ�ǩ�ļ�������ʹ��JSP��JavaBean�����ʽ���ԣ�EL�����Զ����ǩ�Լ�JSTL��ǩ�ⴴ��WebӦ�ã������Servlet�������WebӦ�õĿ�����������ƻ���MVC����ҵӦ�á�</p>
            </td>
          </tr>
        </table>  
            
        
      <td width="160" align="center"> 
      <table>
        <tr>
          <td width="20" height="10">&nbsp;</td>
          <td><br>ͼ����ࣺ</td>
        </tr>
        <% if (classlist.excute()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>
        <tr>
          <td width="20" height="34">&nbsp;</td>
          <td><a href="booklist.jsp?classid=<%= bc.getId()%>"><%= bc.getClassName() %></a></td>
        </tr>
        <%		}			
		}%>
        </table>
  </table>
</div>
</body>
</html>
