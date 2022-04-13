package com.ict.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ict.domain.BoardVO;
import com.ict.domain.PageMaker;
import com.ict.domain.SearchCriteria;
import com.ict.service.BoardService;

import lombok.extern.log4j.Log4j;



// 컨트롤러가 컨트롤러 기능을 할 수 있도록 처리해주세요.
@Controller
@Log4j
public class BoardController {

	// 컨트롤러는 Service만 호출하도록 구조를 바꿉니다.
	// Service를 BoardController 내부에서 쓸 수 있도록 선언/주입해주세요.
	@Autowired
	private BoardService boardservice;
	
	// 전체 글 목록을 볼 수 있는 페이지인 boardList.jsp로 연결되는
	// /boardList 주소를 get방식으로 선언해주세요.
	// 메서드 내부에서는 boardMapper의 .getList를 호출해 그 결과를 바인딩합니다.
	@GetMapping(value={"/boardList"})
	// @RequestParam(name="사용할 변수명", defaultValue="지정하고 싶은 기본값") 변수 왼쪽에 저렇게 붙여주면 처리완료.
	// @PathVariable의 경우 defaultValue를 직접 줄 수 없으나, required=false를 이용해 필수입력을 안받게 처리한 후
	// 컨트롤러 내부에서 디폴드값을 입력해줄 수 있습니다.
	// 기본형 자료는 null을 저장할 수 없기 때문에 wrapper class를 이용해 Long을 선언합니다.
	public String boardList(SearchCriteria cri, Model model) {
		/*if(pageNum == null) {
			pageNum = 1L; // Long형은 숫자 뒤에 L을 붙여야 대입됩니다.
		}
		log.info("PathVariable로 입력 받은 pageNum값 : " + pageNum);*/
		List<BoardVO> boardList = boardservice.getList(cri);
		log.info("넘어온 글 관련 정보 목록: " + boardList);
		model.addAttribute("boardList", boardList);
		
		// 버튼 처리를 위해 추가로 페이지메이커 생성 및 세팅
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);//cri 입력
		int countPage = boardservice.countPageNum();//131대신 실제로 DB내 글 개수를 가져옴
		pageMaker.setTotalBoard(countPage); // calcData()호출도 되면서 순식간에 prev, next,startPage, endPage 세팅
		model.addAttribute("pageMaker", pageMaker);
		return "boardList";
	}
	
	// 글 하나만 조회할 수 있는 디테일 페이지인 boardDetail.jsp로 연결되는
	// /boardDetail 주소를 get방식으로 선언해주세요.
	// 주소 뒤에 ?bno= 번호 형식으로 적힌 번호 글만 조회합니다.
	
	// @PathVariable 사용 시
	/*@GetMapping(value="/boardDetail/{bno}")
	public String boardDetail(@PathVariable long bno, Model model) {
		BoardVO board = boardmapper.select(bno);
		model.addAttribute("board", board);
		return "boardDetail";
	}*/
	
	// boardList.jsp에서 글 제목 클릭시 해당 글 번호를 파라미터값으로 해당 게시물로 가는 로직 사용 시
	@GetMapping(value="/boardDetail")
	public String boardDetail(long bno, Model model) {
		BoardVO board = boardservice.select(bno);
		model.addAttribute("board", board);
		return "boardDetail";
	}
	
	// insert 페이지를 위한 form으로 연결되는 컨트롤러를 먼저 만들겠습니다.
	// get방식으로 /boardInsert 주소를 접속시 form 페이지로 연결됩니다.
	// 홈 페이지의 이름은 boardForm.jsp입니다.
	@GetMapping(value="/boardInsert")
	public String boardForm() {
		return "boardForm";
	}
	
	// /boardInsert인데 post방식을 처리하는 메서드를 새로 만들어주세요.
	// BoardVO를 입력받고록 해 주시면 실제로는 BoardVO의 멤버 변수명으로 들어오는 자료를 입력받습니다.
	// 입력받은 BoardVO를 토대로 mapper쪽의 insert 메서드를 실행해주시고
	// 리다이렉트는 return "redirect:/목적지주소" 형식으로 리턴구문을 작성하면 됩니다.
	@PostMapping(value="boardInsert")
	public String boardInsert(BoardVO board, Model model) {
		boardservice.insert(board);
		return "redirect:/boardList";
	}
	
	// 글 삭제 로직은 Post 방식으로 진행합니다.
	// boardDelete 주소로 처리하고 bno를 받아서 해당 글을 삭제합니다.
	// 글 삭제 버튼은 detail페이지 하단에 form으로 만들어서 bno를 hidden으로 전달하는 
	// submit 버튼을 생성해서 처리하게 해주세요.
	@PostMapping(value="/boardDelete")
	public String boardDelete(long bno, Model model) {
		boardservice.delete(bno);
		return "redirect:/boardList";
	}
	
	// /boardUpdate를 Post 방식으로 접속하는 form 연결 메서드를 만들겠습니다.
	// update로직은 이미 데이터가 입력이 되어 있어야 합니다.
	// 따라서 내가 수정하고자 하는 글의 정보를 VO로 받아온다음 form 페이지에 포워딩해서 기입해놔야합니다.
	// form 페이지 이름은 boardUpdateForm.jsp 입니다.
	@PostMapping(value="/boardUpdateForm")
	public String boardUpdateForm(long bno, Model model) {
		BoardVO board = boardservice.select(bno);
		model.addAttribute("board", board);
		return "boardUpdateForm";
	}
	
	// boardUpdateForm.jsp 에서 수정하기 버튼을 클릭 시 입력한 데이터를 받아와
	// 수정한 데이터로 게시글을 표시해햐 합니다. 폼에서 날려준 데이터를 토대로
	// 해당 글의 내용이 수정되도록 만들어주시면 됩니다.
	// 리다이렉트 페이지는 boardDetail.jsp 입니다.
	@PostMapping(value="/boardUpdate")
	public String boardUpdate(BoardVO board, Model model) {
		boardservice.update(board);
		return "redirect:/boardDetail?bno=" + board.getBno();
	}
}
