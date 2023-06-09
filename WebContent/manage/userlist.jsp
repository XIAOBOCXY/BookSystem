<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="org.pan.web.book.shopuser" %>
<jsp:useBean id="user" scope="page" class="org.pan.web.usermn" />
<%
int pages=1;
String mesg = "";

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "你要找的页码错误!";
	}
	user.setPage(pages);
}

if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try{
		long id = Long.parseLong(request.getParameter("userid"));
		if (user.delete(id)) {
			mesg = "删除操作成功";
		} else {
			mesg = "删除操作出错";
		}
	} catch (Exception e) {
		mesg = "您要删除的用户号错误";
	}
}

%>

<html>
<head>
<title>PFC购书网管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
<!--
function checkform() {
	if (document.form1.username.value=="" || document.form1.passwd.value==""){
		alert("用户名或密码为空！");
		return false;
	}
	return true;

}

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
-->
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
      <td width="100"><a href="main.jsp">回管理首页</a></td>
      <td width="100"><a href="booklist.jsp">商店图书查询</a></td>
      <td width="100"><a href="addbook.jsp">添加图书资料</a></td>
      <td width="100"><a href="orderlist.jsp">订单信息查询</a></td>
      <td width="100"><a href="userlist.jsp">用户信息查询</a></td>
      <td width="100"><a href="logout.jsp">退出</a></td>
    </tr>
  </table>
  <table width="100%" border="0" >
    <tr>
      <td align="center" width="100%">
        <p>购书网用户情况</p>
        <% if (!mesg.equals("")) out.println("<font color=red>"+ mesg +"</font><br><br>");%>
        <table width="95%" border="1">
          <tr align="center"> 
            <td>用户ID号</td>
            <td>用户名</td>
            <td>真实姓名</td>
            <td>联系地址</td>
            <td>联系电话</td>
			<td>Email</td>
			<td>查看</td>
          </tr>
<% 
if (user.execute()){
	for(int i=0; i<user.getUserlist().size(); i++){
		shopuser userinfo = (shopuser) user.getUserlist().elementAt(i);
%>
          <tr>
            <td align=center><%= userinfo.getId()%></td>
            <td><%= userinfo.getUserName()%></td>
            <td><%= userinfo.getNames()%></td>
            <td><%= userinfo.getAddress()%></td>
            <td><%= userinfo.getPhone()%></td>
			<td><%= userinfo.getEmail()%></td>
            <td align=center><a href="#" onClick="openScript('showuser.jsp?userid=<%= userinfo.getId() %>','showuser',450,500)">详细资料</a>&nbsp;<a href="#" onClick="openScript('modiuser.jsp?userid=<%= userinfo.getId() %>','modis',450,500)">修改</a>&nbsp;<a href="userlist.jsp?userid=<%= userinfo.getId()%>&page=<%= user.getPage()%>&action=del" onClick="return(confirm('你真的要删除这个用户?'))">删除</a></td>
          </tr>
<%	}
}%>

        </table>
		<table width="90%" border="0">
          <tr>
            <td align="right">当前页第<%= user.getPage() %>页　<a href="userlist.jsp">首页</a>&nbsp; 
              <% if (user.getPage()>1) {%>
              <a href="userlist.jsp?page=<%= user.getPage()-1 %>">上一页</a>&nbsp; 
              <% } %>
              <% if (user.getPage()<user.getPageCount()-1) {%>
              <a href="userlist.jsp?page=<%= user.getPage()+1 %>">下一页</a>&nbsp; 
              <% } %>
              <a href="userlist.jsp?page=<%= user.getPageCount() %>">未页</a>&nbsp;</td>
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
