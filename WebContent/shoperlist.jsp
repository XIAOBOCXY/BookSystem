<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="org.pan.web.book.bookclass" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.books"%>
<%@ page import="org.pan.web.booksmn" %>
<%@ page import="org.pan.web.book.indentlist" %>
<jsp:useBean id="book_list" scope="page" class="org.pan.web.booksmn" />
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />
<jsp:useBean id="shop" scope="page" class="org.pan.web.purchase" />

<% 
String userid = (String) session.getAttribute("userid");
if ( userid == null )
	userid = "";
String del = request.getParameter("del");
String payoutCar = request.getParameter("payout");
String clearCar = request.getParameter("clear");
String mesg = "";

if ( del != null && !del.equals("") ) {
	if ( !shop.delShoper(request) ) {
		mesg = "删除清单中的图书时出错！" ;
	}
}else if (payoutCar != null && !payoutCar.equals("") ) {
	if (shop.payout(request) ) {
		mesg = "提交成功!";
		session.removeAttribute("shopcar");
	} else {
		if(!shop.getIsLogin())
			mesg = "你还没有登录，请先<a href=login.jsp>登录</a>后再提交";
		else
			mesg = "对不起，提交出错，请稍后重试"; 
	}	
} else if (clearCar != null && ! clearCar.equals("") ) {
	session.removeAttribute("shopcar");
	mesg = "已清空";
}


%>

<html>
<head>
<title>购书网--购物车</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
function checklogin() {
	if (document.payout.userid.value=="")
	{
		alert("你还没有登录，请登录后再提交购物清单");
		return false;
	}
	return true;
}

function check()
{
	if (document.change.amount.value<1){
		alert("你的购买数量有问题");
		document.change.amount.focus();
		return false;
	}
	return true;
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

  <table width="800" border="0" >
    <tr> 
      <td align="center"> 
      <%
if (!mesg.equals("") )
	out.println("<p >" + mesg + "</p>");

Vector shoplist = (Vector) session.getAttribute("shopcar");
if (shoplist==null || shoplist.size()<0 ){
	if (mesg.equals(""))
		out.println("<p>请先购买图书</p>");
} else {
%>
        <p>我的购物车商品列表</p>
        
       <table  border="1" >
          <tr align="center"> 
            <td>图书名称</td>
            <td>作者</td>
            <td>图书类别</td>
            <td>单价</td>
            <td>数量</td>
            <td colspan =2>选择</td>
          </tr>
	<% 
	float totalprice =0;
	int totalamount = 0;
	for (int i=0; i<shoplist.size();i++){
		indentlist iList = (indentlist) shoplist.elementAt(i);	
		if (book_list.getOnebook((int)iList.getBookNo())) {
			books bk = (books) book_list.getBooklist().elementAt(0);
			totalprice = totalprice + bk.getPrince() * iList.getAmount();
			totalamount = totalamount + iList.getAmount();
	%>
          <tr>
            <td><%= bk.getBookName() %></td>
            <td align="center"><%= bk.getAuthor() %></td>
            <td align="center"><%= bk.getClassname() %></td>
            <td align="center"><%= bk.getPrince() %></td>
            <td align="center"><%= iList.getAmount() %></td>
            <td align="center" >
			<form name="del" method="post" action="shoperlist.jsp">
			 <input type="hidden" name="bookid" value="<%= iList.getBookNo() %>" >
			 <input type="submit" name="del" value="删除">
            </td></form>
          </tr>
		<% } 
	} %>  
        </table>
        <br>
		  总金额:<%= totalprice%>元&nbsp;&nbsp;总数量：<%= totalamount%>本&nbsp;
       <p></p>
          <table width="90%" border="0" cellspacing="1" cellpadding="1">
            <tr> <form name="payout" method="post" action="shoperlist.jsp">
              <td align="center" >             
				<input type="hidden" name="userid" value="<%= userid %>">
				<input type="hidden" name="totalprice" value="<%= totalprice %>">
				<TEXTAREA NAME="content" ROWS="5" COLS="40">附言：</TEXTAREA><br>
			  <input type="submit" name="payout" value="提交购物车" onClick="javascript:return(checklogin());">
			  &nbsp;</td></form>

            </tr>
          </table>
        </form>
<% } %>
      </td>
    </tr>
  </table>
</div>
</body>
</html>
