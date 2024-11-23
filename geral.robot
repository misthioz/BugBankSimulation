*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    keywords.robot

*** Variables ***
${URL}    https://bugbank.netlify.app/
${ACC_FULLNUMER_B}    000-0
${ACC_NUMBER_B}    
${ACC_DIGIT_B}    

${driver}    webdriver.Chrome()

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
    ${ACC_FULLNUMER_B}=    Get Text    xpath=//p[@id='textAccountNumber']/span
    ${PARTS}    Split String    ${ACC_FULLNUMER_B}    -
    Set Global Variable    ${ACC_NUMBER_A}    ${PARTS}[0]
    Set Global Variable    ${ACC_DIGIT_A}    ${PARTS}[1]

    Log To Console    The full account number is: ${ACC_FULLNUMER_B}
    Log To Console    The account number is: ${ACC_NUMBER_B}
    Log To Console    The account digit is: ${ACC_DIGIT_B}

    Sleep    1
    Click Element    //*[@id="__next"]/div/div[1]/div
    Sleep    3


Logar na conta A
    Fazer login    myemailA@gmail.com    password
    

Caso positivo - realizar transação para conta B
    Realizar transação    ${ACC_NUMBER_B}    ${ACC_DIGIT_B}    100    Enviando 100 reais para a conta B

    Visualizar estrato

Caso negativo - realizar transação para conta inexistente
    Realizar transação    ${ACC_NUMBER_B}    ${ACC_DIGIT_B}    100    Enviando 100 reais para uma conta aleatória

Caso negativo - enviar valor negativo para a conta B
    Realizar transação    ${ACC_NUMBER_B}    ${ACC_DIGIT_B}    -100    Enviando -100 reais para a conta B

    Visualizar estrato


Caso negativo - enviar valor maior que o saldo para a conta B
    Realizar transação    ${ACC_NUMBER_B}    ${ACC_DIGIT_B}    2000    Enviando 2000 reais para a conta B

    Visualizar estrato



