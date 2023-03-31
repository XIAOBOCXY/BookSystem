<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
//	response.sendRedirect("error.htm");
} %>
<%@ page import="org.pan.web.book.bookclass" %>
<%@ page import="org.pan.web.book.books " %>
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<%
	String mesg = "";
	String submit = request.getParameter("Submit");
	int Id =0;
	if (submit!=null && !submit.equals("")){		
		if(book.getRequest(request)){
			if(book.update()){
				mesg = "ͼ�������޸ĳɹ���";
			} else {
				mesg = "���ݿ����ʧ��";
			}
		}else {
			mesg = "�Բ������ύ�Ĳ����д���";
		}
	}
	if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
		mesg = "��Ҫ�޸ĵ����ݲ�������";
	} else {
		try {
			Id = Integer.parseInt(request.getParameter("id"));
			if (!book.getOnebook(Id)){
				mesg = "��Ҫ�޸ĵ����ݲ�����";
			}
		} catch (Exception e){
			mesg = "��Ҫ�޸ĵ����ݲ�������";
		}
	}
%>

<html>
<head>
<title>����������ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
  function checkform() {
	if (document.form1.id.value=="") {
		alert("��Ҫ�޸ĵ����ݲ����ڣ�");
		return false;
	}
	if (document.form1.bookname.value=="") {
		document.form1.bookname.focus();
		alert("ͼ����Ϊ��!");
		return false;
	}
	if (document.form1.author.value=="") {
		alert("������Ϊ��!");
		document.form1.author.focus();
		return false;
	}

	return true;

  }
</script>
<link rel="stylesheet" type="text/css">
<style type="text/css">
body {
	
}
</style></head>

<body>
<div align="center">
<table>
    <tr> 
      <td width="100"><a href="main.jsp">�ع�����ҳ</a></td>
      <td width="100"><a href="booklist.jsp">�̵�ͼ���ѯ</a></td>
      <td width="100"><a href="addbook.jsp">����ͼ������</a></td>
      <td width="100"><a href="orderlist.jsp">������Ϣ��ѯ</a></td>
      <td width="100"><a href="userlist.jsp">�û���Ϣ��ѯ</a></td>
      <td width="100"><a href="logout.jsp">�˳�</a></td>
    </tr>
  </table>
  <table width="100%" border="0">
    <tr>
      <td align="center" width="100%"> 
        <p><br>
          �޸�ͼ������</p>
		  <% if(!mesg.equals("")){
			out.println(mesg);
		  } else {
			books modibook = (books) book.getBooklist().elementAt(0);			  
			%>
        <form name="form1" method="post" action="modibook.jsp">
          <table width="90%" border="0">
            <tr> 
              <td align="right" width="35%">ͼ�����ƣ�</td>
              <td width="65%"> 
                <input type="text" name="bookname" maxlength="40" size="30" value="<%= modibook.getBookName() %>">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">���ߣ�</td>
              <td width="65%"> 
                <input type="text" name="author" maxlength="25" size="20" value="<%= modibook.getAuthor() %>">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">�����磺</td>
              <td width="65%"> 
                <input type="text" name="publish" size="40" maxlength="150" value="<%= modibook.getPublish() %>">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">�������</td>
              <td width="65%"> 
                <select name="bookclass">
		<% if (classlist.excute()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>
			      <option value="<%= bc.getId()%>" <% if (bc.getId() == modibook.getBookClass()) out.print("selected");%>><%= bc.getClassName() %></option>
		<%		}			
		}%>	
					
                </select>
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">��ţ�</td>
              <td width="65%"> 
                <input type="text" name="bookno" size="20" maxlength="30" value="<%= modibook.getBookNo() %>">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">���ۣ�</td>
              <td width="65%"> 
                <input type="text" name="price" size="8" maxlength="10" value="<%= modibook.getPrince() %>">
                Ԫ</td>
            </tr>
            <tr> 
              <td align="right" width="35%">��������</td>
              <td width="65%"> 
                <input type="text" name="amount" size="8" maxlength="10" value="<%= modibook.getAmount() %>">
                ��</td>
            </tr>
            <tr> 
              <td align="right" width="35%" valign="top">ͼ���飺</td>
              <td width="65%"> 
                <textarea name="content" cols="40" rows="6"><%= modibook.getContent() %></textarea>
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">&nbsp;</td>
              <td width="65%"> 
				<input type="hidden" name="id" value="<%= Id %>">
                <input type="submit" name="Submit" value="�ύ" onClick="return(checkform());">
                <input type="reset" name="reset" value="����">
              </td>
            </tr>
          </table>
        </form> 
	<% } %>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>
  <br>
</div>
</body>
</html>
<% book.close();%>