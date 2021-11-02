cmake_minimum_required(VERSION 2.18 FATAL_ERROR)

project(ctest_example)

set(CMAKE_C_STANDARD 99)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}")
include(assert_checks)

enable_testing()

assert_run_ok(check_run_success test_run_ok.c)
assert_run_fail(check_run_failure test_run_fail.c)
assert_build_ok(check_build_success test_build_ok.c)
assert_build_fail(check_build_failure test_build_fail.c)
