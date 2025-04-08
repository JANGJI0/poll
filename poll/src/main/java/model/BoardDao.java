package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Board;
import dto.Paging;

public class BoardDao {
	// 답글 입력
	public void insertBoardReply(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		
		// 트랜잭션(2개이상의(CUD)쿼리 한 묶음처럼 처리하고자 할 때
		conn.setAutoCommit(false); // executeUpdate() 마다 자동 커밋기능을 false
		
		// ref같고 pos값이 현재글보다 크거나 같다면 + 1
		PreparedStatement stmt2 = null;
		String sql2 = "UPDATE board SET pos = pos + 1 WHERE ref = ? AND pos >= ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1,  b.getRef());
		stmt2.setInt(2,  b.getPos());
		int row2 = stmt2.executeUpdate();
		
		
		// 답글입력
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO board(name, subject, content, ref, pos, depth, pass, ip, regdate) values(?, ?, ?, ?, ?, ?, ?, ?, now())";
		
		
		stmt = conn.prepareStatement(sql); // ref == 0이면 입력직후 pk값을 반환받기 위해
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		
		stmt.setInt(4, b.getRef());
		stmt.setInt(5, b.getPos());
		stmt.setInt(6, b.getDepth());
		
		stmt.setString(7, b.getPass());
		stmt.setString(8, b.getIp());
		
		int row = stmt.executeUpdate(); 
		
		
		
		conn.commit(); // conn.setAutoComit(false) 코드 때문에 필요
		// 자원 종료
		conn.close();
		}
	
			
		
	// 새글 입력(부모글)
	public void insertBoard(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; //입력직후 PK값을 반환 받기 위해서
		String sql = "INSERT INTO board(name, subject, content, ref, pass, ip, regdate) values(?, ?, ?, ?, ?, ?, now())";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		conn.setAutoCommit(false); // executeUpdate() 마다 자동 커밋기능을 false
		
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // ref == 0이면 입력직후 pk값을 반환받기 위해
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getRef());
		stmt.setString(5, b.getPass());
		stmt.setString(6, b.getIp());
		
		int row = stmt.executeUpdate(); 
		// ref == 0면 입력 직후 pk 값을 반환 받아서 ref값을 동일하게
		rs = stmt.getGeneratedKeys();
		
		int pk = 0;
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		
		System.out.println("BoardDao.insertBoard#num: " + pk);
		
			PreparedStatement stmt2 = null;
			String sql2 = "UPDATE board SET ref = ? WHERE num = ?"; // update 때 실패하면 인서트도 취소가 된다 : 트렌젝션
			
			stmt2 = conn.prepareStatement(sql2); // 예외가 발생하면
			// update쿼리가 실패하면 이전의 insert도 롤백 하는 쿼리 : conn. rollback();
			
			stmt2.setInt(1, pk);
			stmt2.setInt(2, pk);
			stmt2.executeUpdate();
		
		
		conn.commit(); // conn.setAutoComit(false) 코드 때문에 필요
		// 자원 종료
		conn.close();
	}

	public Board selectBoardOne(int num) throws ClassNotFoundException, SQLException {
		Board b = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM board WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		rs = stmt.executeQuery();
		
		// rs -> board
		if(rs.next()) {
			b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setContent(rs.getString("content"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setRegdate(rs.getString("regdate"));
			b.setPass(rs.getString("pass"));
			b.setIp(rs.getString("ip"));
			b.setCount(rs.getInt("count"));
			
			
		}
			conn.close();
			return b;
	}
	
	public ArrayList<Board> selectBoardList(Paging p) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM board ORDER BY ref DESC, pos LIMIT ?, ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		rs = stmt.executeQuery();
		ArrayList<Board> list = new ArrayList<>();
		// rs -> list
		while(rs.next()) {
			Board b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("Depth"));
			b.setCount(rs.getInt("count"));
			
			list.add(b);
		}
		conn.close();
		return list; // list 반환
	}
	
	
	// 수정하기 메소드 값만 변환하는거라서 특별히 결과를 다시 사용자에게 전달할 필요는 없음
	public void updateBoard(Board board) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE board SET subject = ?, content = ? WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, board.getSubject());
		stmt.setString(2, board.getContent());
		stmt.setInt(3, board.getNum());
		
		stmt.executeUpdate();
		
		
		stmt.close();
		conn.close();
	}
	
	// 삭제하기 메소드 // deleteBoardSoft 쓰는 이유 : db에는 저장되고 삭제된것처럼 보이게 하는 것
	public void deleteBoardSoft(int num) throws ClassNotFoundException, SQLException { // 삭제할땐 글 번호만 알면 되서 int num
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		// 표시만 삭제하기위해는 UPDATE를 쓰는게 맞다
		String sql = "UPDATE board SET subject = ?, content = ? WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "삭제된 글입니다.");
		stmt.setString(2, "삭제된 글입니다.");
		stmt.setInt(3,num);
		
		stmt.executeUpdate();
		
		
		stmt.close();
		conn.close();
	}
	
	public int getTotal() throws ClassNotFoundException, SQLException {
		int total = 0;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		
		String sql = "SELECT count(*) cnt FROM board";
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
		
}





















