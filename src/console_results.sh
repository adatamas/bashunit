#!/bin/bash

export renderResult
export printSuccessfulTest

function renderResult() {
  local totalTests=$1
  local totalPassed=$2
  local totalFailed=$3

  echo ""
  local totalAssertions=$((totalPassed + totalFailed))
  printf "\
${COLOR_FAINT}%s${COLOR_DEFAULT} ${COLOR_BOLD}${totalTests}${COLOR_DEFAULT}
${COLOR_FAINT}%s${COLOR_DEFAULT} ${COLOR_BOLD}${totalAssertions}${COLOR_DEFAULT}\n" \
  "Total tests:" "Total assertions:"

  if [ "$totalFailed" -gt 0 ]; then
    printf "${COLOR_FAINT}%s${COLOR_DEFAULT} ${COLOR_BOLD}${COLOR_FAILED}${totalFailed}${COLOR_DEFAULT}\n"\
    "Total assertions failed:"
    printExecTime
    exit 1
  else
    printf "${COLOR_ALL_PASSED}%s${COLOR_DEFAULT}\n" "All assertions passed."
  fi

  printExecTime
  exit 0
}

function printExecTime() {
  if [[ $OS != "OSX" ]]; then
    _TIME_TERMINATION=$((($(date +%s%N) - "$_TIME_START") / 1000000))
    printf "${COLOR_BOLD}%s${COLOR_DEFAULT}\n" "Time taken: ${_TIME_TERMINATION} ms"
  fi
}

function printSuccessfulTest() {
  testName=$1
  printf "${COLOR_PASSED}✓ Passed${COLOR_DEFAULT}: %s" "${testName}"
}

function printFailedTest() {
  testName=$1
  expected=$2
  failureConditionMessage=$3
  actual=$4
  printf "\
${COLOR_FAILED}✗ Failed${COLOR_DEFAULT}: %s
    ${COLOR_FAINT}Expected${COLOR_DEFAULT} ${COLOR_BOLD}'%s'${COLOR_DEFAULT}
    ${COLOR_FAINT}%s${COLOR_DEFAULT} ${COLOR_BOLD}'%s'${COLOR_DEFAULT}"\
  "${testName}" "${expected}" "${failureConditionMessage}" "${actual}"

}

# Set a trap to call renderResult when the script exits
trap 'renderResult $_TOTAL_TESTS $_TOTAL_ASSERTIONS_PASSED $_TOTAL_ASSERTIONS_FAILED' EXIT
