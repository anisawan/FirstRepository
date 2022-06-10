*** Settings ***
Library  BuiltIn
Library  Autosphere.Tables
Library  Autosphere.Excel.Files
Library  Autosphere.Browser.Playwright
Library  ConfigrationFile.py

Test Setup  Open the browser
Test Teardown  Close the browser


*** Variables ***
${ExcelPath}
${configFile}=  config.ini  
${IniData}=  DATA


*** Keywords ***
Open ExcelFile 
    Open workbook  ${ExcelPath}
    ${tab}=  Read Worksheet As Table  Sheet1  header=True
    [Return]  ${tab}

Open the browser 
    Open Available Browser  https://stardex.com.ng/HR-On-boarding-Process-Form/  maximized= True
    
Form filling loop
    [Arguments]  ${tab}
    Set Global Variable  @{row}  ' '
    ${count} =  Get Length  ${tab}
    FOR  ${r}  IN RANGE  0  ${count}
         @{row}=  Get Table Row  ${tab}  ${r}  as_list=${TRUE}
        Fill the Form  ${tab}  ${row}
        Check the field required message found
        sleep  2
    END

Fill the Form
    [Arguments]  ${tab}  ${row}
    Input Text  (//*[@id="wpcf7-f1759-p1756-o1"]//input)[7]  ${row}[0]   
    Input Text  (//*[@id="wpcf7-f1759-p1756-o1"]//input)[8]  ${row}[1]
    Input Text  (//*[@id="wpcf7-f1759-p1756-o1"]//input)[9]  ${row}[2]
    Input Text  (//*[@id="wpcf7-f1759-p1756-o1"]//input)[10]  ${row}[3]
    Input Text  (//*[@id="wpcf7-f1759-p1756-o1"]//input)[11]  ${row}[4]
    Input Text  (//*[@id="wpcf7-f1759-p1756-o1"]//input)[12]  ${row}[5]
    Input Text  (//*[@id="wpcf7-f1759-p1756-o1"]//input)[13]  ${row}[6]
    # Select option from drop down
    Click Element  //option[contains(text(),'${row}[7]')]
    Select Checkbox  //*[@id="wpcf7-f1759-p1756-o1"]/form/div[2]/div/div[9]/div/p/span/span/span/label/input
    Click Button  //*[@id="wpcf7-f1759-p1756-o1"]/form/div[2]/div/div[10]/button
        
Check the field required message found 
    ${stat} =  Run Keyword And Return Status  Page Should Contain Element  (//*[@class="wpcf7-not-valid-tip"])
    IF  '${stat}' == 'True'
        Fill the Form  ${tab}  ${row}
    END 

Close the browser
    Close Browser



    

*** Tasks ***
Star can code day2
    ${ExPath}=  Get Value From Config File  ${configFile}  ${IniData}  path
    Set global variable  ${ExcelPath}  ${ExPath} 
    
    ${tab}  Open ExcelFile
    Form filling loop  ${tab}
