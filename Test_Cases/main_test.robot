*** Settings ***
Library		RequestsLibrary
Library 	JSONLibrary
Library 	Collections

Variables 	../Resources/Variables/api_data.py
Variables 	../Resources/Variables/config.py

Resource 	../Resources/Keywords/auth.robot
Resource 	../Resources/Keywords/reddit_works.robot


*** Test Cases ***
Reddit test
	${headers}=		Authorization

	Create Session 	auth 	${oauth_url}	verify=true

	${response}= 	GET On Session		auth	${api_get_me}	headers=${headers}
	Status Should Be	200		${response}

	Find Thread		${headers}