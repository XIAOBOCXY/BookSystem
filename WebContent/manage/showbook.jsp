<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.books" %>
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<%
String mesg = "";
int Id=0;
if (request.getParameter("bookid")==null || request.getParameter("bookid").equals("")) {
		mesg = "你您要查看的图书不存在！";
} else {
	try {
		Id = Integer.parseInt(request.getParameter("bookid"));
		if (!book.getOnebook(Id)){
			mesg = "您要查看的图书不存在！";
		}
	} catch (Exception e){
		mesg = "您要查看的图书不存在！";
	}
}

%>

<html>
<head>
<title>购书网--查看图书资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
function check()
{
	if (document.form1.amount.value<1){
		alert("您的购买数量错误");
		document.form1.amount.focus();
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
  <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		books bk = (books) book.getBooklist().elementAt(0);			  
	%>
  <table width="100%" border="0" >
      <tr> 
        <td align="right" width="50%">图书名称：</td>
        <td><%= bk.getBookName() %></td>
      </tr>
      <tr> 
        <td align="right" width="50%">作者：</td>
        <td><%= bk.getAuthor() %></td>
      </tr>
      <tr> 
        <td align="right" width="50%">所属类别：</td>
        <td><%= bk.getClassname() %></td>
      </tr>
      <tr> 
        <td align="right" width="50%">出版社：</td>
        <td><%= bk.getPublish() %></td>
      </tr>
      <tr> 
        <td align="right" width="50%">书号：</td>
        <td><%= bk.getBookNo() %></td>
      </tr>
      <tr> 
        <td align="right" width="50%">书价：</td>
        <td><%= bk.getPrince() %></td>
      </tr>
      <tr> 
        <td align="right" width="50%">总数量</td>
        <td><%= bk.getAmount() %></td>
      </tr> 
	  <tr> 
        <td align="right" width="50%">剩余数量</td>
        <td><%= bk.getLeav_number() %></td>
      </tr> 
	  
      
  </table>
<% } %>
  <br>
  <p><a href="javascript:window.close()">关闭窗口</a></p>
</div>
</body>
</html>
