<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>

<%@ page import="org.pan.web.book.*" %>
<jsp:useBean id="myIndentlist" scope="page" class="org.pan.web.purchase" />
<jsp:useBean id="mybook" scope="page" class="org.pan.web.booksmn" />
<jsp:useBean id="user" scope="page" class="org.pan.web.usermn" />

<%
String mesg = "";
long Id=0;
String submit= request.getParameter("submit");
if (submit!=null && !submit.equals("")){
	if (myIndentlist.update(request))
		mesg = "更新订单状态成功！";
	else 
		mesg = "更新订单状态出错!";
}

if (request.getParameter("indentid")==null || request.getParameter("indentid").equals("")) {
		mesg = "您要查看的订单清单不存在！";
} else {
	try {
		Id = Long.parseLong(request.getParameter("indentid"));
		if (!myIndentlist.getOneIndent(Id) || !myIndentlist.getIndentList(Id)){
			mesg = "您要查看的订单清单不存在！";
		}
	} catch (Exception e){
		mesg = "您要查看的订单清单不存在！";
	}
}



%>

<html>
<head>
<title>购书网管理系统--查看订购清单资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

  function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
</script>

<link rel="stylesheet" href="books.css" type="text/css">
<style type="text/css">

body {
	background-color: #ccccccc;
}
</style></head>

<body onLoad="javascript:window.focus();" >
<div align="center">
  
  <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		indent Ident = (indent) myIndentlist.getMy_indent().elementAt(0);
	%>
		<p>购书网图书订单<%= Ident.getIndentNo() %>&nbsp;清单:</p>
          <table width="100%" border="1" cellspacing="1" cellpadding="1" bordercolor="#cccccc">
          <tr align="center"> 
            <td>图书名称</td>
            <td>作者</td>
            <td>图书类别</td>
            <td>单价</td>
            <td>数量</td>
          </tr>
	<%
	float totalprice =0;
	int totalamount = 0;
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
	<%	totalprice = totalprice + bk.getPrince() * idList.getAmount();
		totalamount = totalamount + idList.getAmount();
		} %>
	
<%   }%><tr align="center"> 
            <td colspan=5 >购买的总金额是：<%= totalprice %>元,总数量是<%= totalamount%>本</td> </tr>
		</table>
  <br>
  <table width="95%" border="1" cellspacing="2" cellpadding="1" bordercolor="#cccccc">
    <tr> 
      <td width="40%" align="right">下单用户：</td>
      <td width="60%"><%
				if (user.getUserinfo(Ident.getUserId()) ) {
					shopuser userinfo = (shopuser)user.getUserlist().elementAt(0); %>
				<a href="#" onClick="openScript('showuser.jsp?userid=<%= Ident.getUserId() %>','showuser',450,500)"><%= userinfo.getUserName() %></a>
			<%} else {
					out.println("该用户已被删除");
				}			
			%></td>
    </tr>
    <tr> 
      <td width="40%" align="right">下单时间：</td>
      <td width="60%"><%= Ident.getSubmitTime() %></td>
    </tr>
    <tr> 
      <td width="40%" align="right">交货时间：</td>
      <td width="60%"><%= Ident.getConsignmentTime() %>&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" align="right">总金额：</td>
      <td width="60%"><%= Ident.getTotalPrice() %>&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" align="right">下单时IP：</td>
      <td width="60%"><%= Ident.getIPAddress() %>&nbsp;</td>
    </tr>
	<form name="form1" method="post" action="indentlist.jsp" >
    <tr> 
      <td width="40%" align="right">是否付款：</td>
      <td width="60%"> 
        <input type="radio" name="payoff" value="1" <%if (!Ident.getIsPayoff()) out.print("checked") ; %>>
        否<input type="radio" name="payoff" value="2" <%if (Ident.getIsPayoff()) out.print("checked") ; %>>
        是</td>
    </tr>
    <tr> 
      <td width="40%" align="right">是否交货：</td>
      <td width="60%"> 
        <input type="radio" name="sales" value="1" <%if (!Ident.getIsSales()) out.print("checked") ; %>>
        否<input type="radio" name="sales" value="2" <%if (Ident.getIsSales()) out.print("checked") ; %>>
        是</td>
    </tr>
    <tr>
      <td width="40%" align="right"></td>
      <td width="60%">
		<input type="hidden" name="indentid" value="<%= Id %>">
        <input type="submit" name="submit" value="更新">
      </td>
    </tr>
  </form>
  </table>
  <br>

<% } %>
  <br><p><a href="javascript:window.close()">关闭窗口</a></p>
</div>
</body>
</html>
<%mybook.close();
myIndentlist.close();
user.close();%>