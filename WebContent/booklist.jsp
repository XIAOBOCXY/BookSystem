 <%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="org.pan.web.book.bookclass" %>
<%@ page import="org.pan.web.book.books"%>
<%@ page session="true" %>
<jsp:useBean id="book_list" scope="page" class="org.pan.web.booksmn" />
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />

<%
int pages=1;
if (request.getParameter("page")!=null) {
	String requestpage = request.getParameter("page");	
	pages = Integer.parseInt(requestpage);
	book_list.setPage(pages);
}
String classid = request.getParameter("classid");
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
<style type="text/css">
</style>


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

  <table >
    <tr> 
      <td width="200"> 
       
		<table >
		  <FORM name=form1 METHOD=POST ACTION="booklist.jsp">
		  
          <tr> 
            <td align=center>ͼ���ѯ��</td>
          </tr>
          
          <tr>
          
		  <td>���:
		    <SELECT NAME="classid">
				<option value="">�������</option>			
		 
		  <%if (classlist.excute()){
				for (int i=0;i<classlist. getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>		    
            		<option value="<%= bc.getId()%>"><%= bc.getClassName() %></option>
          <%	}		
			}	
			%></SELECT>
		    </td>
          </tr>
          
          <tr> 
            <td align="center"><INPUT TYPE="submit" name="submit" value="��ѯ" ></td>
          </tr>		  
    		</FORM>
        </table>
        
      </td>
      <td align="center"> 
        <p><br>���ͼ���б�</p>
		 
        <table border="1">
          <tr align="center" > 
            <td>ͼ������</td>
            <td>����</td>
            <td>ͼ�����</td>
            <td>������</td>
            <td>����</td>
            <td width=150>ѡ��</td>
          </tr>
		<% if (book_list.execute(request)) {
				if (book_list.getBooklist().size()>0 ){
					for (int i=0;i<book_list.getBooklist().size();i++){
						books bk = (books) book_list.getBooklist().elementAt(i);%>
			          <tr>
			            <td align="center"><%= bk.getBookName() %></td>
			            <td align="center"><%= bk.getAuthor() %></td>
			            <td align="center"><%= bk.getClassname() %></td>
			            <td align="center"><%= bk.getPublish() %></td>
			            <td align="center"><%= bk.getPrince() %></td>
			            <td align="center"><a href="#" onClick="openScript('purchase.jsp?bookid=<%= bk.getId() %>','pur',500,500)" >����</a>&nbsp;
						<a href="#" onClick="openScript('showbook.jsp?bookid=<%= bk.getId() %>','show',500,500)" >��ϸ����</a></td>
			          </tr>
			<%		} 
				}else { 
						out.println("<tr><td align='center' colspan=6>�޴���ͼ������</td></tr>");
				}
			} %>
			         

        </table>
        <table>
          <tr>
            <td align="center">�ܼƽ��Ϊ<%= book_list.getRecordCount() %>������ǰҳ��<%= book_list.getPage() %>ҳ��<a href="booklist.jsp?classid=<%= classid%>">��ҳ</a>&nbsp; 
              <% if (book_list.getPage()>1) {%>
              <a href="booklist.jsp?page=<%= book_list.getPage()-1 %>&classid=<%= classid%>">��һҳ</a>&nbsp; 
              <% } %>
              <% if (book_list.getPage()<book_list.getPageCount()-1) {%>
              <a href="booklist.jsp?page=<%= book_list.getPage()+1 %>&classid=<%= classid%>">��һҳ</a>&nbsp; 
              <% } %>
              <a href="booklist.jsp?page=<%= book_list.getPageCount() %>&classid=<%= classid%>">ĩҳ</a>&nbsp;</td>
          </tr>
        </table>
    </tr>
  </table>

</div>
</body>
</html>
<% book_list.close();%>