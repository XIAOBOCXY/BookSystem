<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="org.pan.web.book.bookclass" %>
<%@ page session="true" %>
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />

<html>
<head>
<title>购书网--首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<style type="text/css">
</style></head>

<body>
<div align="center">
<br><br>
	<p>购书网首页</p>
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

  <table>
    <tr> 

      <td width="500"><div align="center">
        <p><br>本店图书精品     </p></div>    
        <table>
          <tr>
            <td width="50%">使用JSP开发WEB应用</td>
            <td width="50%" rowspan="5"><div align="center"><img src="images/book.jpg" width="100" height="140" "></div></td>
          </tr>
          <tr>
            <td width="50%">作者： 王永茂 著</td> 
          </tr>
          <tr>
          	<td width="50%">ISBN：222222</td> 
          </tr>
          <tr>
          	<td width="50%">出版日期：2010-1-1</td> 
          </tr>
          <tr>
          	<td width="50%">出版社：清华大学出版社</td> 
          </tr>
          <tr> 
            <td colspan="2"> 
              <p>内容简介：</p>            
              <p align="left">掌握JSP 2.0规范技术，包括开发和部署JSP，创建标签和标签文件；联合使用JSP、JavaBean、表达式语言（EL）、自定义标签以及JSTL标签库创建Web应用，最后结合Servlet技术完成Web应用的开发；独立设计基于MVC的企业应用。</p>
            </td>
          </tr>
        </table>  
            
        
      <td width="160" align="center"> 
      <table>
        <tr>
          <td width="20" height="10">&nbsp;</td>
          <td><br>图书分类：</td>
        </tr>
        <% if (classlist.excute()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>
        <tr>
          <td width="20" height="34">&nbsp;</td>
          <td><a href="booklist.jsp?classid=<%= bc.getId()%>"><%= bc.getClassName() %></a></td>
        </tr>
        <%		}			
		}%>
        </table>
  </table>
</div>
</body>
</html>
