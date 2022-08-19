*** Settings ***
Library		RequestsLibrary
Library 	JSONLibrary
Library 	Collections

Resource	./auth.robot

Variables	../Variables/thread_data.py
Variables	../Variables/api_data.py


*** Keywords ***
Find Thread
	[Arguments]		${headers}
	${search_post_url}=		Catenate 	SEPARATOR=		${api_search}		${post_name}

	Create Session	threadWorks 	${oauth_url}	verify=true
	${response}=	GET On Session		threadWorks		${search_post_url}		headers=${headers}
	Status Should Be	200		${response}

	${thread_fullname}=	Catenate	${response.json()['data']['children'][0]['data']['name']}

	[Return]	${thread_fullname}