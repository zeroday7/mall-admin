package gdu.mall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.Ebook;

public class EbookDao {
	public static int updateEbookImg(Ebook ebook) throws Exception {
		String sql ="UPDATE ebook SET ebook_img=? WHERE ebook_isbn =?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.ebookImg);
		stmt.setString(2, ebook.ebookISBN);
		int rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	public static Ebook selectEbookOne(String ebookISBN) throws Exception{
		//sql은 모두 다 가져와야 한다
		String sql = "SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_summary ebookSummary, ebook_company ebookCompany, ebook_page_Count ebookPageCount, ebook_price ebookPrice, ebook_img ebookImg, ebook_date ebookDate, ebook_state ebookState FROM ebook WHERE ebook_isbn = ?";
		//초기화
		Ebook ebook = null;
		//DB연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.printf("stmt: %s<EbookDao.selectEbookOne>\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook = new Ebook();
			ebook.ebookNo = rs.getInt("ebook_no");
			ebook.ebookISBN = rs.getString("ebookISBN");
			ebook.categoryName = rs.getString("categoryName");
			ebook.ebookTitle = rs.getString("ebookTitle");
			ebook.ebookAuthor = rs.getString("ebookAuthor");
			ebook.ebookSummary = rs.getString("ebookSummary");
			ebook.ebookCompany = rs.getString("ebookCompany");
			ebook.ebookImg =rs.getString("ebookImg");
			ebook.ebookDate =rs.getString("ebookDate");
			ebook.ebookState =rs.getString("ebookState");
			ebook.ebookPageCount = rs.getInt("ebookPageCount");
			ebook.ebookPrice = rs.getInt("ebookPrice");
			
		}
		
		return ebook;
	}
	
	public static String checkEbookISBN(String ebookISBN) throws Exception{
		//1.sql
		String sql="SELECT ebook_isbn ebookISBN FROM ebook where ebook_isbn=?";
		//2.초기화
		String returnEbookISBN = null;
		//3.db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		
		System.out.printf("stmt: %s <--ebookDao.checkEbookISBN \n",stmt);
		//4.쿼리완성
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnEbookISBN = rs.getString("ebookISBN");
		}
		//5.리턴값
		return returnEbookISBN;
	}
	
	// 입력 메서드
	public static int insertEbook(Ebook ebook) throws Exception {
		/*
		 * INSERT INTO ebook(
		 * 		ebook_isbn,
		 * 		category_name,
		 * 		ebook_title,
		 * 		ebook_author,
		 * 		ebook_company,
		 * 		ebook_page_count,
		 * 		ebook_price,
		 * 		ebook_summary,
		 * 		ebook_img,
		 * 		ebook_date,
		 * 		ebook_state
		 * ) VALUES (
		 * 		?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중'
		 * )			 
		 */
		String sql = "INSERT INTO ebook(ebook_isbn,category_name,ebook_title,ebook_author,ebook_company,ebook_page_count,ebook_price,ebook_summary,ebook_img,ebook_date,ebook_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중')";
		int rowCnt = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.ebookISBN);
		stmt.setString(2, ebook.categoryName);
		stmt.setString(3, ebook.ebookTitle);
		stmt.setString(4, ebook.ebookAuthor);
		stmt.setString(5, ebook.ebookCompany);
		stmt.setInt(6, ebook.ebookPageCount);
		stmt.setInt(7, ebook.ebookPrice);
		stmt.setString(8, ebook.ebookSummary);
		rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	
	// 목록 메소드
	public static ArrayList<Ebook> selectEbookListByPage(int rowPerPage, int beginRow) throws Exception {
		
		// 쿼리 작성
		String sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?, ?";
		
		// 리턴값 초기화
		ArrayList<Ebook> list = new ArrayList<>();
		
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt + "<-- EbookDao selectEbookListByPage의 stmt");
		
		ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Ebook e = new Ebook();
				e.categoryName = rs.getString("categoryName");
				e.ebookISBN = rs.getString("ebookISBN");
				e.ebookTitle = rs.getString("ebookTitle");
				e.ebookAuthor = rs.getString("ebookAuthor");
				e.ebookDate = rs.getString("ebookDate");
				e.ebookPrice = rs.getInt("ebookPrice");
				list.add(e);
			}
		// 4. 결과값 리턴
		return list;
		}
	
	// 전체 행의 수 세는 메소드
	public static int totalCount() throws Exception {
		// 변수 초기화
		int totalRow = 0;
		
		// 쿼리 작성
		String sql = "SELECT COUNT(*) cnt FROM ebook";
		
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + " <-- Ebook count의 stmt"); // 디버깅
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) { // ebook 데이터의 총 개수
				totalRow = rs.getInt("cnt");
		}
		// 결과값 리턴
		return totalRow;
	}
}
