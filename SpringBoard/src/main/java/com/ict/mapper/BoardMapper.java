package com.ict.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ict.domain.BoardVO;
import com.ict.domain.Criteria;
import com.ict.domain.SearchCriteria;

public interface BoardMapper {

	// board_tbl에서 글번호 3번 이하만 조회하는 쿼리문을
	// 어노테이션을 이용해 작성하면 @Select("SELECT * FROM board_tbl WHERE bno < 4") 
	// (어노테이션으로 쿼리문을 작성하면 xml 파일에는 쿼리문을 작성하면 안됩니다.)
	// 위와 같지만 이제는 쿼리문을 xml 파일에 작성하기 때문에 메서드는 이름과 용도에 따른 리턴자료형만 적습니다.
	// 버튼 추가를 위해 pageNum 대신 Criteria를 활용합니다.
	public List<BoardVO> getList(SearchCriteria cri);
	
	// insert구문 실행용으로 메서드를 선언합니다.
	// VO내부에 적혀있는 정보를 이용해 insert를 합니다.
    // BoardVO를 매개로 insert 정보를 전달받음.
	public void insert(BoardVO vo);
	
	// select구문은 글 번호를 입력받아서 해당 글 하나에 대한 정보만 얻어올 예정이므로
	// 리턴자료형은 글 하나를 담당할 수 있는 BoardVO로 해야합니다.
	public BoardVO select(long bno);
	
	// delete구문은 글 번호를 입력받아서 해당 글 하나에 대한 정보를 삭제합니다.
	public void delete(long bno);
	
	// 글 수정은 update 구문을 사용합니다.
	// 전달변수가 title, content, bno 이므로 단일 자료가 아닌 묶음으로 전달합니다.
	public void update(BoardVO vo);
	
	// vo안쓰고 데이터 전달하기
	// 2개 이상의 파라미터를 따로따로 전달할대는 각 파라미터 왼쪽에 @Param("보낼명칭")을 붙여줍니다.
	public void update2(@Param("title")String title, 
						@Param("content")String content, 
						@Param("bno")long bno);

	// 전체 글 개수를 얻어오는 countPageNum를 선언합니다.
	// 파라미터는 필요없습니다.
	// 글 개수 => 정수 값을 조회하기 때문에 int 리턴입니다.
	public int countPageNum(SearchCriteria cri);
	
	public void updateReplyCount(@Param("bno") Long bno,@Param("amount") int amount);
}
