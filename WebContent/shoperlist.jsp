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
		mesg = "ɾ���嵥�е�ͼ��ʱ����" ;
	}
}else if (payoutCar != null && !payoutCar.equals("") ) {
	if (shop.payout(request) ) {
		mesg = "�ύ�ɹ�!";
		session.removeAttribute("shopcar");
	} else {
		if(!shop.getIsLogin())
			mesg = "�㻹û�е�¼������<a href=login.jsp>��¼</a>�����ύ";
		else
			mesg = "�Բ����ύ�������Ժ�����"; 
	}	
} else if (clearCar != null && ! clearCar.equals("") ) {
	session.removeAttribute("shopcar");
	mesg = "�����";
}


%>

<html>
<head>
<title>������--���ﳵ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
function checklogin() {
	if (document.payout.userid.value=="")
	{
		alert("�㻹û�е�¼�����¼�����ύ�����嵥");
		return false;
	}
	return true;
}

function check()
{
	if (document.change.amount.value<1){
		alert("��Ĺ�������������");
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
	<p>������</p>
  <table>
    <tr> 
      <td width="100"><a href="index.jsp">��ҳ</a></td>
      <td width="100"><a href="booklist.jsp">����</a></td>
      <td width="100"><a href="shoperlist.jsp">���ﳵ</a></td>
      <td width="100"><a href="userinfo.jsp">�ҵ�</a></td>
      <td width="100"><a href="login.jsp">�˳�</a></td>
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
		out.println("<p>���ȹ���ͼ��</p>");
} else {
%>
        <p>�ҵĹ��ﳵ��Ʒ�б�</p>
        
       <table  border="1" >
          <tr align="center"> 
            <td>ͼ������</td>
            <td>����</td>
            <td>ͼ�����</td>
            <td>����</td>
            <td>����</td>
            <td colspan =2>ѡ��</td>
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
			 <input type="submit" name="del" value="ɾ��">
            </td></form>
          </tr>
		<% } 
	} %>  
        </table>
        <br>
		  �ܽ��:<%= totalprice%>Ԫ&nbsp;&nbsp;��������<%= totalamount%>��&nbsp;
       <p></p>
          <table width="90%" border="0" cellspacing="1" cellpadding="1">
            <tr> <form name="payout" method="post" action="shoperlist.jsp">
              <td align="center" >             
				<input type="hidden" name="userid" value="<%= userid %>">
				<input type="hidden" name="totalprice" value="<%= totalprice %>">
				<TEXTAREA NAME="content" ROWS="5" COLS="40">���ԣ�</TEXTAREA><br>
			  <input type="submit" name="payout" value="�ύ���ﳵ" onClick="javascript:return(checklogin());">
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
