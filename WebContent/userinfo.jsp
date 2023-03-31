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
	mesg = "���ֲ���Ԥ֪����!";
}
if (!my_indent.getIndent(uid))
	mesg = "���ڱ�վ��û�й����ͼ�顣"	;
%>

<html>
<head>
<title>������--�ҵ�</title>
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


  <br>
  <table>
    <tr> 
      <td align="center"> 
        <p><br>
          �ҵĶ���</p>
<%if (!mesg.equals("")) {
		out.println("<p><font color=red>" + mesg + "</font></p>");
} else {   %>
        <table width="100%" border="1"  >
          <tr align="center"> 
            <td>������</td>
            <td>�ύʱ��</td>
            <td>�ܽ��</td>
            <td>����</td>
            <td>����</td>
            <td>����</td>
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
					out.print("�Ѹ���");
				else
					out.print("δ��");
			%></td>
            <td align="center">
			<% if (Ident.getIsSales())
					out.print("�ѷ���");
				else 
					out.print("δ����");
			%></td>
            <td align="center"><a href="#" onClick="openScript('showindent.jsp?id=<%= Ident.getId() %>&orderno=<%=Ident.getIndentNo() %>','indentlist',500,500);" >�鿴</a></td>
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
