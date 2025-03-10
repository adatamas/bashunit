# Changelog

## [Unreleased](https://github.com/TypedDevs/bashunit/compare/0.9.0...main)

- Installer no longer needs git
- Add `assert_contains_ignore_case`
- Add `assert_equals_ignore_colors`
- Add `assert_match_snapshot`
- Add `SHOW_EXECUTION_TIME` to environment config
- Add docs for environment variables
- Improve data provider output

## [0.9.0](https://github.com/TypedDevs/bashunit/compare/0.8.0...0.9.0) - 2023-10-15

- Optimised docs Fonts (Serving directly from origin instead of Google Fonts _proxy_)
- Add Brew installation to docs
- Add `--help` option
- Add `-e|--env` option
- Add `-S|--stop-on-failure` option
- Add data_provider
- Add blog posts to the website
- Add `assert_string_not_starts_with`
- Add `assert_string_starts_with`
- Add `assert_string_ends_with`
- Add `assert_string_not_ends_with`
- Add `assert_less_than`
- Add `assert_less_or_equal_than`
- Add `assert_greater_than`
- Add `assert_greater_or_equal_than`

## [0.8.0](https://github.com/TypedDevs/bashunit/compare/0.7.0...0.8.0) - 2023-10-08

- Rename these functions from camelCase to snake_case:
    - `setUp` -> `set_up`
    - `tearDown` -> `tear_down`
    - `setUpBeforeScript` -> `set_up_before_script`
    - `tearDownAfterScript` -> `tear_down_after_script`
- Add --version option
- Add -v|--verbose option
- Add ASCII art logo
- Find all test on a directory
- Add skip and todo functions
- Add SIMPLE_OUTPUT to `.env`
- Allow using `main` or `latest` when using install.sh

## [0.7.0](https://github.com/TypedDevs/bashunit/compare/0.6.0...0.7.0) - 2023-10-02

- Added `--simple` argument for a simpler output
- Manage error when test execution fails
- Split install and build scripts
- Added these functions
    - `mock`
    - `spy`
    - `assert_have_been_called`
    - `assert_have_been_called_with`
    - `assert_have_been_called_times`
    - `assert_file_exists`
    - `assert_file_not_exists`
    - `assert_is_file_empty`
    - `assert_is_file`
    - `assert_directory_exists`
    - `assert_directory_not_exists`
    - `assert_is_directory`
    - `assert_is_directory_empty`
    - `assert_is_directory_not_empty`
    - `assert_is_directory_readable`
    - `assert_is_directory_not_readable`
    - `assert_is_directory_writable`
    - `assert_is_directory_not_writable`
- Rename assertions from camelCase to snake_case:
    - `assertEquals` -> `assert_equals`
    - `assertNotEquals` -> `assert_not_equals`
    - `assertEmpty` -> `assert_empty`
    - `assertNotEmpty` -> `assert_not_empty`
    - `assertContains` -> `assert_contains`
    - `assertNotContains` -> `assert_not_contains`
    - `assertMatches` -> `assert_matches`
    - `assertNotMatches` -> `assert_not_matches`
    - `assertExitCode` -> `assert_exit_code`
    - `assertSuccessfulCode` -> `assert_successful_code`
    - `assertGeneralError` -> `assert_general_error`
    - `assertCommandNotFound` -> `assert_command_not_found`
    - `assertArrayContains` -> `assert_array_contains`
    - `assertArrayNotContains` -> `assert_array_not_contains`

## [0.6.0](https://github.com/TypedDevs/bashunit/compare/0.5.0...0.6.0) - 2023-09-19

- Added `assertExitCode`
- Added `assertSuccessfulCode`
- Added `assertGeneralError`
- Added `assertCommandNotFound`
- Added `assertArrayContains`
- Added `assertArrayNotContains`
- Added `assertEmpty`
- Added `assertNotEmpty`
- Added `setUp`, `setUpBeforeScript`, `tearDown` and `tearDownAfterScript` function execution before and/or after test and/or script execution
- Improved the readability of the assert by using guard clause
- Update documentation
- Add support for the static analysis on macOS
- Fix bug with watcher for the development of bashunit
- Fix error on count assertions
- Added pipeline to add contributors to the readme
- Added documentation with VitePress
- Stop runner when found duplicate test functions

## [0.5.0](https://github.com/TypedDevs/bashunit/compare/0.4.0...0.5.0) - 2023-09-10

- Added logo
- Added `assertNotEquals`
- Added `assertMatches`
- Added `assertNotMatches`
- Added `make test/watch` to run your test every second
- Added time taken to run the test in ms (only to Linux)
- Simplified assertions over test results
- Added acceptance test to the library
- Added pre-commit to the project
- Allow parallel tests to run base on a .env configuration enabled by default
- Added static analysis tools to the deployment pipelines
- New summary output

## [0.4.0](https://github.com/TypedDevs/bashunit/compare/0.3.0...0.4.0) - 2023-09-08

- Better output colors and symbols
- Add option `--filter` to `./bashunit` script
    - Trigger tests filtered by name
- Change the output styles
    - Emojis
    - Colors
    - Bolds
- Added count to all test

## [0.3.0](https://github.com/TypedDevs/bashunit/compare/0.2.0...0.3.0) - 2023-09-07

- Added `assertContains`
- Added `assertNotContains`
- Display Passed tests in green, and Failed tests in red
- Avoid stop running tests after a failing one test

## [0.2.0](https://github.com/TypedDevs/bashunit/compare/0.1.0...0.2.0) - 2023-09-05

- Fix keeping in memory test func after running them
- Create a `./bashunit` entry point
- Change ROOT_DIR to BASHUNIT_ROOT_DIR
- Allow writing test with camelCase as well
- Allow running example log_test from anywhere

## [0.1.0](https://github.com/TypedDevs/bashunit/compare/27269c2...0.1.0) - 2023-09-04

- Added `assertEquals` function
