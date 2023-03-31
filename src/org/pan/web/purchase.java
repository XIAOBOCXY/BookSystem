package org.pan.web;

import java.sql.*;
import java.util.Vector;
import org.pan.util.*;
import javax.servlet.http.*;
import org.pan.web.book.books;
import org.pan.web.book.indentlist;
import org.pan.web.book.indent;



public class purchase extends DataBase {
	private javax.servlet.http.HttpServletRequest request; 
	private HttpSession session;//服务器会为每一个用户 创建一个独立的HttpSession			
	private boolean sqlflag = true ;			
	private Vector purchaselist;//购买订单			
	private Vector my_indent;//我的订单					
	private Vector indent_list;//订单图书表					
	private int booknumber=0;						
	private float all_price=0;						
	private boolean isEmpty=false;				
	private int leaveBook=0;						
	private String IndentNo = "";					
	private boolean isLogin = true;				
	private int page = 1;					
	private int pageSize=15;				
	private int pageCount =0;				
	private long recordCount =0;			


	
	public purchase() throws Exception{
		super();
	}

	public Vector getPurchaselist() {
		return purchaselist;
	}

	public Vector getIndent_list() {
		return indent_list;
	}

	public Vector getMy_indent() {
		return my_indent;
	}

	public boolean getSqlflag() {
		return sqlflag;
	}

	public void setIsEmpty(boolean flag){
		isEmpty = flag;
	}
	public boolean getIsEmpty() {
		return isEmpty;
	}

	public void setLeaveBook(int bknum) {
		leaveBook = bknum;
	}
	public int getLeaveBook() {
		return leaveBook;
	}
	
	public void setIndentNo(String newIndentNo) {
		IndentNo = newIndentNo;
	}

	public String getIndentNo() {
		return IndentNo;
	}

	public void setIsLogin(boolean flag){
		isLogin = flag;
	}
	public boolean getIsLogin() {
		return isLogin;
	}

	public int getPage() {				
		return page;
	}
	public void setPage(int newpage) {
		page = newpage;
	}

	public int getPageSize(){			
		return pageSize;
	}
	public void setPageSize(int newpsize) {
		pageSize = newpsize;
	}

	public int getPageCount() {			
		return pageCount;
	}
	public void setPageCount(int newpcount) {
		pageCount = newpcount;
	}

	public long getRecordCount() {
		return recordCount;
	}
	public void setRecordCount(long newrcount) {
		recordCount= newrcount;
	}

	public String getGbk( String str) {
		try
		{
			return new String(str.getBytes("ISO8859-1"));
		}
		catch (Exception e)
		{
			return str;
		}
	}
	

	public boolean addnew(HttpServletRequest newrequest){//添加新的购物信息
		request = newrequest;
		String ID = request.getParameter("bookid");
		String Amount = request.getParameter("amount");
		long bookid = 0;
		int amount = 0;
		try
		{
			bookid = Long.parseLong(ID);
			amount = Integer.parseInt(Amount);
		}
		catch (Exception e)
		{
			return false;
		}
		if (amount<1) return false;
		session = request.getSession(false);
		if (session == null)
		{
			return false;
		}
		purchaselist = (Vector)session.getAttribute("shopcar");
		sqlStr = "select Leav_number from My_Book where Id=" + bookid;
		try
		{
			rs = stmt.executeQuery(sqlStr);
			if (rs.next())
			{
				if (amount > rs.getInt(1))
				{
					leaveBook = rs.getInt(1);//获取还剩下几本
					isEmpty = true;
					return false;
				}
			}
			rs.close();
		}
		catch (SQLException e)
		{
			return false;
		}

		indentlist iList = new indentlist();//订单图书表实例
		iList.setBookNo(bookid);
		iList.setAmount(amount);
		boolean match = false;	
		if (purchaselist==null)//本来没有订单  
		{
			purchaselist = new Vector();
			purchaselist.addElement(iList);
		}
		
		else {//本来已经有订单了 			
			for (int i=0; i< purchaselist.size(); i++) { //本来这本书已经加入了购物车
				indentlist itList= (indentlist) purchaselist.elementAt(i); 
				if ( iList.getBookNo() == itList.getBookNo() ) { 
					itList.setAmount(itList.getAmount() + iList.getAmount());//原先有的数量加上这一次购买的 
					purchaselist.setElementAt(itList,i);//更新这本书的数量 
					match = true; 
					break;
				} 			
			} 
			if (!match) //如果没有匹配上，添加新的记录到购物车
				purchaselist.addElement(iList); 
		}
		session.setAttribute("shopcar", purchaselist); 
		return true;
		
	}

	public boolean delShoper(HttpServletRequest newrequest) {//删除购物车的购物信息
		request = newrequest;
		String ID = request.getParameter("bookid");//获取删除的书的编号
		long bookid = 0;
		try
		{
			bookid = Long.parseLong(ID);
		}
		catch (Exception e)
		{
			return false;
		}
		session = request.getSession(false);
		if (session == null)
		{
			return false;
		}
		purchaselist = (Vector)session.getAttribute("shopcar");
		if (purchaselist==null)
		{
			return false;
		}

		for (int i=0; i< purchaselist.size(); i++) { 
			indentlist itList= (indentlist) purchaselist.elementAt(i); 
			if ( bookid == itList.getBookNo() ) { 
				purchaselist.removeElementAt(i);//从购物列表中删除 
				break;
			}  				
		} 
		return true;
	}



