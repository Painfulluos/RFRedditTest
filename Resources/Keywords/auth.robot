*** Settings ***
Library		RequestsLibrary
Library 	JSONLibrary
Library 	Collections

Variables	../Variables/login_data.py
Variables	../Variables/config.py

*** Keywords ***
Authorization
	${data}=	Create Dictionary	grant_type=password		username=${username}	password=${password}
	${auth}=	Create List		${app_id}	${app_secret}
	${headers}=	Create Dictionary 	user-agent=${user_agent}

	Create Session	authorization		${base_url}		headers=${headers}	auth=${auth} 	verify=true

	${response}=	POST On Session		authorization	${api_get_token}	data=${data}	headers=${headers}

	${token}=	Catenate	bearer	${response.json()["access_token"]}
	Set To Dictionary	${headers}	Authorization 	${token}
	
	[Return]	${headers}