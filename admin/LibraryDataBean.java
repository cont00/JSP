package library.admin;
import java.sql.Timestamp;

public class LibraryDataBean {

	private int book_num; // 책의 도서번호
	private String title; // 도서명
	private String writer; // 글쓴이
	private String genre; // 장르
	private String publisher; // 출판사
	private String book_state; // 도서상태
	private String book_check; // 반출여부확인
	private Timestamp reg_date; // 등록날짜
	
	public int getBook_num() {
		return book_num;
	}
	public void setBook_num(int book_num) {
		this.book_num = book_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getBook_state() {
		return book_state;
	}
	public void setBook_state(String book_state) {
		this.book_state = book_state;
	}
	public String getBook_check() {
		return book_check;
	}
	public void setBook_check(String book_check) {
		this.book_check = book_check;
	} 
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

}