	public boolean payout(HttpServletRequest newrequest) throws Exception {//提交购物车
		  request = newrequest;
		  session = request.getSession(false);
		  if (session == null)
		  {
		   return false;
		  }
		  String Userid = (String) session.getAttribute("userid");//获取用户序列号  
		  long userid=0;
		  if (Userid==null || Userid.equals(""))
		  {
		   isLogin = false;
		   return false;
		  }else {
		   try
		   {
		    userid = Long.parseLong(Userid);
		   }
		   catch (NumberFormatException e)
		   {
		    return false;
		   }
		  }

		  purchaselist = (Vector)session.getAttribute("shopcar");
		  if (purchaselist==null || purchaselist.size()<0)
		  {
		   return false;
		  }
		  String Content = request.getParameter("content");//获取备注
		  if (Content==null)
		  {
		   Content="";
		  }
		  Content = getGbk(Content);
		  String IP = request.getRemoteAddr();
		  String TotalPrice = request.getParameter("totalprice");//获取总价

		  sqlStr = "select max(Id) from My_Indent";//获取最大订单号
		  rs = stmt.executeQuery(sqlStr);
		  if (rs.next())
		  {
		   IndentNo = "HYD" + userid + "" + rs.getString(1);
		  } else {
		   IndentNo =  "HYD" + userid + "0";
		  }
		  rs.close();

		  sqlStr = "insert into My_Indent (IndentNo,UserId,SubmitTime,ConsignmentTime,TotalPrice,Content,IPAddress,IsPayoff,IsSales) values ('";
		  sqlStr = sqlStr + IndentNo + "','";
		  sqlStr = sqlStr + userid + "',now(),adddate(now(),7),'";
		  sqlStr = sqlStr + TotalPrice + "','";
		  sqlStr = sqlStr + Content + "','";
		  sqlStr = sqlStr + IP + "',1,1)";
		  try//
		  {
		   stmt.execute(sqlStr);
		   sqlStr= "select max(Id) from My_Indent where UserId = " + userid;//获取最大的订单序列号
		   rs = stmt.executeQuery(sqlStr);
		   long indentid = 0;
		   while (rs.next())
		   {
		    indentid = rs.getLong(1);
		   }
		   rs.close();
		   for (int i=0; i<purchaselist.size() ;i++ )//对于购物车中的每一条购物记录，都要加到订单图书表中
		   {
		    indentlist iList = (indentlist) purchaselist.elementAt(i);
		    int newid2 = 1;
		    sqlStr = "select max(Id)+1 as newid from My_IndentList";//获取最大的订单图书表序列号
		    rs = stmt.executeQuery(sqlStr);
		    if (rs.next())
		    {
		     newid2 = rs.getInt("newid");
		    }

		    sqlStr = "insert into My_IndentList (IndentNo,BookNo,Amount) values (";
		    sqlStr = sqlStr + indentid + ",'";
		    sqlStr = sqlStr + iList.getBookNo() + "','";
		    sqlStr = sqlStr + iList.getAmount() + "')";
		    stmt.execute(sqlStr);
		    sqlStr = "update My_Book set Leav_number=Leav_number - " + iList.getAmount() + " where Id = " + iList.getBookNo();//更新书的余量
		    stmt.execute(sqlStr);
		   }
		   return true;
		  }
		  catch (SQLException e)
		  {
		   return false;
		  }
		    
		 }
	
	public boolean getOneIndent(long iid) {//获取某一个订单序列号的订单
		sqlStr = "select * from My_Indent where Id = '" +iid+ "' order by Id desc";
		try
		{
			rs = stmt.executeQuery(sqlStr);
			my_indent = new Vector();
			while (rs.next())
			{
				indent ind = new indent();
				ind.setId(rs.getLong("Id"));
				ind.setIndentNo(rs.getString("IndentNo"));
				ind.setUserId(rs.getLong("UserId"));
				ind.setSubmitTime(rs.getString("SubmitTime"));
				ind.setConsignmentTime(rs.getString("ConsignmentTime"));
				ind.setTotalPrice(rs.getFloat("TotalPrice"));
				ind.setContent(rs.getString("Content"));
				ind.setIPAddress(rs.getString("IPAddress"));
				if (rs.getInt("IsPayoff")==1)
					ind.setIsPayoff(false);
				else 
					ind.setIsPayoff(true);
				if (rs.getInt("IsSales")==1)
					ind.setIsSales(false);
				else
					ind.setIsSales(true);
				my_indent.addElement(ind);
			}
			rs.close();
			return true;			
		}
		catch (SQLException e)
		{
			return false;
		}		
	}
		    
		    
		    
