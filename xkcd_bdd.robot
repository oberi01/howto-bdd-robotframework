*** Settings ***
Resource          ./xkcd_kw.robot
Library  String
Library  OperatingSystem
Library  RequestsLibrary

*** Test Cases ***
Download xkcd comic to a file
    [Documentation]  Test if png file is not empty

    Given Session "xkcd" to Site "https://xkcd.com"
    And URL Endpoint "/info.0.json" in Session "xkcd"

    When Response contains a Image URL
    And getting Comic in Session "xkcd"
    And writing Comic to File "${EXECDIR}/comic.png" 

    Then File "${EXECDIR}/comic.png" should not be empty 