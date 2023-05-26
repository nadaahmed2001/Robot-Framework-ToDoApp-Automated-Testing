*** Settings ***
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${SleepTime}      3
${BROWSER}        Chrome
${URL}            file:///E:/FCAI/Year4%20Semester2/Software%20Testing/Assignments/Assignment%203/Assignment%203/Software-Testing-Assi3-Frontend/todo.html

*** Test Cases ***
AddNewToDo
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    ${SleepTime}
    @{rows_before}=    Get WebElements    xpath=//tbody[@id='todo-table']/tr
    ${count_rows_before}=    Get Length    ${rows_before}
    Input Text    id=todo    My Todo Test 1
    Input Text    id=desc    My Description Test 1
    Click Button    xpath=//*[@id="todo-form"]/button
    Input Text    id=todo    My Todo Test 2
    Input Text    id=desc    My Description Test 2
    Click Button    xpath=//*[@id="todo-form"]/button
    Input Text    id=todo    My Todo Test 3
    Input Text    id=desc    My Description Test 3
    Click Button    xpath=//*[@id="todo-form"]/button
    Sleep    ${SleepTime}
    Wait Until Element Is Visible    xpath=//tbody[@id='todo-table']/tr
    @{rows_after}=    Get WebElements    xpath=//tbody[@id='todo-table']/tr
    ${count_rows_after}=    Get Length    ${rows_after}
    ${expected_count}=    Evaluate    ${count_rows_before} + 3
    Should Be Equal As Integers    ${count_rows_after}    ${expected_count}
    Textfield Value Should Be    id=todo    expected=
    Textfield Value Should Be    id=desc    expected=
    Sleep    ${SleepTime}
    Close Browser

DeleteToDo
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//tbody[@id='todo-table']/tr//button[@class='btn btn-danger']    timeout=5s
    Sleep    ${SleepTime}
    @{rows_before}=    Get WebElements    xpath=//tbody[@id='todo-table']/tr
    ${count_rows_before}=    Get Length    ${rows_before}
    Click Button    xpath=//tbody[@id='todo-table']/tr//button[@class='btn btn-danger']
    @{rows_after}=    Get WebElements    xpath=//tbody[@id='todo-table']/tr
    ${count_rows_after}=    Get Length    ${rows_after}
    ${expected_count}=    Evaluate    ${count_rows_before} - 1
    Should Be Equal As Integers    ${count_rows_after}    ${expected_count}
    sleep    ${SleepTime}
    Close Browser

UpdateCompletion
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    ${SleepTime}
    @{checkboxes}=    Get WebElements    xpath=//input[@type='checkbox']
    FOR    ${checkbox}    IN    @{checkboxes}
        ${checked}=    Get Element Attribute    ${checkbox}    checked
        Continue For Loop If    '${checked}' == 'true'
        Run Keyword If    '${checked}' != 'true'    Click Element    ${checkbox}
        Checkbox Should Be Selected    ${checkbox}
        Exit For Loop
    END
    sleep    ${SleepTime}
    Close Browser

Get all TODOs
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5 seconds
    Click Button    List All
    sleep    ${SleepTime}
    @{todo_rows}=    Get WebElements    xpath=//tbody[@id='todo-table']/tr
    FOR    ${row}    IN    @{todo_rows}
        ${todo_columns}=    Get WebElements    xpath=//td
        ${todo_id}=    Get Text    ${todo_columns}[0]
        ${title}=    Get Text    ${todo_columns}[1]
        ${description}=    Get Text    ${todo_columns}[2]
        ${completed}=    Get Element Attribute    xpath=.//td//input[@type='checkbox']    value
        ${delete_button}=    Get Text    ${todo_columns}[4]
        Should Not Be Empty    ${todo_id}
        Should Not Be Empty    ${title}
        Should Not Be Empty    ${description}
        Should Not Be Empty    ${completed}
        Should Not Be Empty    ${delete_button}
    END
    Close Browser

GetCompleted
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5 seconds
    Click Button    List Completed
    sleep    ${SleepTime}
    @{todo_rows}=    Get WebElements    xpath=//tbody[@id='todo-table']/tr
    FOR    ${row}    IN    @{todo_rows}
        ${todo_columns}=    Get WebElements    xpath=.//td
        ${todo_id}=    Get Text    ${todo_columns}[0]
        ${title}=    Get Text    ${todo_columns}[1]
        ${description}=    Get Text    ${todo_columns}[2]
        ${completed}=    Get Element Attribute    xpath=.//td//input[@type='checkbox']    value
        ${delete_button}=    Get Text    ${todo_columns}[4]
        Should Be Equal    ${completed}    on
        Should Not Be Empty    ${todo_id}
        Should Not Be Empty    ${title}
        Should Not Be Empty    ${description}
        Should Not Be Empty    ${delete_button}
    END
    Close Browser
