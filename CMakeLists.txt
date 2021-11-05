cmake_minimum_required(VERSION 2.18 FATAL_ERROR)

project(ctest_example)

set(CMAKE_C_STANDARD 99)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}")
include(assert_checks)

set(target test_run_ok)
add_executable(${target} ${target}.c)
assert_run_success(${target})

set(target test_run_fail)
add_executable(${target} ${target}.c)
assert_run_failure(${target})

set(target test_build_ok)
add_executable(${target} ${target}.c)
assert_build_success(${target})

set(target test_build_fail)
add_executable(${target} ${target}.c)
assert_build_failure(${target})
