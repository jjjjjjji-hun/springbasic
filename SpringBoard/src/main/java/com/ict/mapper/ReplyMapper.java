package com.ict.mapper;

import java.util.List;

import com.ict.domain.ReplyVO;

public interface ReplyMapper {

	// 특정 게시판 bno번 글의 전체 댓글 목록 가져오기
	// bno번 글에 대한 정보가 있어야함.
	public List<ReplyVO> getList(Long bno);
	
	// 게시판 댓글 작성하기
	public void create(ReplyVO vo);
	
	// 작성한 댓글 수정하기
	public void update(ReplyVO vo);
	
	// 작성한 댓글 삭제하기
	// 댓글 삭제 시는 단일 댓글 하나만 삭제해야 하므로 댓글 번호를 받음.
	public void delete(Long rno);
	
	// 댓글번호로 글번호 유추하기
	public Long getBno(Long rno);
}
