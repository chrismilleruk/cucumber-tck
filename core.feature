Feature: Core: Scenarios, Steps, Mappings

  Cucumber is a tool for executing business-readable specifications
  written in Gherkin. The basic unit of both specification and 
  execution is the Scenario. A Scenario is a list of steps, each of
  which representing an action performed by a user (or user agent)
  on the software product under development. When a Scenario is
  executed, its steps are applied to the software system in the order
  they are contained in the Scenario.

  Gherkin is not a programming language, so in order to execute steps 
  written in it, Cucumber must first look up a mapping from the text of
  each step to a function. If such a mapping exists, the function is
  executed, and the result is communicated to the user.

  Background:
    Given a scenario "Basic Arithmetic" with:
      """
      When I add 4 and 5
      Then the result is 9
      """

  Scenario: All steps passing means the scenario passes
    When Cucumber executes "Basic Arithmetic" with these step mappings:
      | I add 4 and 5   | passing |
      | the result is 9 | passing | 
    Then the scenario passes

  Scenario: Failing step means the scenario fails
    When Cucumber executes "Basic Arithmetic" with these step mappings:
      | I add 4 and 5   | failing |
      | the result is 9 | passing |
    Then the scenario fails
    And the step "the result is 9" is skipped

  Scenario: Pending step means the scenario is pending
    When Cucumber executes "Basic Arithmetic" with these step mappings:
      | I add 4 and 5   | pending |
      | the result is 9 | passing |
    Then the scenario is pending
    And the step "the result is 9" is skipped

  Scenario: Missing step mapping means the scenario is undefined
    When Cucumber executes "Basic Arithmetic" with these step mappings:
      | the result is 9 | passing |
    Then the scenario is undefined

  Scenario: Feature headers
    Given the following feature:
      """
      Feature: a feature
        In order to get results
        As a user
        I want to do something
      """
    When Cucumber runs the feature
    Then the feature should have passed

  Scenario: Simple flat steps
    Given the following scenario:
      """
      Given a calculator
      When the calculator computes PI
      Then the calculator returns PI
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed

  Scenario: Given, When, Then, And and But steps
    Given the following scenario:
      """
      Given a calculator
      When the calculator adds up 1 and 2
      And the calculator adds up 3 and 0.14159265
      Then the calculator returns PI
      But the calculator does not return 3
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed


  Scenario: Single-parameter step
    Given the following scenario:
      """
      Given a calculator
      When the calculator computes PI
      Then the calculator returns "3.14159265"
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed

  Scenario: Two-parameter step
    Given the following scenario:
      """
      Given a calculator
      When the calculator adds up "12" and "51"
      Then the calculator returns "63"
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed

  Scenario: Three-parameter step
    Given the following scenario:
      """
      Given a calculator
      When the calculator adds up "3", "4" and "5"
      Then the calculator returns "12"
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed

  Scenario: Steps accepting a DocString parameter
    Given the following scenario:
      """
      Given a calculator
      When the calculator adds up the following numbers:
        \"\"\"
        3
        6
        1
        \"\"\"
      Then the calculator returns "10"
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed
