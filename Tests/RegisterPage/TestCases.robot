*** Settings ***
Documentation    This file includes all the test cases of the Register page.
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${url}=    https://demowebshop.tricentis.com/
${valid_FirstName}=    malek
${valid_LastName}=    ben ahmed
${valid_email}=    malekbenahmed2008@gmail.com
${valid_pwd}=    Malek123

*** Keywords ***
Open webpage
    Open Browser    ${url}    chrome
Go to register page
    Click Element    xpath=/html/body/div[4]/div[1]/div[1]/div[2]/div[1]/ul/li[1]/a
Select male sexe
    Click Element    id=gender-male
Select female sexe
    Click Element    id=gender-female
Click register button
    Click Button    id=register-button




*** Test Cases ***
Register with valid data in all required fields
    [Tags]    1
    Open webpage
    Go to register page
    Select female sexe
    Input Text    id=FirstName    ${valid_FirstName}
    Input Text    id=LastName    ${valid_LastName}
    Input Text    id=Email    ${valid_email}
    Input Password    id=Password    ${valid_pwd}
    Input Password    id=ConfirmPassword    ${valid_pwd}
    Click register button
    ${text}=    Get Text    class=result
    Should Match Regexp    ${text}    (Votre inscription est terminée|Your registration completed)

Register with an invalid email format
    [Tags]    2
    Open webpage
    Go to register page
    Select female sexe
    Input Text    id=FirstName    ${valid_FirstName}
    Input Text    id=LastName    ${valid_LastName}
    Input Text    id=Email    malekbenahmed2011gmail.com
    Input Password    id=Password    Malak123
    Input Password    id=ConfirmPassword    Malak123
    Click register button
    ${text}=    Get Text    class=field-validation-error
    Should Match Regexp    ${text}    (Adresse e-mail incorrecte|Wrong email)
    Location Should Be    https://demowebshop.tricentis.com/register

Register with a password confirmation different from the password
    [Tags]    3
    Open webpage
    Go to register page
    Select female sexe
    Input Text    id=FirstName    ${valid_FirstName}
    Input Text    id=LastName    ${valid_LastName}
    Input Text    id=Email    malekbenahmed2013@gmail.com
    Input Password    id=Password    Malak123
    Input Password    id=ConfirmPassword    Hello1
    Click register button
    ${text}=    Get Text    class=field-validation-error
    Should Match Regexp    ${text}    (Le mot de passe et le mot de passe de confirmation ne correspondent pas.|The password and confirmation password do not match.)
    Location Should Be    https://demowebshop.tricentis.com/register

Register while leaving one or more required fields empty
    [Tags]    4
    Open webpage
    Go to register page
    Select female sexe
    Input Text    id=FirstName    ${valid_FirstName}
    Input Text    id=Email    malekbenahmed2014@gmail.com
    Input Password    id=Password    ${valid_pwd}
    Input Password    id=ConfirmPassword    ${valid_pwd}
    Click register button
    ${text}=    Get Text    class=field-validation-error
    Should Match Regexp    ${text}    (Le nom de famille est obligatoire.|Last name is required.)
    Location Should Be    https://demowebshop.tricentis.com/register

Register with an email already used by another account
    [Tags]    5
    Open webpage
    Go to register page
    Select female sexe
    Input Text    id=FirstName    ${valid_FirstName}
    Input Text    id=LastName    ${valid_LastName}
    Input Text    id=Email    malekbenahmed788@gmail.com
    Input Password    id=Password    ${valid_pwd}
    Input Password    id=ConfirmPassword    ${valid_pwd}
    Click register button
    ${text}=    Get Text    class=validation-summary-errors
    Should Match Regexp    ${text}    (L'adresse e-mail spécifiée existe déjà.|The specified email already exists)
    Location Should Be    https://demowebshop.tricentis.com/register

Register with a password shorter than 6characters
    [Tags]    6
    Open webpage
    Go to register page
    Select female sexe
    Input Text    id=FirstName    ${valid_FirstName}
    Input Text    id=LastName    ${valid_LastName}
    Input Text    id=Email    malekbenahmed2015@gmail.com
    Input Password    id=Password    123
    Input Password    id=ConfirmPassword    123
    Click register button
    ${text}=    Get Text    class=field-validation-error
    Should Match Regexp    ${text}    (Le mot de passe doit comporter au moins 6 caractères.|The password should have at least 6 characters.)
    Location Should Be    https://demowebshop.tricentis.com/register


Register with only spaces in text fields
    [Tags]    7
    Open webpage
    Go to register page
    Select female sexe
    Input Text    id=FirstName    ${valid_FirstName}
    Input Text    id=LastName    text=
    Input Text    id=Email    malekbenahmed2016@gmail.com
    Input Password    id=Password    ${valid_pwd}
    Input Password    id=ConfirmPassword    ${valid_pwd}
    Click register button
    ${text}=    Get Text    class=field-validation-error
    Should Match Regexp    ${text}    (Le nom de famille est obligatoire.|Last name is required.)
    Location Should Be    https://demowebshop.tricentis.com/register

Register with special characters in First Name or Last Name
    [Tags]    8
    Open webpage
    Go to register page
    Select female sexe
    Input Text    id=FirstName    text=Malek@
    Input Text    id=LastName    ${valid_LastName}
    Input Text    id=Email    malekbenahmed2017@gmail.com
    Input Password    id=Password    ${valid_pwd}
    Input Password    id=ConfirmPassword    ${valid_pwd}
    Click register button
    ${text}=    Get Text    class=result
    Should Match Regexp    ${text}    (Votre inscription est terminée|Your registration completed)


