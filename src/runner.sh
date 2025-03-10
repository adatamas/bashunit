#!/bin/bash

function runner::load_test_files() {
  local filter=$1
  local files=("${@:2}") # Store all arguments starting from the second as an array

  if [[ ${#files[@]} == 0 ]]; then
    printf "%sError: At least one file path is required.%s\n" "${_COLOR_FAILED}" "${_COLOR_DEFAULT}"
    console_header::print_help
    exit 1
  fi

  for test_file in "${files[@]}"; do
    if [[ ! -f $test_file ]]; then
      continue
    fi

    # shellcheck source=/dev/null
    source "$test_file"

    runner::run_set_up_before_script
    runner::call_test_functions "$test_file" "$filter"
    if [ "$PARALLEL_RUN" = true ] ; then
      wait
    fi
    runner::run_tear_down_after_script
    runner::clean_set_up_and_tear_down_after_script
  done
}

function runner::call_test_functions() {
  local script="$1"
  local filter="$2"
  local prefix="test"
  # Use declare -F to list all function names
  local function_names
  function_names=$(declare -F | awk '{print $3}')
  local functions_to_run
  # shellcheck disable=SC2207
  functions_to_run=($(helper::get_functions_to_run "$prefix" "$filter" "$function_names"))

  if [[ "${#functions_to_run[@]}" -gt 0 ]]; then
    if [[ "$SIMPLE_OUTPUT" == false ]]; then
      echo "Running $script"
    fi

    helper::check_duplicate_functions "$script"

    for function_name in "${functions_to_run[@]}"; do
      local provider_data=()
      IFS=" " read -r -a provider_data <<< "$(helper::get_provider_data "$function_name" "$script")"

      if [[ "${#provider_data[@]}" -gt 0 ]]; then
        for data in "${provider_data[@]}"; do
          runner::run_test "$function_name" "$data"
        done
      else
        runner::run_test "$function_name"
      fi

      unset "$function_name"
    done
  fi
}

function runner::parse_execution_result() {
  local execution_result=$1

  local assertions_failed
  assertions_failed=$(\
    echo "$execution_result" |\
    tail -n 1 |\
    sed -E -e 's/.*##ASSERTIONS_FAILED=([0-9]*)##.*/\1/g'\
  )

  local assertions_passed
  assertions_passed=$(\
    echo "$execution_result" |\
    tail -n 1 |\
    sed -E -e 's/.*##ASSERTIONS_PASSED=([0-9]*)##.*/\1/g'\
  )

  local assertions_skipped
  assertions_skipped=$(\
    echo "$execution_result" |\
    tail -n 1 |\
    sed -E -e 's/.*##ASSERTIONS_SKIPPED=([0-9]*)##.*/\1/g'\
  )

  local assertions_incomplete
  assertions_incomplete=$(\
    echo "$execution_result" |\
    tail -n 1 |\
    sed -E -e 's/.*##ASSERTIONS_INCOMPLETE=([0-9]*)##.*/\1/g'\
  )

  _ASSERTIONS_PASSED=$((_ASSERTIONS_PASSED + assertions_passed))
  _ASSERTIONS_FAILED=$((_ASSERTIONS_FAILED + assertions_failed))
  _ASSERTIONS_SKIPPED=$((_ASSERTIONS_SKIPPED + assertions_skipped))
  _ASSERTIONS_INCOMPLETE=$((_ASSERTIONS_INCOMPLETE + assertions_incomplete))
}

function runner::run_test() {
  local function_name="$1"
  local data="$2"
  local current_assertions_failed
  current_assertions_failed="$(state::get_assertions_failed)"
  local current_assertions_incomplete
  current_assertions_incomplete="$(state::get_assertions_incomplete)"
  local current_assertions_skipped
  current_assertions_skipped="$(state::get_assertions_skipped)"

  exec 3>&1

  local test_execution_result
  test_execution_result=$(
    state::initialize_assertions_count
    runner::run_set_up

    "$function_name" "$data" 2>&1 1>&3

    runner::run_tear_down
    state::export_assertions_count
  )

  exec 3>&-

  runner::parse_execution_result "$test_execution_result"

  local runtime_error
  runtime_error=$(\
    echo "$test_execution_result" |\
    head -n 1 |\
    sed -E -e 's/(.*)##ASSERTIONS_FAILED=.*/\1/g'\
  )

  if [[ -n $runtime_error ]]; then
    state::add_tests_failed
    console_results::print_error_test "$function_name" "$runtime_error"
    return
  fi

  if [[ "$current_assertions_failed" != "$(state::get_assertions_failed)" ]]; then
    state::add_tests_failed

    if [ "$STOP_ON_FAILURE" = true ]; then
      exit 1
    fi

    return
  fi

  if [[ "$current_assertions_incomplete" != "$(state::get_assertions_incomplete)" ]]; then
    state::add_tests_incomplete
    return
  fi

  if [[ "$current_assertions_skipped" != "$(state::get_assertions_skipped)" ]]; then
    state::add_tests_skipped
    return
  fi

  local label
  label="$(helper::normalize_test_function_name "$function_name")"

  console_results::print_successful_test "${label}" "${data}"
  state::add_tests_passed
}

function runner::run_set_up() {
  helper::execute_function_if_exists 'setUp' # Deprecated: please use set_up instead.
  helper::execute_function_if_exists 'set_up'
}

function runner::run_set_up_before_script() {
  helper::execute_function_if_exists 'setUpBeforeScript' # Deprecated: please use set_up_before_script instead.
  helper::execute_function_if_exists 'set_up_before_script'
}

function runner::run_tear_down() {
  helper::execute_function_if_exists 'tearDown' # Deprecated: please use tear_down instead.
  helper::execute_function_if_exists 'tear_down'
}

function runner::run_tear_down_after_script() {
  helper::execute_function_if_exists 'tearDownAfterScript' # Deprecated: please use tear_down_after_script instead.
  helper::execute_function_if_exists 'tear_down_after_script'
}

function runner::clean_set_up_and_tear_down_after_script() {
  helper::unset_if_exists 'setUp' # Deprecated: please use set_up instead.
  helper::unset_if_exists 'set_up'
  helper::unset_if_exists 'tearDown' # Deprecated: please use tear_down instead.
  helper::unset_if_exists 'tear_down'
  helper::unset_if_exists 'setUpBeforeScript' # Deprecated: please use set_up_before_script instead.
  helper::unset_if_exists 'set_up_before_script'
  helper::unset_if_exists 'tearDownAfterScript' # Deprecated: please use tear_down_after_script instead.
  helper::unset_if_exists 'tear_down_after_script'
}
