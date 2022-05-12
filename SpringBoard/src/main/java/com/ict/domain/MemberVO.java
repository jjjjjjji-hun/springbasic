package com.ict.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userId;
	private String userPw;
	private String userName;
	private boolean enabled;
	private Date regDate;
	private Date updateDate;
	// join을 염두에 둔 VO 형태
	// 하나의 계정에 두 개 이상의 권한이 들어가는 상황도 있기 때문에
	// List로 처리함.
	private List<AuthVO> authList;
}
