# BDD Demo mit Robotframework

## Was ist BDD und wie funktioniert dies in Robotframework
BDD steht für Behaviour Driven Development und ist ein Test-First Ansatz der eine eine Abstraktion auf Abnahmetest Ebene erlaubt.

BDD nutzt Gherkin Syntax für die Formulierung von Testfällen. 
Vereinfacht ausgedrückt, werden in Gherkin Klauseln definiert, die durch die Wörter Given, When, Then und And eingeleitet werden.

In Robotframework können die Wörter Given, When, Then und And Keywords vorangestellt werden, dies ist eine valide Robotframework Syntax.
Eine Semantik ist damit jedoch nicht verbunden.

## Mehrwert
In der Testautomatisierung ist durch BDD eine Aufgabentrennung zwischen Tester (ohne tiefergehende Programmierkenntnisse) und Testautomatisierer möglich.

Das Einführen von BDD in Robotframework erzwingt das Einführen einer fachlichen BDD Abstraktionsschicht, die zu lesbaren und wartbaren Testsuiten führt und einer technischen Schicht, die Keywords für die BDD Schicht bereitstellt.

Durch diese Abstraktionsschicht wird Wiederverwendbarkeit gewährleistet, da dem Tester bei der Erstellung der Testsuite nur die Keywords aus der technischen Schicht zur Verfügung stehen.

Die Abstraktionsschicht wird durch Robotframework auch im Logfile abgebildet, d.h. auch im Logfile erfolgt eine hierarchische Trennung zwischen BDD-Schicht und darunterliegender technischer Schicht (siehe rf_log.jpg)

## Beispiel
In diesem Beispiel wird eine Testsuite xkcd.robot auf die BDD Testsuite xkcd_bdd.robot abgebildet. Hierbei wird die Abstraktionsschicht xkcd_kw.robot eingeführt.

xkcd_bdd.robot:
```
    Given Session "xkcd" to Site "https://xkcd.com"
    And URL Endpoint "/info.0.json" in Session "xkcd"

    When Response contains a Image URL
    And getting Comic in Session "xkcd"
    And writing Comic to File "${EXECDIR}/comic.png" 

    Then File "${EXECDIR}/comic.png" should not be empty 
``` 

