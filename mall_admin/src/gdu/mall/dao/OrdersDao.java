package gdu.mall.dao;
import java.util.*;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.sql.*;

public class OrdersDao {
	//ordersState 변경
	public static void updateOrdersState(int ordersNo, String ordersState) throws Exception{
		//sql
		String sql ="UPDATE orders SET orders_state=? WHERE orders_no= ?";
		//DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ordersState);
		stmt.setInt(2, ordersNo);
		
		//디버그
		System.out.printf("stmt: %s<OrdersDao.updateOrdersState>\n", stmt);
		
		stmt.executeUpdate();
		
	}
	//전체 행의 수 구하기
	public static int totalCount() throws Exception{
		//sql
		String sql = "SELECT count(*) cnt from orders";
		//초기화
		int totalRow = 0;
		//DB연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		//디버그
		System.out.printf("stmt: %s<OrderDao.totalCount>\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		//리턴값
		return totalRow;
		
	}
	
	//orders list/// orders join ebook join client 리스트 
	public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int rowPerPage, int beginPage) throws Exception{
		//초기화
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		//sql
		String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail,o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no ORDER BY o.orders_date desc limit ?,?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginPage);
		stmt.setInt(2, rowPerPage);
		
		System.out.printf("stmt: %s<OrderDao.orderList>\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			oec.setOrders(o);
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			oec.setEbook(e);
			
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		
		return list;
	}

}