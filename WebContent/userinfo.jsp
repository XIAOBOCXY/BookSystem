<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.indent" %>
<jsp:useBean id="my_indent" scope="page" class="org.pan.web.purchase" />
<%

String username = (String)session.getAttribute("username");
if ( username == null || username.equals("") ){
	response.sendRedirect("login.jsp?msg=nologin");
}

%>

<%
String mesg = "";
String Uid = (String) session.getAttribute("userid");
long uid = 0;
try {
	uid = Long.parseLong(Uid);
} catch (Exception e) {
	uid =0;
	mesg = "出现不可预知错误!";
}
if (!my_indent.getIndent(uid))
	mesg = "你在本站还没有购买过图书。"	;
%>

<html>
<head>
<title>购书网--我的</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',top=200,left=550,resizable=1,scrollbars=yes,menubar=no,status=yes' );
}

</script>
</head>

<body>
<div align="center">
<br><br>
	<p>购书网</p>
  <table>
    <tr> 
      <td width="100"><a href="index.jsp">首页</a></td>
      <td width="100"><a href="booklist.jsp">购物</a></td>
      <td width="100"><a href="shoperlist.jsp">购物车</a></td>
      <td width="100"><a href="userinfo.jsp">我的</a></td>
      <td width="100"><a href="login.jsp">退出</a></td>
    </tr>
  </table>

<hr>


  <br>
  <table>
    <tr> 
      <td align="center"> 
        <p><br>
          我的订单</p>
<%if (!mesg.equals("")) {
		out.println("<p><font color=red>" + mesg + "</font></p>");
} else {   %>
        <table width="100%" border="1"  >
          <tr align="center"> 
            <td>订单号</td>
            <td>提交时间</td>
            <td>总金额</td>
            <td>付款</td>
            <td>发货</td>
            <td>详情</td>
          </tr>
	<%for (int i = 0; i<my_indent.getMy_indent().size();i++){
		indent Ident = (indent) my_indent.getMy_indent().elementAt(i);
			%>
          <tr> 
            <td><%=Ident.getIndentNo() %></td>
            <td align="center"><%= Ident.getSubmitTime() %></td>
            <td align="center"><%= Ident.getTotalPrice() %></td>
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
            <td align="center"><a href="#" onClick="openScript('showindent.jsp?id=<%= Ident.getId() %>&orderno=<%=Ident.getIndentNo() %>','indentlist',500,500);" >查看</a></td>
          </tr>
		<%}%>
        </table>
<%} %>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>

  
</div>
</body>
</html>
