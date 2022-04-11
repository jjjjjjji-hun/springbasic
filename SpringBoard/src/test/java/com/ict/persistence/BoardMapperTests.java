package com.ict.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ict.domain.BoardVO;
import com.ict.mapper.BoardMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	// 이 테스트코드 내에서는 Mapper테스트를 담당합니다.
	// 따라서 BoardMapper 내부의 메서드를 실행할 예정이고
	// BoardMapper 타입의 변수가 필요하니 선언해주시고 자동 주입으로 넣어주세요.
	@Autowired
	private BoardMapper boardmapper;
	
	// 테스트용 메서드의 이름은 testGetList입니다.
	// 테스트 코드가 실행될 수 있도록 만들어주세요.
	@Test
	public void testGetList() {
		log.info("리스트 가져오기");
		log.info(boardmapper.getList(1));
	}
	
	// insert를 실행할 테스트코드를 하단에 작성해보겠습니다.
	//@Test
	public void testInsert() {
		// 글 입력을 위해서 BoardVO 타입을 매개로 사용합니다.
		// 따라서 BoardVO를 만들어놓고 setter로 글제목, 글본문, 글쓴이 만 저장해둔 채로
		// boardmapper.insert(vo);를 호출해서 실행여부를 확인하면 됩니다.
		// 위 설명을 토대로 아래 vo에 제목, 본문, 글쓴이를 넣고 호출해주신 다음에
		// 실제로 DB에 글이 들어갔는지 확인해주세요.
		BoardVO vo = new BoardVO();
		
		// 입력할 글에 대한 제목, 본문, 글쓴이를 vo에 넣어줍니다.
		vo.setTitle("새로넣는 글");
		vo.setContent("새로넣는 본문");
		vo.setWriter("새로넣는 글쓴이");
		boardmapper.insert(vo);
		log.info(boardmapper.getList(1));
	}
	
	// 하나의 글만 select 할 테스트 코드를 작성해보겠습니다.
	//@Test
	public void testGetSelect() {
		boardmapper.select(5);
	}
	
	// 하나의 글만 삭제하는 delete 테스트 코드를 작성해보겠습니다.
	//@Test
	public void testDelete() {
		boardmapper.delete(3);
	}
	
	// 하나의 글만 수정하는 update 테스트 코드를 작성해보겠습니다.
	//@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setTitle("수정한 제목");
		board.setContent("수정한 본문");
		board.setBno(4);
		boardmapper.update(board);
	}
	
	//@Test
	public void testUpdate2() {
		boardmapper.update2("up2로 바꾼 제목", "up2로 바꾼본문", 2);
	}
}
