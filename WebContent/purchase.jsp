<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.books" %>
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<jsp:useBean id="shop" scope="page" class="org.pan.web.purchase" />

<%
String mesg = "";
String submits = request.getParameter("Submit");
int Id=0;
if (submits!=null){
	if (shop.addnew(request)){
		mesg = "�ɹ����빺�ﳵ��";
	} else if (shop.getIsEmpty()){
		mesg = "��治�㣡ֻʣ"+shop.getLeaveBook()+"��";
	} else {
		mesg = "����ʧ�ܣ�";
	}
}else {
	if (request.getParameter("bookid")==null) {
			mesg = "��ͼ�鲻����";
	} else {
		try {
			Id = Integer.parseInt(request.getParameter("bookid"));
			if (!book.getOnebook(Id)){
				mesg = "��ͼ�鲻����";
			}
		} catch (Exception e){
			mesg = "��ͼ�鲻����";
		}
	}
}
%>
<html>
<head>
<title>������--����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script>

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',top=200,left=550,resizable=1,scrollbars=yes,menubar=no,status=yes' );
}



</script>
</head>

<body onLoad="javascript:window.focus();">
<div align="center">
   <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		books bk = (books) book.getBooklist().elementAt(0);			  
	%>
	<br><br>
  <table>
    <form name="form1" method="post" action="purchase.jsp">
      <tr> 
        <td align="center">ͼ�����ƣ�<%= bk.getBookName() %></td>
      </tr>
      <tr> 
        <td  align="center">���������� 
            <input type="text" name="amount" maxlength="4" size="3" value="1"> 
   		</td>
      </tr>
      <tr> 
        <td align="center">
		  <input type="hidden" name="bookid" value="<%=Id %>">
          <input type="submit" name="Submit" value="�� ��" >
          <input type="reset" name="Reset" value="ȡ ��">
        </td>
      </tr>
   </form>
  </table>
<% } %>
  <br>
</div>
</body>
</html>
