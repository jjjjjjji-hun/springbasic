package com.report.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.report.domain.employeesVO;
import com.report.mapper.employeesMapper;

@Service
public class employeesServiceImpl implements employeesService{

	@Autowired
	private employeesMapper mapper;
	
	@Override
	public List<employeesVO> getList() {
		return mapper.getList();
	}

}
