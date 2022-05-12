package com.ict.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.domain.MemberVO;
import com.ict.mapper.MemberMapper;

@Service
public class SecurityServiceImpl implements SecurityService{

	@Autowired
	private MemberMapper membermapper;
	
	// 트랜잭션 걸면 더 좋음
	@Override
	public void insertMember(MemberVO vo) {
		membermapper.insertMemberTbl(vo);
		
		membermapper.insertMemberAuth(vo);
	}

}
