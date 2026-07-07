*** Settings ***
Documentation    this file includes all the test cases of HomePage
Library    SeleniumLibrary
Library    BuiltIn
Library    Collections

*** Variables ***
${url}=    https://demowebshop.tricentis.com/
@{pr_title_ordred}=    Computing and Internet    Copy of Computing and Internet EX    Fiction    Fiction EX    Health Book    Science
@{pr_title_ordred_inv}=    Science    Health Book    Fiction EX    Fiction    Copy of Computing and Internet EX    Computing and Internet

*** Keywords ***
Click on Books product
    Open Browser    ${url}    chrome
    Click Element    xpath=/html/body/div[4]/div[1]/div[2]/ul[1]/li[1]/a


*** Test Cases ***
Sorting Books By Name A to Z
    [Tags]    1
    Click on Books product
    Click Element    id=products-orderby
    Click Element    xpath=//*[@id="products-orderby"]/option[2]
    ${elements}=    Get WebElements    class=product-title
    @{pr_title}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${pr_title}    ${text}
    END
    Should Be Equal    ${pr_title}    ${pr_title_ordred}

Sorting Books By Name Z to A
    [Tags]    2
    Click on Books product
    Click Element    id=products-orderby
    Click Element    xpath=//*[@id="products-orderby"]/option[3]
    ${elements}=    Get WebElements    class=product-title
    @{pr_title}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${pr_title}    ${text}
    END
    Should Be Equal    ${pr_title}    ${pr_title_ordred_inv}

Sorting products By price from low to high
    [Tags]    3
    Click on Books product
    Click Element    id=products-orderby
    Click Element    xpath=//*[@id="products-orderby"]/option[4]
    ${elements}=    Get WebElements    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[1]/div/div[2]/div[3]/div[1]/span[2]
    @{pr_price}=    Create List
    ${ord}=    Set Variable    ${TRUE}
    ${length}=    Get Length    ${elements}
    FOR    ${index}    IN RANGE    0    ${length}-1
        ${text1}=    Get Text    ${elements}[${index}]
        ${text2}=    Get Text    ${elements}[${index}+1]
        IF    int(${text1})>int( ${text2})
            ${ord}=    Set Variable    ${False}
            BREAK
        END
    END
    Should Be Equal    ${ord}    ${True}

Sorting products By price from high to low
    [Tags]    4
    Click on Books product
    Click Element    id=products-orderby
    Click Element    xpath=//*[@id="products-orderby"]/option[5]
    ${elements}=    Get WebElements    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[1]/div/div[2]/div[3]/div[1]/span[2]
    @{pr_price}=    Create List
    ${ord}=    Set Variable    ${TRUE}
    ${length}=    Get Length    ${elements}
    FOR    ${index}    IN RANGE    0    ${length}-1
        ${text1}=    Get Text    ${elements}[${index}]
        ${text2}=    Get Text    ${elements}[${index}+1]
        IF    int(${text1})<int( ${text2})
            ${ord}=    Set Variable    ${False}
            BREAK
        END
    END
    Should Be Equal    ${ord}    ${True}

Display at most 4 articles per page
    [Tags]    5
    Click on Books product
    Click Element    id=products-pagesize
    Click Element    xpath=//*[@id="products-pagesize"]/option[1]
    ${elements}=    Get WebElements    class=product-grid
    ${nb}=    Set Variable    ${TRUE}
    ${length}=    Get Length    ${elements}
    IF    ${length}>3
        ${nb}=    Set Variable    ${False}
    END
    Should Be Equal    ${nb}    ${True}

Display at most 8 articles per page
    [Tags]    6
    Click on Books product
    Click Element    id=products-pagesize
    Click Element    xpath=//*[@id="products-pagesize"]/option[2]
    ${elements}=    Get WebElements    class=product-grid
    ${nb}=    Set Variable    ${TRUE}
    ${length}=    Get Length    ${elements}
    IF    ${length}>7
        ${nb}=    Set Variable    ${False}
    END
    Should Be Equal    ${nb}    ${True}

Display at most 12 articles per page
    [Tags]    7
    Click on Books product
    Click Element    id=products-pagesize
    Click Element    xpath=//*[@id="products-pagesize"]/option[3]
    ${elements}=    Get WebElements    class=product-grid
    ${nb}=    Set Variable    ${TRUE}
    ${length}=    Get Length    ${elements}
    IF    ${length}>11
        ${nb}=    Set Variable    ${False}
    END
    Should Be Equal    ${nb}    ${True}

Select a List view
    [Tags]    8
    Click on Books product
    Click Element    id=products-viewmode
    Click Element    xpath=//*[@id="products-viewmode"]/option[2]
    ${class}=    Get Element Attribute    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]    class
    Should Be Equal    ${class}    product-list

Select a Grid view
    [Tags]    9
    Click on Books product
    Click Element    id=products-viewmode
    Click Element    xpath=//*[@id="products-viewmode"]/option[1]
    ${class}=    Get Element Attribute    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]    class
    Should Be Equal    ${class}    product-grid


