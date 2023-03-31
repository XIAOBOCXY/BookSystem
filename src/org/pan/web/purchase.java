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
	private HttpSession session;//��������Ϊÿһ���û� ����һ��������HttpSession			
	private boolean sqlflag = true ;			
	private Vector purchaselist;//���򶩵�			
	private Vector my_indent;//�ҵĶ���					
	private Vector indent_list;//����ͼ���					
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
	

	public boolean addnew(HttpServletRequest newrequest){//����µĹ�����Ϣ
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
					leaveBook = rs.getInt(1);//��ȡ��ʣ�¼���
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

		indentlist iList = new indentlist();//����ͼ���ʵ��
		iList.setBookNo(bookid);
		iList.setAmount(amount);
		boolean match = false;	
		if (purchaselist==null)//����û�ж���  
		{
			purchaselist = new Vector();
			purchaselist.addElement(iList);
		}
		
		else {//�����Ѿ��ж����� 			
			for (int i=0; i< purchaselist.size(); i++) { //�����Ȿ���Ѿ������˹��ﳵ
				indentlist itList= (indentlist) purchaselist.elementAt(i); 
				if ( iList.getBookNo() == itList.getBookNo() ) { 
					itList.setAmount(itList.getAmount() + iList.getAmount());//ԭ���е�����������һ�ι���� 
					purchaselist.setElementAt(itList,i);//�����Ȿ������� 
					match = true; 
					break;
				} 			
			} 
			if (!match) //���û��ƥ���ϣ�����µļ�¼�����ﳵ
				purchaselist.addElement(iList); 
		}
		session.setAttribute("shopcar", purchaselist); 
		return true;
		
	}

	public boolean delShoper(HttpServletRequest newrequest) {//ɾ�����ﳵ�Ĺ�����Ϣ
		request = newrequest;
		String ID = request.getParameter("bookid");//��ȡɾ������ı��
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
				purchaselist.removeElementAt(i);//�ӹ����б���ɾ�� 
				break;
			}  				
		} 
		return true;
	}



	public boolean payout(HttpServletRequest newrequest) throws Exception {//�ύ���ﳵ
		  request = newrequest;
		  session = request.getSession(false);
		  if (session == null)
		  {
		   return false;
		  }
		  String Userid = (String) session.getAttribute("userid");//��ȡ�û����к�  
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
		  String Content = request.getParameter("content");//��ȡ��ע
		  if (Content==null)
		  {
		   Content="";
		  }
		  Content = getGbk(Content);
		  String IP = request.getRemoteAddr();
		  String TotalPrice = request.getParameter("totalprice");//��ȡ�ܼ�

		  sqlStr = "select max(Id) from My_Indent";//��ȡ��󶩵���
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
		   sqlStr= "select max(Id) from My_Indent where UserId = " + userid;//��ȡ���Ķ������к�
		   rs = stmt.executeQuery(sqlStr);
		   long indentid = 0;
		   while (rs.next())
		   {
		    indentid = rs.getLong(1);
		   }
		   rs.close();
		   for (int i=0; i<purchaselist.size() ;i++ )//���ڹ��ﳵ�е�ÿһ�������¼����Ҫ�ӵ�����ͼ�����
		   {
		    indentlist iList = (indentlist) purchaselist.elementAt(i);
		    int newid2 = 1;
		    sqlStr = "select max(Id)+1 as newid from My_IndentList";//��ȡ���Ķ���ͼ������к�
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
		    sqlStr = "update My_Book set Leav_number=Leav_number - " + iList.getAmount() + " where Id = " + iList.getBookNo();//�����������
		    stmt.execute(sqlStr);
		   }
		   return true;
		  }
		  catch (SQLException e)
		  {
		   return false;
		  }
		    
		 }
	
	public boolean getOneIndent(long iid) {//��ȡĳһ���������кŵĶ���
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
		    
		    
		    
	public boolean getIndent(long userid) {//��ȡĳһ���û��Ķ���
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



	public boolean getIndent() {//��ȡ�û�������
		sqlStr = "select count(*) from My_Indent";  
		int rscount = pageSize;
		try
		{
			ResultSet rs1 = stmt.executeQuery(sqlStr);
			if (rs1.next()) recordCount = rs1.getInt(1);//�����û�����������				
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
			rs = stmt.executeQuery(sqlStr);//���ж�������Ϣ
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
				my_indent.addElement(ind);//����my_indent
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
	
	public boolean getIndentList(long nid) {//��ȡĳһ�������Ķ���ͼ���
		sqlStr = "select * from My_IndentList where IndentNo = '" + nid + "'";//���ƶ������ţ���ѯ���������ļ�¼
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
				indent_list.addElement(identlist);//����indent_list
			}
			rs.close();
			return true;
		}
		catch (SQLException e)
		{
			return false;
		}		
	}

	public boolean update(HttpServletRequest res) {//�����û�������
		request = res;
		int payoff = 1;
		int sales = 1;
		long indentid =0;
		try
		{
			payoff = Integer.parseInt(request.getParameter("payoff"));//�Ƿ�֧��
			sales = Integer.parseInt(request.getParameter("sales"));//�Ƿ񷢻�
			indentid = Long.parseLong(request.getParameter("indentid"));//�������
			sqlStr = "update My_Indent set IsPayoff = '" + payoff + "',IsSales='"+ sales +"' where Id =" + indentid;
			stmt.execute(sqlStr);
			return true;
		}
		catch (Exception e)
		{
			return false;
		}		
	}

	public boolean delete(long id) {//ɾ��ĳһ������
		try
		{
			sqlStr = "delete from My_IndentList where IndentNo =" + id;//ɾ����Ӧ�����ŵĶ���ͼ���
			stmt.execute(sqlStr);
			sqlStr = "delete from My_Indent where Id= " + id ;//ɾ����Ӧ�����ŵĶ���
			stmt.execute(sqlStr);
			return true;
		}
		catch (SQLException e)
		{
			return false;
		}
	}

};

