*** Settings ***
Library    SeleniumLibrary
Library    String


*** Variables ***
${NAME}
${EMAIL}
${PASSWORD}

*** Keywords ***
Visualizar estrato
    Click Element    //*[@id="btn-EXTRATO"]
    Sleep    3
    Click Element    //*[@id="btnBack"]
    Sleep    1

Registrar conta
    [Arguments]    ${NAME}    ${EMAIL}    ${PASSWORD}
    Click Button    xpath=//button[text()='Registrar']
    
    Input Text    xpath=//div[@class='card__register']//input[@name='email']    ${EMAIL}

    Input Text    name=name    ${NAME}

    Input Text    xpath=//div[@class='card__register']//input[@name='password']    ${PASSWORD}

    Input Text    name=passwordConfirmation    ${PASSWORD}


    Scroll Element Into View    id=toggleAddBalance
    Click Element    xpath=//label[@id='toggleAddBalance']

    Sleep    1

    Click Button    xpath=//button[text()='Cadastrar']

    Sleep    3

    Click Element    xpath=//*[@id="btnCloseModal"]


Fazer login
    [Arguments]    ${EMAIL}    ${PASSWORD}
    Input Text    name=email    ${EMAIL}
    Input Password    name=password    ${PASSWORD}
    Sleep    1
    Click Button    xpath=//button[text()='Acessar']
    Sleep    3

Realizar transação
    [Arguments]    ${ACC_NUMBER}    ${ACC_DIGIT}    ${VALUE}    ${MESSAGE}
    Click Element    //*[@id="btn-TRANSFERÊNCIA"]
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[1]/input    ${ACC_NUMBER}
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[2]/input    ${ACC_DIGIT}
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[2]/input    ${VALUE}
    Input Text    //*[@id="__next"]/div/div[3]/form/div[3]/input   ${MESSAGE}
    Sleep    2
    Click Button    //*[@id="__next"]/div/div[3]/form/button
    Sleep    3
    Click Element    xpath=//*[@id="btnCloseModal"]
    Sleep    2
    Click Element    //*[@id="btnBack"]