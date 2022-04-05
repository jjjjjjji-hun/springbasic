package com.ict.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

// lombok을 이용해 getter, setter, 생성자, toString를 만들어주세요.
@Data
public class BoardVO {

	// board_tbl 구조에 맞게 멤버변수를 선언해주세요.
	private long bno;
	private String title;
	private String content;
	private String writer;
	private Timestamp regdate; // 초 단위 까지 나오는 속성이며, Data와 비교하기 위해 쓴 것이므로 신경 쓰지 않아도 됩니다.
	private Date updatedate;
}
