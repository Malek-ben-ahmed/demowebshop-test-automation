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

Filter products By price lower than 25,00
    [Tags]    10
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[2]/div/div[2]/ul/li[1]/a
    ${elements}    Get WebElements    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[1]/div/div[2]/div[3]/div[1]/span[2]
    ${filtrage}=    Set Variable    ${True}

    FOR    ${element}    IN    @{elements}
        ${prix}=    Get Text    ${element}
        IF    int(${prix}) > 25
            ${filtrage}=    Set Variable    ${False}
            BREAK
        END
    END
    Should Be Equal    ${filtrage}    ${True}

Filter products By price between 25,00-50,00
    [Tags]    11
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[2]/div/div[2]/ul/li[2]/a
    ${elements}    Get WebElements    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[1]/div/div[2]/div[3]/div[1]/span[2]
    ${filtrage}=    Set Variable    ${True}

    FOR    ${element}    IN    @{elements}
        ${prix}=    Get Text    ${element}
        IF    50<int(${prix}) or int(${prix})<25
            ${filtrage}=    Set Variable    ${False}
            BREAK
        END
    END
    Should Be Equal    ${filtrage}    ${True}

Filter products By price higher than 50,00
    [Tags]    12
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[2]/div/div[2]/ul/li[3]/a
    ${elements}    Get WebElements    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[1]/div/div[2]/div[3]/div[1]/span[2]
    ${filtrage}=    Set Variable    ${True}

    FOR    ${element}    IN    @{elements}
        ${prix}=    Get Text    ${element}
        IF    int(${prix})<50
            ${filtrage}=    Set Variable    ${False}
            BREAK
        END
    END
    Should Be Equal    ${filtrage}    ${True}

Delete filter option
    [Tags]    13
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[2]/div/div[2]/ul/li[3]/a
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[2]/div/div[2]/div[2]/a
    ${elements}=    Get WebElements    class=product-grid
    ${nb}=    Set Variable    ${TRUE}
    ${length}=    Get Length    ${elements}
    IF    ${length}>7
        ${nb}=    Set Variable    ${False}
    END
    Should Be Equal    ${nb}    ${True}

User can add one or more Book to the shopping cart from Add to cart button
    [Tags]    14
    Click on Books product
    Click Element   xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[1]/div/div[2]/div[3]/div[2]
    Sleep    500ms
    Click Element   xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[1]/div/div[2]/div[3]/div[2]
    Wait Until Element Contains    xpath=//*[@id="topcartlink"]/a/span[2]    (2)    10s
    ${web_element}    Get WebElements    class=cart-qty
    ${Qté}    Get Text    ${web_element}[0]
    Should Be Equal    ${Qté}    (2)

User can add one or more Book to the shopping cart from product information
    [Tags]    15
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[5]/div/div[2]/h2/a
    Click Button    id=add-to-cart-button-22
    Wait Until Element Contains    xpath=//*[@id="topcartlink"]/a/span[2]    (1)    10s
    ${web_element}    Get WebElements    class=cart-qty
    ${Qté}    Get Text    ${web_element}[0]
    Should Be Equal    ${Qté}    (1)
User can get all informations about the book added to shopping cart
    [Tags]    16
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[3]/div/div[2]/h2/a
    Click Button    id=add-to-cart-button-45
    Sleep    500ms
    Click Button    id=add-to-cart-button-45
    Click Element    class=cart-label
    ${product}    Get WebElements    class=product
    ${product_price}    Get Text    xpath=/html/body/div[4]/div[1]/div[4]/div/div/div[2]/div/form/table/tbody/tr/td[4]/span[2]
    ${product_total_price}    Get Text    xpath=/html/body/div[4]/div[1]/div[4]/div/div/div[2]/div/form/table/tbody/tr/td[6]/span[2]
    ${product_title}    Get Text    ${product}
    ${nb_product}    Get Value    xpath=/html/body/div[4]/div[1]/div[4]/div/div/div[2]/div/form/table/tbody/tr/td[5]/input
    Should Be Equal    ${product_title}    Fiction
    Should Be Equal    ${nb_product}    2
    Should Be Equal    ${product_price}    24.00
    Should Be Equal    ${product_total_price}    48.00
