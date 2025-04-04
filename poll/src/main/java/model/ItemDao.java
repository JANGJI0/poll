package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Item;

// Table : item crud
public class ItemDao {
	// 투포결과 투표현황
		public int selectItemCountByQnum(int qnum) throws ClassNotFoundException, SQLException {
			int count = 0;
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			String sql = "SELECT SUM(COUNT) cnt"
							+ " FROM item"
							+ " GROUP BY qnum"
							+ " HAVING qnum= ?";
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, qnum);
			rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt"); // rs.getInt(1)
			}
			
			return count;
			
		}
		
		// 투표하기 Action
		public void updateItemCountPlus(int qnum, int inum) throws SQLException, ClassNotFoundException { // 반환값 필요없으니 void
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			String sql = "UPDATE item SET count = count+1 WHERE qnum = ? AND inum = ?"
							+ " ORDER BY inum ASC";
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, qnum);
			stmt.setInt(2, inum);
			int row = stmt.executeUpdate();
			if(row == 1) {
				// 디버깅
				System.out.println("ItemDao.updateItemCountPlus#입력성공");

			} else {
				System.out.println("ItemDao.updateItemCountPlus#입력실패");
				
			}
			
		}
		
		// 설문 삭제
		public void deleteItem(int qnum) throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM item WHERE qnum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1,qnum);
		stmt.executeUpdate();
		
		conn.close();
		}
		
		//투표하기 리스트(updateIemForm), 결과보기(questionOneResult)
		public ArrayList<Item> selectItemListByQnum(int qnum) throws ClassNotFoundException, SQLException {
			ArrayList<Item> list = new ArrayList<Item>();
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			String sql = "SELECT * FROM item WHERE qnum = ? ORDER BY inum ASC";
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, qnum);
			rs = stmt.executeQuery();
			
			// 외부 JDBC 라이브러리에 의존하는 ResultSet ArrayList 타입으로 변경
			while(rs.next()) {
				Item i = new Item(); // 소문자 i 하는 이유 지역변수
				i.setQnum(qnum);
				i.setInum(rs.getInt("inum"));
				i.setContent(rs.getString("content"));
				i.setCount(rs.getInt("count"));
				list.add(i);
			}
			
			return list;
		}
		
		// 설문 항목 1개를 item 테이블에 삽입하는 메서드
		public void insertItem(Item item) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO item(qnum, inum, content) value(?, ?, ?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, item.getQnum());
		stmt.setInt(2, item.getInum());
		stmt.setString(3, item.getContent());
		int row = stmt.executeUpdate();
		if(row == 1) {
			// 디버깅
			System.out.println("ItemDao.insertItem - 입력 성공");
		} else {
			System.out.println("ItemDao.insertItem - 입력실패");
		}
		
		conn.close();
	}
	
}












