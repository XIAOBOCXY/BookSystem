<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.books" %>
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<%
String mesg = "";
int Id=0;
if (request.getParameter("bookid")==null || request.getParameter("bookid").equals("")) {
		mesg = "你要查看的图书不存在！";
} else {
	try {
		Id = Integer.parseInt(request.getParameter("bookid"));
		if (!book.getOnebook(Id)){
			mesg = "你要查看的图书不存在！";
		}
	} catch (Exception e){
		mesg = "你要查看的图书不存在！";
	}
}

%>

<html>
<head>
<title>购书网--查看图书详细信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">


</script>

</head>

<body >
<div align="center">
  <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		books bk = (books) book.getBooklist().elementAt(0);			  
	%>
  <table>
    <form name="form1" method="post" action="purchase.jsp">
      <tr> 
        <td align="right" width="120">图书名称：</td>
        <td><%= bk.getBookName() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">作者：</td>
        <td><%= bk.getAuthor() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">所属类别：</td>
        <td><%= bk.getClassname() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">出版社：</td>
        <td><%= bk.getPublish() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">书号：</td>
        <td><%= bk.getBookNo() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">书价：</td>
        <td><%= bk.getPrince() %></td>
      </tr>
      <tr> 
        <br><br>
      </tr>
   </form>
  </table>
<% } %>
</div>
</body>
</html>