User can remove one or more books added to shopping cart
    [Tags]    17
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[1]/div/div[2]/div[3]/div[2]
    Sleep    500ms
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[5]/div/div[2]/div[3]/div[2]
    Wait Until Element Is Not Visible    id=bar-notification    10s
    Click Element    id=topcartlink
    Wait Until Element Is Visible    xpath=/html/body/div[4]/div[1]/div[4]/div/div/div[2]/div/form/table/tbody/tr/td[1]/input    20s
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div/div/div[2]/div/form/table/tbody/tr/td[1]/input
    Click Element    name=updatecart
    ${element}    Get WebElements    class=cart-item-row
    Length Should Be    ${element}    1
User can add Books to compare list which are added or not to shopping cart
    [Tags]    18
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[5]/div/div[2]/h2/a
    Click Element    class=compare-products
    Click Element    xpath=/html/body/div[4]/div[1]/div[2]/ul[1]/li[1]/a
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[3]/div/div[2]/h2/a
    Click Element    class=compare-products
    ${element}    Get WebElements    class=product-name
    ${product_title}    Get Text    ${element}
    Should Contain    ${product_title}    Fiction Health Book
User can remove Books from the compare list
    [Tags]    19
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[5]/div/div[2]/h2/a
    Click Element    class=compare-products
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div/div[2]/table/tbody/tr[1]/td[2]/div/p[1]/input
    ${element}    Get WebElements    class=page-body
    ${text}    Get Text    ${element}
    Should Be Equal    ${text}    You have no items to compare.

User can add Book to wishlist
    [Tags]    20
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[5]/div/div[2]/h2/a
    Click Button    id=add-to-wishlist-button-22
    Click Element    xpath=/html/body/div[4]/div[1]/div[1]/div[2]/div[1]/ul/li[4]/a
    ${whishlist}    Get WebElements    class=wishlist-qty
    ${qté}    Get Text    ${whishlist}
    Should Be Equal    ${qté}    (1)

User can add Book to shopping cart from whishlist
    [Tags]    21
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[5]/div/div[2]/h2/a
    Click Button    id=add-to-wishlist-button-22
    Click Element    xpath=/html/body/div[4]/div[1]/div[2]/ul[1]/li[1]/a
    Click Element    class=ico-wishlist
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div/div/div[2]/div[1]/form/table/tbody/tr/td[2]/input
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div/div/div[2]/div[1]/form/div/div/input[2]
    Wait Until Element Contains    xpath=//*[@id="topcartlink"]/a/span[2]    (1)    10s
    ${product_cart}    Get WebElements    class=cart-qty
    ${qté}    Get Text    ${product_cart}
    Should Be Equal    ${qté}    (1)

User can remove Book from whishlist
    [Tags]    22
    Click on Books product
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div[2]/div[2]/div[2]/div[3]/div[5]/div/div[2]/h2/a
    Click Button    id=add-to-wishlist-button-22
    Click Element    xpath=/html/body/div[4]/div[1]/div[2]/ul[1]/li[1]/a
    Click Element    class=ico-wishlist
    Click Element    xpath=/html/body/div[4]/div[1]/div[4]/div/div/div[2]/div[1]/form/table/tbody/tr/td[1]/input
    Click Element    name=updatecart
    ${text}    Get Text    class=page-body
    Should Be Equal    ${text}    The wishlist is empty!

User can search for a book
    [Tags]    23
    Click on Books product
    Input Text    id=small-searchterms    Health
    Press Keys    NONE    ENTER
    ${element}    Get WebElements    class=product-title
    ${title_book}    Get Text    ${element}
    Should Be Equal    ${title_book}    Health Book






