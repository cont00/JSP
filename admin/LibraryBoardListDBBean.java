package library.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LibraryBoardListDBBean {

	public static LibraryBoardListDBBean instance = new LibraryBoardListDBBean();
	public static LibraryBoardListDBBean getInstance()	{
		return instance;
	}
	
	private LibraryBoardListDBBean()	{}
	
	private Connection getConnection() throws Exception	{
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	public void insertArticle(LibraryBoardListDataBean article) throws Exception	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int recommend_num = article.getRecommend_num();
		int recommend_ref = article.getRecommend_ref();
		int recommend_re_step = article.getRecommend_re_step();
		int recommend_re_level = article.getRecommend_re_level();
		int recommend_number = 0;
		String sql = "";
		
		try	{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select max(recommend_num) from recommendbookboard");
			rs = pstmt.executeQuery();
			
			if( rs.next() )
				recommend_number = rs.getInt(1)+1;
			else
				recommend_number = 1;
			
			if( recommend_num != 0)	{
				sql = "update recommendbookboard set recommend_re_step = recommend_re_step + 1 ";
				sql += "where recommend_ref = ? and recommend_re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, recommend_ref);
				pstmt.setInt(2, recommend_re_step);
				pstmt.executeUpdate();
				recommend_re_step = recommend_re_step+1;
				recommend_re_level = recommend_re_level+1;
			}
			else	{
				recommend_ref = recommend_number;
				recommend_re_step = 0;
				recommend_re_level = 0;
			}
			
			sql = "insert into recommendbookboard(recommend_booktitle, recommend_title, recommend_user_name, recommend_date, recommend_passwd, ";
			sql += "recommend_ref, recommend_re_step, recommend_re_level, recommend_content) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getRecommend_booktitle());
			pstmt.setString(2, article.getRecommend_title());
			pstmt.setString(3, article.getRecommend_user_name());
			pstmt.setTimestamp(4, article.getRecommend_date());
			pstmt.setString(5, article.getRecommend_passwd());
			pstmt.setInt(6, recommend_ref);
			pstmt.setInt(7, recommend_re_step);
			pstmt.setInt(8, recommend_re_level);
			pstmt.setString(9, article.getRecommend_content());
			
			pstmt.executeUpdate();
			
			}	catch( Exception ex )	{
				ex.printStackTrace();
			}	finally	{
				if( rs != null )	try	{	rs.close();	}	catch( SQLException ex )	{}
				if( pstmt != null )	try	{	pstmt.close();	}	catch( SQLException ex )	{}
				if( conn != null )	try	{	conn.close();	}	catch( SQLException ex )	{}
		}
	}
	
	public int getArticleCount() throws Exception	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int x = 0;
		
		try	{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select count(*) from recommendbookboard");
			rs = pstmt.executeQuery();
			
			if( rs.next() )	{
				x = rs.getInt(1);
			}
		}	catch( Exception ex )	{
			ex.printStackTrace();
		}	finally	{
			if( rs != null )	try	{	rs.close();	}	catch( SQLException ex )	{}
			if( pstmt != null )	try	{	pstmt.close();	}	catch( SQLException ex )	{}
			if( conn != null )	try	{	conn.close();	}	catch( SQLException ex )	{}
		}
		
		return x;
	}
	
	public List<LibraryBoardListDataBean> getArticles(int start, int end) throws Exception	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<LibraryBoardListDataBean> articleList = null;
		
		try	{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from recommendbookboard order by recommend_ref desc, recommend_re_step asc limit ?, ?");
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if( rs.next() )	{
				articleList = new ArrayList<LibraryBoardListDataBean>(end);
				do	{
					LibraryBoardListDataBean article = new LibraryBoardListDataBean();
					article.setRecommend_num( rs.getInt("recommend_num") );
					article.setRecommend_user_name( rs.getString("recommend_user_name") );
					article.setRecommend_booktitle( rs.getString("recommend_booktitle") );
					article.setRecommend_title( rs.getString("recommend_title") );
					article.setRecommend_passwd( rs.getString("recommend_passwd") );
					article.setRecommend_date( rs.getTimestamp("recommend_date") );
					article.setRecommend_readcount( rs.getInt("recommend_readcount") );
					article.setRecommend_ref( rs.getInt("recommend_ref") );
					article.setRecommend_re_step( rs.getInt("recommend_re_step") );
					article.setRecommend_re_level( rs.getInt("recommend_re_level") );
					article.setRecommend_content( rs.getString("recommend_content") );
					article.setRecommend_count( rs.getInt("recommend_count") );
					
					articleList.add(article);
				}	while( rs.next() );
			}
		}	catch( Exception ex )	{
			ex.printStackTrace();
		}	finally	{
			if( rs != null )	try	{	rs.close();	}	catch( SQLException ex )	{}
			if( pstmt != null )	try	{	pstmt.close();	}	catch( SQLException ex )	{}
			if( conn != null )	try	{	conn.close();	}	catch( SQLException ex )	{}
		}
		return articleList;
	}
	
	public LibraryBoardListDataBean getArticle(int recommend_num) throws Exception	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LibraryBoardListDataBean article = null;
		
		try	{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("update recommendbookboard set recommend_readcount = recommend_readcount+1 where recommend_num = ?");
			pstmt.setInt(1, recommend_num);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement("select * from recommendbookboard where recommend_num = ?");
			pstmt.setInt(1, recommend_num);
			rs = pstmt.executeQuery();
			
			if( rs.next()	)	{
				article = new LibraryBoardListDataBean();
				article.setRecommend_num( rs.getInt("recommend_num") );
				article.setRecommend_user_name( rs.getString("recommend_user_name") );
				article.setRecommend_booktitle( rs.getString("recommend_booktitle") );
				article.setRecommend_title( rs.getString("recommend_title") );
				article.setRecommend_passwd( rs.getString("recommend_passwd") );
				article.setRecommend_date( rs.getTimestamp("recommend_date") );
				article.setRecommend_readcount( rs.getInt("recommend_readcount") );
				article.setRecommend_ref( rs.getInt("recommend_re_ref") );
				article.setRecommend_re_step( rs.getInt("recommend_re_step") );
				article.setRecommend_re_level( rs.getInt("recommend_re_level") );
				article.setRecommend_content( rs.getString("recommend_content") );
				article.setRecommend_count( rs.getInt("recommend_count") );
			}
		}	catch( Exception ex )	{
			ex.printStackTrace();
		}	finally	{
			if( rs != null )	try	{	rs.close();	}	catch( SQLException ex )	{}
			if( pstmt != null )	try	{	pstmt.close();	}	catch( SQLException ex )	{}
			if( conn != null )	try	{	conn.close();	}	catch( SQLException ex )	{}
		}
		return article;
	}
	
	public LibraryBoardListDataBean updateGetArricle(int recommend_num) throws Exception	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LibraryBoardListDataBean article = null;
		
		try	{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from recommendbookboard where recommend_num = ?");
			pstmt.setInt(1, recommend_num);
			rs = pstmt.executeQuery();
			
			if( rs.next() )	{
				article = new LibraryBoardListDataBean();
				article.setRecommend_num( rs.getInt("recommend_num") );
				article.setRecommend_user_name( rs.getString("recommend_user_name") );
				article.setRecommend_booktitle( rs.getString("recommend_booktitle") );
				article.setRecommend_title( rs.getString("recommend_title") );
				article.setRecommend_passwd( rs.getString("recommend_passwd") );
				article.setRecommend_date( rs.getTimestamp("recommend_date") );
				article.setRecommend_readcount( rs.getInt("recommend_readcount") );
				article.setRecommend_re_step( rs.getInt("recommend_re_step") );
				article.setRecommend_re_level( rs.getInt("recommend_re_level") );
				article.setRecommend_content( rs.getString("recommend_content") );
				article.setRecommend_count( rs.getInt("recommend_count") );
			}
		}	catch( Exception ex )	{
			ex.printStackTrace();
		}	finally	{
			if( rs != null )	try	{	rs.close();	}	catch( SQLException ex )	{}
			if( pstmt != null )	try	{	pstmt.close();	}	catch( SQLException ex )	{}
			if( conn != null )	try	{	conn.close();	}	catch( SQLException ex )	{}
		}
		return article;
	}
	
	public int updateArticle(LibraryBoardListDataBean article) throws Exception	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String dbpasswd = "";
		String sql = "";
		int x = -1;
		
		try	{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select recommend_passwd from recommendbookboard where recommend_num = ?");
			pstmt.setInt(1, article.getRecommend_num());
			rs = pstmt.executeQuery();
			
			if( rs.next() )	{
				dbpasswd = rs.getString("recommend_passwd");
				if( dbpasswd.equals( article.getRecommend_passwd() ) )	{
					sql = "update recommendbookboard set recommend_user_name = ?, recommend_booktitle = ?, recommend_title = ?, recommend_passwd = ?";
					sql += ", recommend_content =?, where recommend_num = ?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, article.getRecommend_user_name());
					pstmt.setString(2, article.getRecommend_booktitle());
					pstmt.setString(3, article.getRecommend_title());
					pstmt.setString(4, article.getRecommend_passwd());
					pstmt.setString(5, article.getRecommend_content());
					pstmt.setInt(6, article.getRecommend_num());
					pstmt.executeUpdate();
					x = 1;
				}
				else	{
					x = 0;
				}
			}
		}	catch( Exception ex )	{
			ex.printStackTrace();
		}	finally	{
			if( rs != null )	try	{	rs.close();	}	catch( SQLException ex )	{}
			if( pstmt != null )	try	{	pstmt.close();	}	catch( SQLException ex )	{}
			if( conn != null )	try	{	conn.close();	}	catch( SQLException ex )	{}
		}
		return x;
	}
	
	public int deleteArticle(int recommend_num, String recommend_passwd) throws Exception	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try	{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select recommend_passwd from recommendbookboard where recommend_num = ?");
			pstmt.setInt(1, recommend_num);
			rs = pstmt.executeQuery();
			
			if( rs.next() )	{
				dbpasswd = rs.getString("recommend_passwd");
				if( dbpasswd.equals(dbpasswd) )	{
					pstmt = conn.prepareStatement("delete from recommendbookboard where recommend_num = ?");
					pstmt.setInt(1, recommend_num);
					pstmt.executeUpdate();
					x = 1;
				}
				else	{
					x = 0;
				}
			}
		} catch( Exception ex )	{
			ex.printStackTrace();
		}	finally	{
			if( rs != null )	try	{	rs.close();	}	catch( SQLException ex )	{}
			if( pstmt != null )	try	{	pstmt.close();	}	catch( SQLException ex )	{}
			if( conn != null )	try	{	conn.close();	}	catch( SQLException ex )	{}
		}
		
		return x;
	}
	
         /////////////////////////추천 메소드 추가
	public LibraryBoardListDataBean getRecommend(int recommend_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LibraryBoardListDataBean article=null;
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement(
				"update recommendbookboard set recommend_count=recommend_count+1 where recommend_num = ?");
					pstmt.setInt(1, recommend_num);
					pstmt.executeUpdate();
					
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException ex) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null) try { conn.close(); } catch(SQLException ex) {}
			}
				return article;
		}
}