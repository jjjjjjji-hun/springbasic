package com.ict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.ict.domain.ReplyVO;
import com.ict.mapper.ReplyMapper;

public class ReplyServiceImpl implements ReplyService {

	// 서비스는 mapper를 호출하기 때문에 mapper 생성
	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public void addReply(ReplyVO vo) {
		mapper.create(vo);
	}

	@Override
	public List<ReplyVO> listReply(Long bno) {
		return mapper.getList(bno);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.update(vo);
	}

	@Override
	public void removeReply(Long rno) {
		mapper.delete(rno);
	}

}