<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>

<%@ page import="org.pan.web.book.indent" %>
<%@ page import="org.pan.web.book.shopuser" %>
<jsp:useBean id="shop" scope="page" class="org.pan.web.purchase" />
<jsp:useBean id="user" scope="page" class="org.pan.web.usermn" />

<%
int pages=1;
String mesg = "";
if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try {
		long id = Long.parseLong(request.getParameter("indentid"));
		if (shop.delete(id)) {
			mesg = "删除订单资料成功！";
		} else {
			mesg = "删除订单出错！";
		}
	} catch (Exception e) {
		mesg ="您要删除的数据参数出错！";
	}
}

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "您要找的页码错误!";
	}
	shop.setPage(pages);
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
<link rel="stylesheet"  type="text/css">
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
  <table width="100%" border="0">
    <tr>
      <td align="center" width="100%">
        <p >购书网订单情况</p>
		<% if (!mesg.equals("")) out.println( mesg );%>
        <table width="98%" border="1" >
          <tr align="center"> 
            <td>订单编号</td>
            <td>用户名</td>
            <td>下单时间</td>
			<td>交货时间</td>
            <td>总金额</td>
			<td>订货IP</td>
			<td>付款</td>
            <td>发货</td>
            <td>查看</td>
          </tr>
<%
  if (shop.getIndent()) {
		for(int i=0 ; i<shop.getMy_indent().size(); i++){
			indent Ident = (indent) shop.getMy_indent().elementAt(i);	%>
		  <tr>
            <td><%= Ident.getIndentNo() %></td>
            <td align="center"><%
				if (user.getUserinfo(Ident.getUserId()) ) {
					shopuser userinfo = (shopuser)user.getUserlist().elementAt(0); %>
				<a href="#" onClick="openScript('showuser.jsp?userid=<%= Ident.getUserId() %>','showuser',450,500)"><%= userinfo.getUserName() %></a>
			<%} else {
					out.println("该用户已被删除");
				}			
			%></td>
            <td align="center"><%= Ident.getSubmitTime() %></td>
			<td align="center"><%= Ident.getConsignmentTime() %></td>
            <td align="center"><%= Ident.getTotalPrice() %></td>
			<td align="center"><%= Ident.getIPAddress() %></td>
			<td align="center">
			<% if (Ident.getIsPayoff() )
					out.print("已付清");
				else
					out.print("未付");
			%></td>
            <td align="center">
			<% if (Ident.getIsSales())
					out.print("已发货");
				else 
					out.print("未发货");
			%></td>
            <td align="center"><a href="#"  onclick="openScript('indentlist.jsp?indentid=<%= Ident.getId() %>','indent',500,500)" >详细情况</a>&nbsp;<a href="orderlist.jsp?action=del&indentid=<%= Ident.getId()%>&page=<%= shop.getPage() %>" onClick="return(confirm('你真的要删除吗？'))">删除</a></td>
          </tr>
<%		}
  }

%>

        </table>
		 <table width="90%" border="0" >
          <tr>
            <td align="right">当前页第<%= shop.getPage() %>页　<a href="orderlist.jsp">首页</a>&nbsp; 
              <% if (shop.getPage()>1) {%>
              <a href="orderlist.jsp?page=<%= shop.getPage()-1 %>">上一页</a>&nbsp; 
              <% } %>
              <% if (shop.getPage()<shop.getPageCount()-1) {%>
              <a href="orderlist.jsp?page=<%= shop.getPage()+1 %>">下一页</a>&nbsp; 
              <% } %>
              <a href="orderlist.jsp?page=<%= shop.getPageCount() %>">未页</a>&nbsp;</td>
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
<% shop.close();%>