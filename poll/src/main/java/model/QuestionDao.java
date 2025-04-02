package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Paging;
import dto.Question;
// Table : question crud
public class QuestionDao {
	
	public ArrayList<Question> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<Question> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// mysql 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Poll", "root", "java1234");
		
		// 페이징 쿼리
		String sql = "SELECT num, title, startdate, enddate, type FROM question ORDER BY num DESC LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow()); // 시작 행 번호
		stmt.setInt(2, p.getRowPerPage()); // 한 페이지에 보여줄 행 수
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
				Question question = new Question();
				question.setNum(rs.getInt("num"));
				question.setTitle(rs.getString("title"));
				question.setStartdate(rs.getString("startdate"));
				question.setEnddate(rs.getString("enddate"));
				question.setType(rs.getInt("type"));
				list.add(question);  // 여기서 list 가 생겨야 pollList에 받는다.
		}
		
		
		return list;
	}
	
	// 입력 후 자동으로 생성된 키값을 반환값
	public int insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		int pk = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");  // try catch
		Connection conn = null;
		PreparedStatement stmt = null;
		// 입력이지만 키값을 받아올때 사용
		ResultSet rs = null;
		String sql = "INSERT INTO question(title, startdate, enddate, type) value(?, ?, ?, ?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		// Statement.RETURN_GENERATED_KEYS 옵션 : insert 후 select max(pk) from.... 실행
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, question.getTitle());
		stmt.setString(2, question.getStartdate());
		stmt.setString(3, question.getEnddate());
		stmt.setInt(4, question.getType());
		int row = stmt.executeUpdate(); // insert
		rs = stmt.getGeneratedKeys(); // select max(num) from question
		
		if(rs.next()) {
			pk = rs.getInt(1);
			
		}
		conn.close();
		
	
		return pk;
		
	}
	
		
		public int getTotalDataCount() throws ClassNotFoundException, SQLException {
			int count = 0;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			String sql = "SELECT COUNT(*) cnt FROM question";
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
			stmt = conn.prepareStatement(sql);
			
			// 디버깅
			// System.out.println(stmt);
			
			rs = stmt.executeQuery();
			rs.next();
			count = rs.getInt("cnt");
			conn.close();
			return count;
			
			
		}
	
}









