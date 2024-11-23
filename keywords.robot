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
