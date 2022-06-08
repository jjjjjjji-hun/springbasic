package com.report.domain;

import java.util.Date;

import lombok.Data;

@Data
public class employeesVO {

	private Long employee_id;
	private String first_name;
	private String last_name;
	private String email;
	private String phone_number;
	private Date hire_date;
	private String job_id;
	private Long salary;
	private Long commission_pct;
	private Long manager_id;
	private Long department_id;
}
