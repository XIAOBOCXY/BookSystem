package org.pan.web.book;
//图书类
public class books {
	private long Id;//id序列号
	private String BookName;//书名
	private int BookClass;//类别
	private String classname;//类别名称
	private String Author;//作者
	private String Publish;//出版社
	private String BookNo;//书编号
	private String Content;//介绍
	private float Prince;//价格
	private int Amount;//总数量
	private int Leav_number;//剩余数量

	public books() {
		Id = 0;
		BookName = "";
		BookClass = 0;
		classname = "";
		Author = "";
		Publish = "";
		BookNo = "";
		Content = "";
		Prince = 0;
		Amount = 0;
		Leav_number = 0;
	}

	public void setId(long newId) {
		this.Id = newId;
	}

	public long getId() {
		return Id;
	}

	public void setBookName(String newBookName) {
		this.BookName = newBookName;
	}

	public String getBookName() {
		return BookName;
	}

	public void setBookClass(int newBookClass) {
		this.BookClass = newBookClass;
	}

	public int getBookClass() {
		return BookClass;
	}

	public void setClassname(String cname) {
		this.classname = cname;
	}

	public String getClassname() {
		return classname;
	}

	public void setAuthor(String newAuthor) {
		this.Author = newAuthor;
	}

	public String getAuthor() {
		return Author;
	}

	public void setBookNo(String newBookNo) {
		this.BookNo = newBookNo;
	}

	public String getBookNo() {
		return BookNo;
	}

	public void setPublish(String newPublish) {
		this.Publish = newPublish;
	}

	public String getPublish() {
		return Publish;
	}

	public void setContent(String newContent) {
		this.Content = newContent;
	}

	public String getContent() {
		return Content;
	}

	public void setPrince(float newPrince) {
		this.Prince = newPrince;
	}

	public float getPrince() {
		return Prince;
	}

	public void setAmount(int newAmount) {
		this.Amount = newAmount;
	}

	public long getAmount() {
		return Amount;
	}

	public void setLeav_number(int newLeav_number) {
		this.Leav_number = newLeav_number;
	}

	public int getLeav_number() {
		return Leav_number;
	}

};
