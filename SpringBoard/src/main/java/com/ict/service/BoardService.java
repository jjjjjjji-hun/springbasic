package com.ict.service;

import java.util.List;

import com.ict.domain.BoardAttachVO;
import com.ict.domain.BoardVO;
import com.ict.domain.Criteria;
import com.ict.domain.SearchCriteria;

// 구현 클래스 BoardServiceImpl 뼈대가 됩니다.
public interface BoardService {

	// BoardMapper.java 에서 선언한 메서드를 복붙하면 쉽습니다.
	// 인터페이스 내에 먼저 메서드를 선언하고, impl 클래스에서 구현합니다.
	public List<BoardVO> getList(SearchCriteria cri);
	
	// 전체 글 개수를 얻어오는 로직
	public int countPageNum(SearchCriteria cri);
	
	// 글 하나를 가져오는 로직
	public BoardVO select(long bno);
	
	// 글 하나를 생성하는 로직
	public void insert(BoardVO vo);

	// 글 하나를 삭제하는 로직
	public void delete(long bno);
	
	// 글 하나를 수정하는 로직
	public void update(BoardVO vo);
	
	// 게시물에 연동된 첨부파일 목록 가져오기
	public List<BoardAttachVO> getAttachList(Long bno);
}
