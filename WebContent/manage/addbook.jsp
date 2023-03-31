<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="org.pan.web.book.bookclass"%>
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<%
	String mesg = "";
	String submit = request.getParameter("Submit");
	if (submit!=null && !submit.equals("")){		
		if(book.getRequest(request)){
			if(book.insert()){
				mesg = "新图书资料提交成功！";
			} else {
				mesg = "数据库操作失败";
			}
		}else {
			mesg = "对不起，你提交的参数有错误";
		}
	}
%>

<html>
<head>
<title>购书网管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
  function checkform() {
	if (document.form1.bookname.value=="") {
		document.form1.bookname.focus();
		alert("图书名称不能为空!");
		return false;
	}
	if (document.form1.author.value=="") {
		alert("作者名不能为空!");
		document.form1.author.focus();
		return false;
	}

	return true;

  }
</script>
<link rel="stylesheet"  type="text/css">
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
  <table width="100%" border="0">
    <tr>
      <td align="center" width="100%"> 
        <p><br>
         添加新的图书信息</p>
		  <% if(!mesg.equals("")){
			out.println(mesg);
		  }%>
        <form name="form1" method="post" action="addbook.jsp">
          <table >
            <tr> 
              <td align="right" width="50%"><div align="right" >图书名称：</div></td>
              <td width="50%"> 
                <input type="text" name="bookname" maxlength="40" size="10">
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right">作者：</div></td>
              <td width="50%"> 
                <input type="text" name="author" maxlength="25" size="10">
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right">出版社：</div></td>
              <td width="50%"> 
                <input type="text" name="publish" size="10" maxlength="150">
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right" >所属类别：</div></td>
              <td width="50%"> 
                <select name="bookclass">
		<% if (classlist.excute()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>
			      <option value="<%= bc.getId()%>"><%= bc.getClassName() %></option>
		<%		}			
		}%>	
					
                </select>
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right" >书号：</div></td>
              <td width="50%"> 
                <input type="text" name="bookno" size="10" maxlength="30">
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right">定价：</div></td>
              <td width="50%"> 
                <span class="style4">
                <input type="text" name="price" size="10" maxlength="10">
                元</span></td>
            </tr>
            <tr> 
              <td align="right" width="50%"><div align="right" >总数量：</div></td>
              <td width="50%"> 
                <span class="style4">
                <input type="text" name="amount" size="10" maxlength="10">
                本</span></td>
            </tr>
            <tr> 
              <td align="right" width="50%" valign="top"><div align="right" >图书简介：</div></td>
              <td width="50%"> 
                <textarea name="content" cols="15" rows="3"></textarea>
              </td>
            </tr>
            <tr> 
              <td align="right" width="50%">&nbsp;</td>
              <td width="50%"> 
                <input type="submit" name="Submit" value="提交" onClick="return(checkform());">
                <input type="reset" name="reset" value="重置">
              </td>
            </tr>
          </table>
        </form>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>
  <br>
</div>
</body>
</html>
<% book.close();%>