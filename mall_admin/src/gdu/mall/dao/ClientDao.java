package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;
public class ClientDao {
	//클라이언트 비밀번호 변경
	public static void updateClient(String clientMail, String clientPw) throws Exception {
		//sql
		String sql = "UPDATE client SET client_pw = PASSWORD(?) WHERE client_mail=?";
		
		//처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,clientPw);
		stmt.setString(2,clientMail);
		//stmt디버깅
		System.out.println(stmt + " <-- ClientDao updateClient()의 stmt");
		
		//수정실행
		stmt.executeUpdate();
	}
	
	//클라이언트 삭제
	public static void deleteClient(String clientMail) throws Exception {
		//sql
		String sql = "DELETE FROM client WHERE client_mail = ?";
		
		//처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,clientMail);
		//stmt디버깅
		System.out.println(stmt + "<-- ClientDao deleteClient() stmt");
		
		//삭제실행
		stmt.executeUpdate();
	}	
	
	
	// 전체 행의 수
	public static int totalCount(String searchWord) throws Exception {
		
		int totalRow = 0;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = "";
		if(searchWord.equals("")) {
			sql = "SELECT COUNT(*) cnt FROM client";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT COUNT(*) cnt FROM client WHERE client_mail LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}
		System.out.println(stmt + " <--login() sql"); // stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) { // 데이터 값이 존재한다면 총 개수를 입력해준다.
			totalRow = rs.getInt("cnt");
		}
		// 4. 리턴
		return totalRow; // 총 데이터 개수 반환
	}
	
	// 목록 메서드
	public static ArrayList<Client> selectClientListByPage(int rowPerPage, int beginRow, String searchWord) throws Exception {
		
		ArrayList<Client> list = new ArrayList<>();
		
		// 3. DB 연결 및 sql문 실행
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = null;
		String sql = "";
		if(searchWord == null || searchWord.equals("")) { // 검색어가 없으면 
			sql = "select client_mail clientMail, client_date clientDate from client order by client_date desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else { // 검색어가 있으면
			sql = "select client_mail clientMail, client_date clientDate from client where client_mail like ? order by client_date desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		ResultSet rs = stmt.executeQuery();
		
		// 4. return
		while(rs.next()) { // 다음 값이 존재한다면 계속해서  
			Client c = new Client();
			/* c.clientNo = rs.getInt(""); */
			/* c.clientPw = rs.getString(""); */
			c.clientMail = rs.getString("clientMail");
			c.clientDate = rs.getString("clientDate");
			list.add(c);
		}
		return list;
	}
}