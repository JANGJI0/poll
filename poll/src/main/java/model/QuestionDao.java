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
	// 1) selectQuestionList(Paging p) : 리스트 조회
	// 2) insertQuestion(Question question) : 설문 추가
	// 3) getTotalDataCount() : 전체 설문 개수 확인
	// 4) deleteQuestionNoVote(NoBote) : 투표없을 때 삭제
	// 5) updateQuestion : 전체 수정
	
	
	// deleteQuestionNoType(NoType) : 투표없을 때 삭제
			// 설문 번호를 받아 투표가 없을 경우 삭제
			public void deleteQuestion(int num) throws ClassNotFoundException, SQLException {
				
				Connection conn = null;
				PreparedStatement stmt = null;
				
				// db 연결
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				// 1. 투표수 확인
				String sql = "DELETE FROM question WHERE num = ?";
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, num);
				stmt.executeUpdate();
					
					
				// 자원 정리
				conn.close();
			}
			
			// 설문 번호에 해당하는 질문 정보를 조회하는 메서드
			public Question selectQuestion(int num) throws ClassNotFoundException, SQLException {
				Question question = null;
				
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
			
				// db 연결
				Class.forName("com.mysql.cj.jdbc.Driver");
				// 1. 
				String sql = "SELECT num, title, startdate, enddate, type FROM question WHERE num = ?";
				
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, num);
				rs = stmt.executeQuery();
				
				while(rs.next()) {
				question = new Question();
				question.setNum(rs.getInt("num"));
				question.setTitle(rs.getString("title"));
				question.setStartdate(rs.getString("startdate"));
				question.setEnddate(rs.getString("enddate"));
				question.setType(rs.getInt("type"));
				
				}
				
				conn.close();
				return question;
			}
			
			// updateQuestion : 전체 수정 하나 가져오기
			public void updateQuestion(Question question) throws ClassNotFoundException, SQLException {
				
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
				
				String updateSql = "UPDATE question SET title = ?, startdate = ?, enddate = ?, type = ? WHERE num = ?";
				stmt = conn.prepareStatement(updateSql);
				stmt.setString(1, question.getTitle());
				stmt.setString(2, question.getStartdate());
				stmt.setString(3, question.getEnddate());
				stmt.setInt(4, question.getType());
				stmt.setInt(5, question.getNum());
				
				stmt.executeUpdate();
				
				conn.close();
				
				
			}
	
		// 1) 리스트 조회
		public ArrayList<Question> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException {
			ArrayList<Question> list = new ArrayList<>();
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// mysql 연결
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Poll", "root", "java1234");
			
			// 페이징 쿼리
			String sql = "SELECT q.num, q.title, q.startdate, q.enddate, q.type, t.cnt "
							+ "FROM question q "
							+ "INNER JOIN (SELECT qnum, SUM(count) cnt FROM item GROUP BY qnum) t "
							+ "ON q.num = t.qnum "
							+ "LIMIT ?, ?";
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
					question.setCnt(rs.getInt("cnt")); // gett seter로 받기때문에 dto에 추가해야한다.
					list.add(question);  // 여기서 list 가 생겨야 pollList에 받는다.
			}
			
			conn.close();
			return list;
		}
		
		// getTotalDataCount() : 전체 설문 개수 확인
				public int getTotal() throws ClassNotFoundException, SQLException {
				int total = 0;
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
				
				
				String sql = "SELECT count(*) cnt FROM question";
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
				stmt = conn.prepareStatement(sql);
				
				// 디버깅
				// System.out.println(stmt);
				
				rs = stmt.executeQuery();
				rs.next();
				total = rs.getInt("cnt");
				
				conn.close();
				return total;
				
				
			}
	
	// insertQuestion(Question question) : 설문 추가
	// 입력 후 자동으로 생성된 키값을 반환값
	// insertQuestion은 하나니까 ArrayList 쓸 필요가 없다.
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
	
		/*
		public Question selectQuestionOne(int num) throws ClassNotFoundException, SQLException {
			Question q = null;
			
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
			
			String sql = "SELECT * FROM question WHERE num = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				q = new Question();
				q.setNum(num);
				q.setTitle(rs.getString("title"));
				q.setStartdate(rs.getString("startdate"));
				q.setEnddate(rs.getString("enddate"));
				q.setType(rs.getInt("type"));
			}
			return q;
			
		}
		*/
	
}


































