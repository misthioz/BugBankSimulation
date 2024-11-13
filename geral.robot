*** Settings ***
Library    SeleniumLibrary
Library    String

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



*** Test Cases ***

Registrar conta A
    Open Browser    url=${URL}    browser=chrome
    Maximize Browser Window
    Click Button    xpath=//button[text()='Registrar']
    
    Input Text    xpath=//div[@class='card__register']//input[@name='email']    ${EMAIL_A}

    Input Text    name=name    ${NAME_A}

    Input Text    xpath=//div[@class='card__register']//input[@name='password']    ${PASSWORD}

    Input Text    name=passwordConfirmation    ${PASSWORD}


    Scroll Element Into View    id=toggleAddBalance
    Click Element    xpath=//label[@id='toggleAddBalance']

    Sleep    1

    Click Button    xpath=//button[text()='Cadastrar']

    Sleep    3

    Click Element    xpath=//*[@id="btnCloseModal"]


Registrar conta B
    Click Button    xpath=//button[text()='Registrar']
    
    Input Text    xpath=//div[@class='card__register']//input[@name='email']    ${EMAIL_B}


    Input Text    name=name    ${NAME_B}

    Input Text    xpath=//div[@class='card__register']//input[@name='password']    ${PASSWORD}

    Input Text    name=passwordConfirmation    ${PASSWORD}

    Sleep    1

    Click Button    xpath=//button[text()='Cadastrar']

    Sleep    3

    Click Element    xpath=//*[@id="btnCloseModal"]

Logar usuario B
    Input Text    name=email    ${EMAIL_B}
    Input Password    name=password    ${PASSWORD}
    Sleep    1
    Click Button    xpath=//button[text()='Acessar']
    Sleep    3

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
    Input Text    //*[@id="__next"]/div/div[2]/div/div[1]/form/div[1]/input    ${EMAIL_A}
    Input Password    name=password    ${PASSWORD}
    Sleep    1
    Click Button    xpath=//button[text()='Acessar']
    Sleep    1
    

Visualizar estrato
    Click Element    //*[@id="btn-EXTRATO"]
    Sleep    3
    Click Element    //*[@id="btnBack"]
    Sleep    1

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




