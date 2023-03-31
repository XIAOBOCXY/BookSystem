<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
String username = (String)session.getAttribute("username");
if ( username == null || username.equals("") ){
	response.sendRedirect("login.jsp?msg=nologin");
}
%>
<%@ page import="org.pan.web.book.books" %>
<%@ page import="org.pan.util.strFormat" %>
<%@ page import="org.pan.web.book.indentlist" %>
<%@ page import="org.pan.web.book.books" %>
<jsp:useBean id="myIndentlist" scope="page" class="org.pan.web.purchase" />
<jsp:useBean id="mybook" scope="page" class="org.pan.web.booksmn" />
<%
String mesg = "";
long Id=0;
String indentNo = request.getParameter("orderno");
if (indentNo==null) indentNo="";
if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
		mesg = "�����嵥�����ڣ�";
} else {
	try {
		Id = Long.parseLong(request.getParameter("id"));
		if (!myIndentlist.getIndentList(Id)){
			mesg = "�����嵥�����ڣ�";
		}
	} catch (Exception e){
		mesg = "�����嵥�����ڣ�";
	}
}

%>

<html>
<head>
<title>������--�鿴�����嵥��Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body  onLoad="javascript:window.focus();" >
<div align="center">
  
  <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
	%><br><br><br>
		<p class="style1">������ͼ�鶩��<%= indentNo %>&nbsp;�嵥:</p>
<table width="100%" border="1" >
          <tr align="center"> 
            <td>ͼ������</td>
            <td>����</td>
            <td>ͼ�����</td>
            <td>����</td>
            <td>����</td>
          </tr>
	<%
	for (int i=0; i<myIndentlist.getIndent_list().size();i++){
		indentlist idList = (indentlist) myIndentlist.getIndent_list().elementAt(i);
		if (mybook.getOnebook((int)idList.getBookNo()) ){
			books bk = (books) mybook.getBooklist().elementAt(0);		
	%>	  
	      <tr align="center"> 
            <td><%= bk.getBookName() %></td>
            <td><%= bk.getAuthor() %></td>
            <td><%= bk.getClassname() %></td>
            <td><%= bk.getPrince() %></td>
            <td><%= idList.getAmount() %></td>
          </tr>
	<%
		}
	}%>
		</table>
<% } %>
</div>
</body>
</html>
<%mybook.close();%>