--설치시 변경해야할 주소 위치
update i_training set 
	send_content = replace(send_content,'http://localhost:8080','http://messmon.co.kr:8088')
	, training_type2_content = replace(training_type2_content,'http://localhost:8080','http://messmon.co.kr:8088')
	, training_type2_content = replace(training_type3_content,'http://localhost:8080','http://messmon.co.kr:8088')
	, request_url = replace(request_url,'http://localhost:8080','http://messmon.co.kr:8088')
	, register_url = replace(register_url,'http://localhost:8080','http://messmon.co.kr:8088')

update i_template set 
	send_content = replace(send_content,'http://localhost:8080','http://messmon.co.kr:8088')
	, training_type2_content = replace(training_type2_content,'http://localhost:8080','http://messmon.co.kr:8088')
	, training_type2_content = replace(training_type3_content,'http://localhost:8080','http://messmon.co.kr:8088')
	