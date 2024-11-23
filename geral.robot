*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    keywords.robot

*** Variables ***
${URL}    https://bugbank.netlify.app/
${EMAIL_A}    myemailA@gmail.com
${NAME_A}    usernameA
${ACC_FULLNUMER_A}    000-0
${ACC_NUMBER_A}    
${ACC_DIGIT_A}    

${EMAIL_B}    myemailB@gmail.com
${NAME_B}    usernameB

${PASSWORD}    mypassword


${driver}    webdriver.Chrome()

*** Keywords ***
Visualizar estrato
    Click Element    //*[@id="btn-EXTRATO"]
    Sleep    3
    Click Element    //*[@id="btnBack"]
    Sleep    1

*** Test Cases ***

Registrar conta A
    Open Browser    url=${URL}    browser=chrome
    Maximize Browser Window

    Registrar conta    usernameA    myemailA@gmail.com    password

Registrar conta B
    Registrar conta    usernameB    myemailB@gmail.com    password

Logar usuario B
    Fazer login    myemailB@gmail.com    password

Copiar numero da conta B e sair
    ${ACC_FULLNUMER_A}=    Get Text    xpath=//p[@id='textAccountNumber']/span
    ${PARTS}    Split String    ${ACC_FULLNUMER_A}    -
    Set Global Variable    ${ACC_NUMBER_A}    ${PARTS}[0]
    Set Global Variable    ${ACC_DIGIT_A}    ${PARTS}[1]

    Log To Console    The full account number is: ${ACC_FULLNUMER_A}
    Log To Console    The account number is: ${ACC_NUMBER_A}
    Log To Console    The account digit is: ${ACC_DIGIT_A}

    Sleep    1
    Click Element    //*[@id="__next"]/div/div[1]/div
    Sleep    3


Logar na conta A
    Fazer login    myemailA@gmail.com    password
    

Caso positivo - realizar transação para conta B
    Click Element    //*[@id="btn-TRANSFERÊNCIA"]
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[1]/input    ${ACC_NUMBER_A}
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[2]/input    ${ACC_DIGIT_A}
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[2]/input    20
    Input Text    //*[@id="__next"]/div/div[3]/form/div[3]/input    Enviando 20 reais para a conta B
    Sleep    2
    Click Button    //*[@id="__next"]/div/div[3]/form/button
    Sleep    3
    Click Element    xpath=//*[@id="btnCloseModal"]
    Sleep    2
    Click Element    //*[@id="btnBack"]

    Visualizar estrato

Caso negativo - realizar transação para conta inexistente
    Click Element    //*[@id="btn-TRANSFERÊNCIA"]
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[1]/input    111
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[2]/input    1
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[2]/input    100
    Input Text    //*[@id="__next"]/div/div[3]/form/div[3]/input    Enviando 100 reais para uma conta aleatoria
    Sleep    2
    Click Button    //*[@id="__next"]/div/div[3]/form/button
    Sleep    3
    Click Element    xpath=//*[@id="btnCloseModal"]
    Sleep    2
    Click Element    //*[@id="btnBack"]
    Sleep    2

Caso negativo - enviar valor negativo para a conta B
    Click Element    //*[@id="btn-TRANSFERÊNCIA"]
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[1]/input    ${ACC_NUMBER_A}
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[2]/input    ${ACC_DIGIT_A}
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[2]/input    -20
    Input Text    //*[@id="__next"]/div/div[3]/form/div[3]/input    Enviando -20 reais para a conta B
    Sleep    2
    Click Button    //*[@id="__next"]/div/div[3]/form/button
    Sleep    3
    Click Element    xpath=//*[@id="btnCloseModal"]
    Sleep    2
    Click Element    //*[@id="btnBack"]

    Visualizar estrato


Caso negativo - enviar valor maior que o saldo para a conta B
    Click Element    //*[@id="btn-TRANSFERÊNCIA"]
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[1]/input    ${ACC_NUMBER_A}
    Input Text    //*[@id="__next"]/div/div[3]/form/div[1]/div[2]/input    ${ACC_DIGIT_A}
    Sleep    1
    Input Text    //*[@id="__next"]/div/div[3]/form/div[2]/input    2000
    Input Text    //*[@id="__next"]/div/div[3]/form/div[3]/input    Enviando 2000 reais para a conta B
    Sleep    2
    Click Button    //*[@id="__next"]/div/div[3]/form/button
    Sleep    3
    Click Element    xpath=//*[@id="btnCloseModal"]
    Sleep    2
    Click Element    //*[@id="btnBack"]

    Visualizar estrato



