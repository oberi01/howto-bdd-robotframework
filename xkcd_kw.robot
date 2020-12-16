*** Settings ***
Library  String
Library  OperatingSystem
Library  RequestsLibrary


*** Keywords ***
Session "${session}" to Site "${site}"
    # verify certificates of https session
    Create Session    ${session}    ${site}   verify=true

URL Endpoint "${endpoint}" in Session "${session}"
    # fetch the URL of the latest comic png
    ${RESP}  Get Request   ${session}    ${endpoint}
    Set Test Variable    ${RESP}

Response contains a Image URL
    # extract the basename of the png file
    ${imgurl}   Set Variable   ${RESP.json()['img']}
    ${_}  ${IMG_NAME}   Split String From Right    ${imgurl}  /  max_split=1
    Set Test Variable    ${IMG_NAME}

getting Comic in Session "${session}"
     # fetch the png file using this URL
    ${RESP}  Get Request   ${session}    /comics/${IMG_NAME}
    Set Test Variable    ${RESP}

writing Comic to File "${img_file}"
    # write the downloaded content to a file
    Create Binary File  ${img_file}  ${RESP.content}

File "${img_file}" should not be empty 
    File Should Not Be Empty  ${img_file}
