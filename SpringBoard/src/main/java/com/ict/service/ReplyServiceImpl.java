package com.ict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.domain.ReplyVO;
import com.ict.mapper.BoardMapper;
import com.ict.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	// 서비스는 mapper를 호출하기 때문에 mapper 생성
	@Autowired
	private ReplyMapper replymapper;
	
	@Autowired
	private BoardMapper boardmapper;
	
	@Transactional
	@Override
	public void addReply(ReplyVO vo) {
		replymapper.create(vo);
		//Long bno = mapper.getBno(vo.getBno());
		boardmapper.updateReplyCount(vo.getBno(), 1);
	}

	@Override
	public List<ReplyVO> listReply(Long bno) {
		return replymapper.getList(bno);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		replymapper.update(vo);
	}

	@Transactional
	@Override
	public void removeReply(Long rno) {
		// 글 삭제 전에 먼저 bno번을 채취해놓고
		Long bno = replymapper.getBno(rno);
		// 다음 글 삭제해야하 문제없이 글 번호를 가져옵니다.
		replymapper.delete(rno);
		boardmapper.updateReplyCount(bno, -1);
	}

}