	public boolean getIndent(long userid) {//获取某一个用户的订单
		sqlStr = "select * from My_Indent where UserId = '" +userid+ "' order by Id desc";
		try
		{
			rs = stmt.executeQuery(sqlStr);
			my_indent = new Vector();
			while (rs.next())
			{
				indent ind = new indent();
				ind.setId(rs.getLong("Id"));
				ind.setIndentNo(rs.getString("IndentNo"));
				ind.setUserId(rs.getLong("UserId"));
				ind.setSubmitTime(rs.getString("SubmitTime"));
				ind.setConsignmentTime(rs.getString("ConsignmentTime"));
				ind.setTotalPrice(rs.getFloat("TotalPrice"));
				ind.setContent(rs.getString("Content"));
				ind.setIPAddress(rs.getString("IPAddress"));
				if (rs.getInt("IsPayoff")==1)
					ind.setIsPayoff(false);
				else 
					ind.setIsPayoff(true);
				if (rs.getInt("IsSales")==1)
					ind.setIsSales(false);
				else
					ind.setIsSales(true);
				my_indent.addElement(ind);
			}
			rs.close();
			return true;			
		}
		catch (SQLException e)
		{
			return false;
		}		
	}



	public boolean getIndent() {//获取用户订单表
		sqlStr = "select count(*) from My_Indent";  
		int rscount = pageSize;
		try
		{
			ResultSet rs1 = stmt.executeQuery(sqlStr);
			if (rs1.next()) recordCount = rs1.getInt(1);//所有用户订单的数量				
			rs1.close();
		}
		catch (SQLException e)
		{
			return false;
		}
		
                
		if (recordCount < 1)
            pageCount = 0;
        else
            pageCount = (int)(recordCount - 1) / pageSize + 1;
		
		if (page < 1)  
            page = 1;
        else if (page > pageCount)
            page = pageCount;
		
		rscount = (int) recordCount % pageSize;	   

	
		sqlStr = "select * from My_Indent ";
		if (page == 1)
		{
			sqlStr = sqlStr + " order by Id desc";
		}else {
			sqlStr = sqlStr + " where Id not in ( select  Id from My_Indent order by Id ) and Id in " +
			"(select Id from My_Indent order by Id ) " + " order by Id desc";
		}

		try
		{
			rs = stmt.executeQuery(sqlStr);//所有订单的信息
			my_indent = new Vector();
			while (rs.next())
			{
				indent ind = new indent();
				ind.setId(rs.getLong("Id"));
				ind.setIndentNo(rs.getString("IndentNo"));
				ind.setUserId(rs.getLong("UserId"));
				ind.setSubmitTime(rs.getString("SubmitTime"));
				ind.setConsignmentTime(rs.getString("ConsignmentTime"));
				ind.setTotalPrice(rs.getFloat("TotalPrice"));
				ind.setContent(rs.getString("Content"));
				ind.setIPAddress(rs.getString("IPAddress"));
				if (rs.getInt("IsPayoff")==1)
					ind.setIsPayoff(false);
				else 
					ind.setIsPayoff(true);
				if (rs.getInt("IsSales")==1)
					ind.setIsSales(false);
				else
					ind.setIsSales(true);
				my_indent.addElement(ind);//存入my_indent
			}
			rs.close();
			return true;			
		}
		catch (SQLException e)
		{
			System.out.println(e);
			return false;
		}		
	}
	
	public boolean getIndentList(long nid) {//获取某一个订单的订单图书表
		sqlStr = "select * from My_IndentList where IndentNo = '" + nid + "'";//限制订单单号，查询符合条件的记录
		try
		{	
			rs = stmt.executeQuery(sqlStr);
			indent_list = new Vector();
			while (rs.next())
			{				
				indentlist identlist = new indentlist();
				identlist.setId(rs.getLong("Id"));
				identlist.setIndentNo(rs.getLong("IndentNo"));
				identlist.setBookNo(rs.getLong("BookNo"));
				identlist.setAmount(rs.getInt("Amount"));
				indent_list.addElement(identlist);//存入indent_list
			}
			rs.close();
			return true;
		}
		catch (SQLException e)
		{
			return false;
		}		
	}

	public boolean update(HttpServletRequest res) {//更新用户订单表
		request = res;
		int payoff = 1;
		int sales = 1;
		long indentid =0;
		try
		{
			payoff = Integer.parseInt(request.getParameter("payoff"));//是否支付
			sales = Integer.parseInt(request.getParameter("sales"));//是否发货
			indentid = Long.parseLong(request.getParameter("indentid"));//订单编号
			sqlStr = "update My_Indent set IsPayoff = '" + payoff + "',IsSales='"+ sales +"' where Id =" + indentid;
			stmt.execute(sqlStr);
			return true;
		}
		catch (Exception e)
		{
			return false;
		}		
	}

	public boolean delete(long id) {//删除某一个订单
		try
		{
			sqlStr = "delete from My_IndentList where IndentNo =" + id;//删除对应订单号的订单图书表
			stmt.execute(sqlStr);
			sqlStr = "delete from My_Indent where Id= " + id ;//删除对应订单号的订单
			stmt.execute(sqlStr);
			return true;
		}
		catch (SQLException e)
		{
			return false;
		}
	}

};

