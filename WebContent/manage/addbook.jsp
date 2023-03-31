<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="org.pan.web.book.bookclass"%>
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<%
	String mesg = "";
	String submit = request.getParameter("Submit");
	if (submit!=null && !submit.equals("")){		
		if(book.getRequest(request)){
			if(book.insert()){
				mesg = "��ͼ�������ύ�ɹ���";
			} else {
				mesg = "���ݿ����ʧ��";
			}
		}else {
			mesg = "�Բ������ύ�Ĳ����д���";
		}
	}
%>

<html>
<head>
<title>����������ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
  function checkform() {
	if (document.form1.bookname.value=="") {
		document.form1.bookname.focus();
		alert("ͼ�����Ʋ���Ϊ��!");
		return false;
	}
	if (document.form1.author.value=="") {
		alert("����������Ϊ��!");
		document.form1.author.focus();
		return false;
	}

	return true;

  }
</script>
<link rel="stylesheet"  type="text/css">
<style type="text/css">
body {
	
}
</style></head>

<body >
<div align="center">
<table>
    <tr> 
      <td width="100"><a href="main.jsp">�ع�����ҳ</a></td>
      <td width="100"><a href="booklist.jsp">�̵�ͼ���ѯ</a></td>
      <td width="100"><a href="addbook.jsp">���ͼ������</a></td>
      <td width="100"><a href="orderlist.jsp">������Ϣ��ѯ</a></td>
      <td width="100"><a href="userlist.jsp">�û���Ϣ��ѯ</a></td>
      <td width="100"><a href="logout.jsp">�˳�</a></td>
    </tr>
  </table>
  <table width="100%" border="0">
    <tr>
      <td align="center" width="100%"> 
        <p><br>
         ����µ�ͼ����Ϣ</p>
		  <% if(!mesg.equals("")){
			out.println(mesg);
		  }%>
        <form name="form1" method="post" action="addbook.jsp">
          <table >
            <tr> 
              <td align="right" width="50%"><div align="right" >ͼ�����ƣ�</div></td>
              <td width="50%"> 
                <input type="text" name="bookname" maxlength="40" size="10">
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right">���ߣ�</div></td>
              <td width="50%"> 
                <input type="text" name="author" maxlength="25" size="10">
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right">�����磺</div></td>
              <td width="50%"> 
                <input type="text" name="publish" size="10" maxlength="150">
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right" >�������</div></td>
              <td width="50%"> 
                <select name="bookclass">
		<% if (classlist.excute()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>
			      <option value="<%= bc.getId()%>"><%= bc.getClassName() %></option>
		<%		}			
		}%>	
					
                </select>
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right" >��ţ�</div></td>
              <td width="50%"> 
                <input type="text" name="bookno" size="10" maxlength="30">
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right">���ۣ�</div></td>
              <td width="50%"> 
                <span class="style4">
                <input type="text" name="price" size="10" maxlength="10">
                Ԫ</span></td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right" >��������</div></td>
              <td width="50%"> 
                <span class="style4">
                <input type="text" name="amount" size="10" maxlength="10">
                ��</span></td>
            </tr>
            <tr> 
              <td align="right" width="50%" valign="top"><div align="right" >ͼ���飺</div></td>
              <td width="50%"> 
                <textarea name="content" cols="15" rows="3"></textarea>
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%">&nbsp;</td>
              <td width="50%"> 
                <input type="submit" name="Submit" value="�ύ" onClick="return(checkform());">
                <input type="reset" name="reset" value="����">
              </td>
            </tr>
          </table>
        </form>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>
  <br>
</div>
</body>
</html>
<% book.close();%>