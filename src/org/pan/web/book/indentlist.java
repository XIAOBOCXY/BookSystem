package org.pan.web.book;



public class indentlist {
	private long Id;//ID序列号				
	private long IndentNo;//订单号表序列号			
	private long BookNo;//图书表序列号			
	private int Amount;//订货数量				

	public indentlist() {
		Id = 0;
		IndentNo = 0;
		BookNo = 0;
		Amount = 0;
	}

	public long getId() {
		return Id;
	}

	public void setId(long newId) {
		this.Id = newId;
	}

	public long getIndentNo() {
		return IndentNo;
	}

	public void setIndentNo(long newIndentNo) {
		this.IndentNo = newIndentNo;
	}

	public long getBookNo() {
		return BookNo;
	}

	public void setBookNo(long newBookNo) {
		this.BookNo = newBookNo;
	}
	
	public int getAmount() {
		return Amount;
	}

	public void setAmount(int newAmount) {
		this.Amount = newAmount;
	}
}