package library.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/*import java.util.ArrayList;
import java.util.List;*/
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LibraryDBBean {
		
	private static LibraryDBBean instance = new LibraryDBBean();
	//.jsp 페이지에서 DB 연동빈인 BoardDBBean 클래스의 메소드에 접근시 필요
	
	public static LibraryDBBean getInstance() {
		return instance;
	}
	
	private LibraryDBBean() {}
	
	//커넥션 풀로부터 커넥션객체를 얻어내는 메소드
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	// 관리자 인증 메소드
	public int adminCheck(String id, String passwd)
	throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd="";
		int x=-1;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement(
					"select adminPasswd from administer where adminId= ?");
			pstmt.setString(1, id);
			
			rs= pstmt.executeQuery();
			
					if(rs.next()) {
							dbpasswd= rs.getString("adminPasswd");
							if(dbpasswd.equals(passwd))
									x= 1;//인증성공
							else
									x= 0;//비밀번호 틀림
					}else
							x= -1;//해당 아이디 없음
					
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null)
				try { rs.close(); } catch(SQLException ex) {}
			if(pstmt != null)
				try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null)
				try { conn.close(); } catch(SQLException ex) {}
	}
		return x;
}
	
	//도서 등록 메소드
		public void insertBook(LibraryDataBean book)
			throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = getConnection();
				
				pstmt = conn.prepareStatement(
					"insert into library (book_num,title,writer,genre,publisher,"+
					"book_state,book_check,reg_date) values (?,?,?,?,?,?,?,?)");
				pstmt.setInt(1, book.getBook_num());
				pstmt.setString(2, book.getTitle());
				pstmt.setString(3, book.getWriter());
				pstmt.setString(4, book.getGenre());
				pstmt.setString(5, book.getPublisher());
				pstmt.setString(6, book.getBook_state());
				pstmt.setString(7, book.getBook_check());
				pstmt.setTimestamp(8, book.getReg_date());
				
				pstmt.executeUpdate();
				
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(pstmt != null)
					try {pstmt.close(); } catch(SQLException ex) {}
				if(conn != null)
					try {conn.close(); } catch(SQLException ex) {}
			}
		}
		
	//등록된 책을 수정하기 위해 수정폼으로 읽어들기이기 위한 메소드
	public LibraryDataBean getBook(int book_num)
		throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			LibraryDataBean book = null;
			
			try {
				conn = getConnection();
				
				pstmt = conn.prepareStatement(
					"select * from library where book_num = ?");
				pstmt.setInt(1, book_num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					book = new LibraryDataBean();
					
					book.setTitle(rs.getString("title"));
					book.setGenre(rs.getString("genre"));
					book.setWriter(rs.getString("writer"));
					book.setPublisher(rs.getString("publisher"));
					book.setBook_state(rs.getString("book_state"));
					book.setBook_check(rs.getString("book_check"));
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(rs != null)
					try {rs.close();} catch(SQLException ex) {}
				if(pstmt != null)
					try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null)
					try {conn.close();} catch(SQLException ex) {}
			}
			return book;
	}
		
		
	//등록된 책의 정보를 수정시 사용하는 메소드
	public void updateBook(LibraryDataBean book)
	throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql;
		
		try {
			conn = getConnection();
				
				sql = "update Library set title=?,writer=?,genre=?";
				sql += ",publisher=?,book_state=?,book_check=? where book_num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, book.getTitle());
				pstmt.setString(2, book.getWriter());
				pstmt.setString(3, book.getGenre());
				pstmt.setString(4, book.getPublisher());
				pstmt.setString(5, book.getBook_state());
				pstmt.setString(6, book.getBook_check());
				pstmt.setInt(7, book.getBook_num());
				
				pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(pstmt != null)
				try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null)
				try {conn.close();} catch(SQLException ex) {}
		}
	}
	//글삭제처리시 사용(delete문) <=deletePro.jsp페이지에서 사용
		public void deleteBook(int book_num)
			throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = getConnection();
				
					pstmt = conn.prepareStatement(
							"delete from library where book_num=?");
						pstmt.setInt(1, book_num);
						
						pstmt.executeUpdate();
						
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
				if(conn != null) try { conn.close(); } catch(SQLException ex) {}
			}
		}
	
	
	////////////////////////////////////////////////////////
	//전체 도서권수 
		public int getBooklistCount() throws Exception{ 
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int x = 0;
			
			try {
				conn = getConnection();
				
				String sql = "select count(*) from library";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					x = rs.getInt(1);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) {
					try {rs.close();}catch(Exception e) {}
				}
				if(conn != null) {
					try {conn.close();}catch(Exception e) {}
				}
				if(pstmt != null) {
					try {pstmt.close();}catch(Exception e) {}
				}
			}
			return x;
		}
		
		//도서목록 리스트로 받아오기
		public List<LibraryDataBean> getBooklist(int start, int end) throws Exception { 
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        List<LibraryDataBean> bookList=null;
	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement(
	            	"select * from library order by book_num desc limit ?,? ");
	            pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	            	bookList = new ArrayList<LibraryDataBean>(end);
	                do{
	                	LibraryDataBean book = new LibraryDataBean();
					  book.setBook_num(rs.getInt("book_num"));
					  book.setReg_date(rs.getTimestamp("reg_date"));
	                  book.setTitle(rs.getString("title"));
	                  book.setPublisher(rs.getString("publisher"));
	                  book.setWriter(rs.getString("writer"));
				      book.setGenre(rs.getString("genre"));
					  book.setBook_state(rs.getString("book_state"));
	                  book.setBook_check(rs.getString("book_check"));

				      bookList.add(book);
				    }while(rs.next());
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return bookList;
		}
			
}
