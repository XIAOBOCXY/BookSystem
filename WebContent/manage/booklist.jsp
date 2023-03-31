<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="org.pan.web.book.books"%>
<jsp:useBean id="book_list" scope="page" class="org.pan.web.booksmn" />
<%
int pages=1;
String mesg = "";

if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try {
		int delid = Integer.parseInt(request.getParameter("id"));
		if (book_list.delete(delid)){
			mesg = "删除成功！";
		} else {
			mesg = "删除出错！";
		}
	} catch (Exception e){
		mesg = "您要删除的对象错误!";
	}
}

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "您要找的页码错误!";
	}
}


%>

<html>
<head>
<title>购书网管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
</script>
<link rel="stylesheet" type="text/css">
<style type="text/css">
body {
	
}
</style></head>

<body >
<div align="center">
<table>
    <tr> 
      <td width="100"><a href="main.jsp">回管理首页</a></td>
      <td width="100"><a href="booklist.jsp">商店图书查询</a></td>
      <td width="100"><a href="addbook.jsp">添加图书资料</a></td>
      <td width="100"><a href="orderlist.jsp">订单信息查询</a></td>
      <td width="100"><a href="userlist.jsp">用户信息查询</a></td>
      <td width="100"><a href="logout.jsp">退出</a></td>
    </tr>
  </table>
  <table >
    <tr>
      <td align="center" width="100%">
        <p>&nbsp;<% if (!mesg.equals("")) out.println(mesg);%></p>
        <p>书店图书情况</p>
        <table width="100%" border="1">
          <tr align="center"> 
            <td>编号</td>
            <td>图书名</td>
            <td>作者</td>
            <td>类别</td>
            <td>单价</td>
            <td>总数量</td>
            <td>剩余数</td>
            <td>动作</td>
          </tr>
<% if (book_list.execute(request)) {
	for (int i=0;i<book_list.getBooklist().size();i++){
		books bk = (books) book_list.getBooklist().elementAt(i);
%>
          <tr> 
            <td align="center"><%=bk.getId() %></td>
            <td><a href="#" onClick="openScript('showbook.jsp?bookid=<%= bk.getId() %>','sbook',450,500);"><%= bk.getBookName() %></a></td>
            <td align="center"><%= bk.getAuthor() %></td>
            <td align="center"><%= bk.getClassname() %></td>
            <td align="center"><%= bk.getPrince() %></td>
            <td align="center"><%= bk.getAmount() %></td>
            <td align="center"><%= bk.getLeav_number() %></td>
            <td align="center"><a href="modibook.jsp?id=<%= bk.getId() %>">修改</a>&nbsp;&nbsp;<a href="booklist.jsp?action=del&page=<%= pages %>&id=<%= bk.getId() %>" onClick="confirm('真的要删除吗');">删除</a></td>
          </tr>
<% }
} else {%>
          <tr> 
            <td align="center" colspan=8><span>&nbsp;网站正在维护中，请稍后......</span></td>
            
          </tr>
<% } %>
        </table>
        <br>
        <table width="100%" >
          <tr>
            <td align="right">当前页第<%= book_list.getPage() %>页　<a href="booklist.jsp">首页</a>&nbsp;
	<% if (book_list.getPage()>1) {%><a href="booklist.jsp?page=<%= book_list.getPage()-1 %>">上一页</a>&nbsp;<% } %>
	<% if (book_list.getPage()<book_list.getPageCount()-1) {%><a href="booklist.jsp?page=<%= book_list.getPage()+1 %>">下一页</a>&nbsp;<% } %>
				<a href="booklist.jsp?page=<%= book_list.getPageCount() %>">未页</a>&nbsp;</td>
          </tr>
        </table>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>
  <br>
</div>
</body>
</html>
<% book_list.close();%>