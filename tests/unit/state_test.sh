#!/bin/bash

# shellcheck disable=SC2034

function test_add_and_get_tests_passed() {
  local tests_passed
  tests_passed=$(
    _TESTS_PASSED=0

    state::add_tests_passed
    state::get_tests_passed
  )

  assertEquals "1" "$tests_passed"
}

function test_add_and_get_tests_failed() {
  local tests_failed
  tests_failed=$(
    _TESTS_FAILED=0

    state::add_tests_failed
    state::get_tests_failed
  )

  assertEquals "1" "$tests_failed"
}

function test_add_and_get_tests_skipped() {
  local tests_skipped
  tests_skipped=$(
    _TESTS_SKIPPED=0

    state::add_tests_skipped
    state::get_tests_skipped
  )

  assertEquals "1" "$tests_skipped"
}

function test_add_and_get_tests_incomplete() {
  local tests_incomplete
  tests_incomplete=$(
    _TESTS_INCOMPLETE=0

    state::add_tests_incomplete
    state::get_tests_incomplete
  )

  assertEquals "1" "$tests_incomplete"
}

function test_add_and_get_assertions_passed() {
  local assertions_passed
  assertions_passed=$(
    _ASSERTIONS_PASSED=0

    state::add_assertions_passed
    state::get_assertions_passed
  )

  assertEquals "1" "$assertions_passed"
}

function test_add_and_get_assertions_failed() {
  local assertions_failed
  assertions_failed=$(
    _ASSERTIONS_FAILED=0

    state::add_assertions_failed
    state::get_assertions_failed
  )

  assertEquals "1" "$assertions_failed"
}

function test_add_and_get_assertions_skipped() {
  local assertions_skipped
  assertions_skipped=$(
    _ASSERTIONS_FAILED=0

    state::add_assertions_skipped
    state::get_assertions_skipped
  )

  assertEquals "1" "$assertions_skipped"
}

function test_add_and_get_assertions_incomplete() {
  local assertions_incomplete
  assertions_incomplete=$(
    _ASSERTIONS_INCOMPLETE=0

    state::add_assertions_incomplete
    state::get_assertions_incomplete
  )

  assertEquals "1" "$assertions_incomplete"
}

function test_set_and_is_duplicated_test_functions_found() {
  local duplicated_test_functions_found
  duplicated_test_functions_found=$(
    _DUPLICATED_TEST_FUNCTIONS_FOUND=false

    state::set_duplicated_test_functions_found
    state::is_duplicated_test_functions_found
  )

  assertEquals "true" "$duplicated_test_functions_found"
}

function test_set_and_get_duplicated_function_names() {
  local duplicated_function_names
  duplicated_function_names=$(
    _DUPLICATED_FUNCTION_NAMES=""

    state::set_duplicated_function_names "duplicated_test_name"
    state::get_duplicated_function_names
  )

  assertEquals "duplicated_test_name" "$duplicated_function_names"
}

function test_initialize_assertions_count() {
  local export_assertions_count
  export_assertions_count=$(
    _ASSERTIONS_PASSED=10
    _ASSERTIONS_FAILED=5
    _ASSERTIONS_SKIPPED=42
    _ASSERTIONS_INCOMPLETE=12

    state::initialize_assertions_count
    state::export_assertions_count
  )

  assertEquals\
    "##ASSERTIONS_FAILED=0##ASSERTIONS_PASSED=0##ASSERTIONS_SKIPPED=0##ASSERTIONS_INCOMPLETE=0##"\
    "$export_assertions_count"
}

function test_export_assertions_count() {
  local export_assertions_count
  export_assertions_count=$(
    _ASSERTIONS_PASSED=10
    _ASSERTIONS_FAILED=5
    _ASSERTIONS_SKIPPED=42
    _ASSERTIONS_INCOMPLETE=12

    state::export_assertions_count
  )

  assertEquals\
    "##ASSERTIONS_FAILED=5##ASSERTIONS_PASSED=10##ASSERTIONS_SKIPPED=42##ASSERTIONS_INCOMPLETE=12##"\
    "$export_assertions_count"
}
