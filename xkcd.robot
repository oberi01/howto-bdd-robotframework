*** Settings ***
Library  String
Library  OperatingSystem
Library  RequestsLibrary


*** Test Cases ***
Download XKCD img and write it to a file which should not be empty
    # verify certificates of https session
    Create Session    xkcd    https://xkcd.com   verify=true

    # fetch the URL of the latest comic png
    ${resp}  Get Request   xkcd    /info.0.json

    # extract the basename of the png file
    ${imgurl}   Set Variable   ${resp.json()['img']}
    ${_}  ${name}   Split String From Right    ${imgurl}  /  max_split=1

    # fetch the png file using this URL
    ${resp}  Get Request   xkcd    /comics/${name}

    # write the downloaded content to a file
    Create Binary File  ${EXECDIR}/${name}  ${resp.content}

    File Should Not Be Empty  ${EXECDIR}/${name}
