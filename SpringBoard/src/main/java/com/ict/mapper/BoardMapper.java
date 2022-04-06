package com.ict.mapper;

import java.util.List;

import com.ict.domain.BoardVO;

public interface BoardMapper {

	// board_tbl에서 글번호 3번 이하만 조회하는 쿼리문을
	// 어노테이션을 이용해 작성하면 @Select("SELECT * FROM board_tbl WHERE bno < 4") 
	// (어노테이션으로 쿼리문을 작성하면 xml 파일에는 쿼리문을 작성하면 안됩니다.)
	// 위와 같지만 이제는 쿼리문을 xml 파일에 작성하기 때문에 메서드는 이름과 용도에 따른 리턴자료형만 적습니다.
	public List<BoardVO> getList();
	
	// insert구문 실행용으로 메서드를 선언합니다.
	// VO내부에 적혀있는 정보를 이용해 insert를 합니다.
    // BoardVO를 매개로 insert 정보를 전달받음.
	public void insert(BoardVO vo);
	
	// select구문은 글 번호를 입력받아서 해당 글 하나에 대한 정보만 얻어올 예정이므로
	// 리턴자료형은 글 하나를 담당할 수 있는 BoardVO로 해야합니다.
	public BoardVO select(long bno);
	
	// delete구문은 글 번호를 입력받아서 해당 글 하나에 대한 정보를 삭제합니다.
	public void delete(long bno);

}
