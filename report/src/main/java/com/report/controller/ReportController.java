package com.report.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.report.domain.employeesVO;
import com.report.service.employeesService;

@RestController
@RequestMapping("/report")
public class ReportController {

	@Autowired
	private employeesService service;
	
	@GetMapping(value="",
			produces = {MediaType.APPLICATION_XML_VALUE,
							MediaType.APPLICATION_JSON_UTF8_VALUE})
		public ResponseEntity<List<employeesVO>> getList(){
					ResponseEntity<List<employeesVO>> entity = null;
					
					try {
						entity = new ResponseEntity<>(service.getList(), HttpStatus.OK);
					}catch(Exception e) {
						e.printStackTrace();
						entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
					}
					return entity;
			}
}
