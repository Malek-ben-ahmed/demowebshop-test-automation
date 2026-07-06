*** Settings ***
Documentation    This file includes all test cases of the login page
Library    SeleniumLibrary

*** Variables ***
${invalid_email}=    malekbenahmed2008gmail.com
${inexisting_email}=    malekba@gmail.com
${inexisting_pwd}=    123456
${valid_email}=    malekbenahmed2008@gmail.com
${valid_pwd}=    Malek123
${url}=    https://demowebshop.tricentis.com/

*** Keywords ***
Open webpage
    Open Browser    ${url}    chrome
Go to Loginpage
    Click Element    xpath=/html/body/div[4]/div[1]/div[1]/div[2]/div[1]/ul/li[2]/a

*** Test Cases ***
Login with an invalid email
    [Tags]    1
    Open webpage
    Go to Loginpage
    Input Text    id=Email    ${invalid_email}
    Input Password    id=Password    ${valid_pwd}
    Click Element   xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div/div[2]/div[1]/div[2]/div[2]/form/div[5]
    ${text}=    Get Text    class=field-validation-error
    Should Match Regexp    ${text}    (S'il vous plaît, mettez une adresse email valide.|Please enter a valid email address.)
    Location Should Be    https://demowebshop.tricentis.com/login

Login with inexisting or empty email
    [Tags]    2
    Open webpage
    Go to Loginpage
    Input Text    id=Email    ${inexisting_email}
    Input Password    id=Password    ${valid_pwd}
    Click Element   xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div/div[2]/div[1]/div[2]/div[2]/form/div[5]
    ${text}=    Get Text    class=message-error
    Should Match Regexp    ${text}    (Aucun compte client trouvé|No customer account found)
    Location Should Be    https://demowebshop.tricentis.com/login

Login with inexisting or empty pwd
    [Tags]    3
    Open webpage
    Go to Loginpage
    Input Text    id=Email    ${valid_email}
    Input Password    id=Password    ${inexisting_pwd}
    Click Element   xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div/div[2]/div[1]/div[2]/div[2]/form/div[5]
    ${text}=    Get Text    class=message-error
    Should Match Regexp    ${text}    (Les informations d'identification fournies sont incorrectes.|The credentials provided are incorrect)
    Location Should Be    https://demowebshop.tricentis.com/login

Login with a valid email and pwd
    [Tags]    4
    Open webpage
    Go to Loginpage
    Input Text    id=Email    ${valid_email}
    Input Password    id=Password    ${valid_pwd}
    Click Element   xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div/div[2]/div[1]/div[2]/div[2]/form/div[5]
    Location Should Be    https://demowebshop.tricentis.com/
