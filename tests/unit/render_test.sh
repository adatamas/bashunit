#!/bin/bash

function test_render_result_total_tests() {
  local total_tests=2
  local assertions_passed=5
  local assertions_failed=1

  # shellcheck disable=SC2059
  assertContains\
    "$(printf "${COLOR_FAINT}Total tests:${COLOR_DEFAULT} ${COLOR_BOLD}2${COLOR_DEFAULT}")"\
    "$(renderResult $total_tests $assertions_passed $assertions_failed)"
}

function test_render_result_total_assertions() {
  local total_tests=2
  local assertions_passed=5
  local assertions_failed=1
  # shellcheck disable=SC2059
  assertContains\
    "$(printf "${COLOR_FAINT}Total assertions:${COLOR_DEFAULT} ${COLOR_BOLD}6${COLOR_DEFAULT}")"\
    "$(renderResult $total_tests $assertions_passed $assertions_failed)"
}

function test_render_result_total_assertions_failed() {
  local total_tests=2
  local assertions_passed=5
  local assertions_failed=1

# shellcheck disable=SC2059
  assertContains\
    "$(printf "${COLOR_FAINT}Total assertions failed:${COLOR_DEFAULT} ${COLOR_BOLD}${COLOR_FAILED}1${COLOR_DEFAULT}")"\
    "$(renderResult $total_tests $assertions_passed $assertions_failed)"

}

function test_render_result_not_total_assertions_failed() {
  local total_tests=2
  local assertions_passed=5
  local assertions_failed=0

  assertNotContains\
    "Total assertions failed"\
    "$(renderResult $total_tests $assertions_passed $assertions_failed)"
}

function test_render_result_all_assertions_passed() {
  local total_tests=2
  local assertions_passed=5
  local assertions_failed=0

  assertContains\
    "All assertions passed."\
    "$(renderResult $total_tests $assertions_passed $assertions_failed)"
}

function test_render_result_not_all_assertions_passed() {
  local total_tests=2
  local assertions_passed=5
  local assertions_failed=1

  assertNotContains\
    "All assertions passed"\
    "$(renderResult $total_tests $assertions_passed $assertions_failed)"
}

function test_render_time_of_execution_when_all_assertions_passed() {
  local total_tests=2
  local assertions_passed=5
  local assertions_failed=1

  if [[ $OS != "OSX" ]]; then
    assertMatches\
      ".*Time taken: [[:digit:]]+ ms"\
      "$(renderResult $total_tests $assertions_passed $assertions_failed)"
  fi
}

function test_render_time_of_execution_when_not_all_assertions_passed() {
  local total_tests=2
  local assertions_passed=5
  local assertions_failed=1

  if [[ $OS != "OSX" ]]; then
    assertMatches\
      ".*Time taken: [[:digit:]]+ ms"\
      "$(renderResult $total_tests $assertions_passed $assertions_failed)"
  fi
}
