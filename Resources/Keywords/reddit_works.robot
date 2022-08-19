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

Submit Comment
	[Arguments]		${headers}		${thread_fullname}
	
	${data}=	Create Dictionary	parent=${thread_fullname}	text=${post_text}

	${response}=	Post On Session		threadWorks		${api_comment} 	data=${data}	headers=${headers}
	Status Should Be 	200		${response}

	${comment_fullname}=	Catenate	${response.json()['jquery'][-4][3][0][0]['data']['name']}

	[Return]	${comment_fullname}

Remove Comment
	[Arguments]		${headers}	${comment_fullname}
	${data}=	Create Dictionary	id=${comment_fullname}
	${response}=	POST On Session		threadWorks	${api_del}	data=${data}	headers=${headers}
	Status Should Be	200		${response}