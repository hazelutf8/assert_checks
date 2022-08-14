cmake_minimum_required(VERSION 3.3)

include(CTest)


# @file a_header_template.h
# @brief A summary description
# @copyright Copyright (C) 2022 hazelutf8 SPDX-License-Identifier: MIT OR Apache-2.0
# @author hazelutf8
#
# @def add_target_ctest
#
# @pre Required precondition for use
# @post Operational postcondition to be handled
# @param[in]    TARGET     Name of target to test
# @param[in]    TEST_ONLY  Defaults to TRUE which only builds the input target for `ctest`, else FALSE for common build
# @param[in]    BUILD_OK   Defaults to TRUE asserts the build must succeed, else FALSE asserts the build must fail
# @param[in]    RUN_OK     Defaults to TRUE asserts the execution must succeed, else FALSE asserts the run must fail
#
# @code{.CMake}
# add_target_ctest(TARGET my_exe_target
#     TEST_ONLY TRUE
#     BUILD_OK  TRUE
#     RUN_OK    TRUE
# )
# @endcode
#
# @since Version 0.1.0
#
# @see: https://jeremimucha.com/2021/02/cmake-functions-and-macros/
#/
function(add_target_ctest)
    cmake_minimum_required(VERSION 3.3)  # Lowest tested

    # Parse Arguments
    set(pre ATCT)
    set(noValues)
    set(singleValues
        TARGET
        TEST_ONLY
        BUILD_OK
        RUN_OK
    )
    set(multiValues)
    set(requiredArgs
        TARGET
    )
    include(CMakeParseArguments)
    cmake_parse_arguments(
        ${pre}
        "${noValues}"
        "${singleValues}"
        "${multiValues}"
        ${ARGN}
    )
    set(MISSING_ARGS "FALSE")
    foreach(arg IN LISTS requiredArgs)
        if(NOT DEFINED ${pre}_${arg})
            set(MISSING_ARGS "TRUE")
            message(WARNING
                "Missing argument ${arg} at line ${CMAKE_CURRENT_LIST_LINE}"
            )
        endif()
    endforeach()
    if(${MISSING_ARGS})
        message("Use: add_target_ctest(...)")
        message("")
        message("TARGET        Required - String name of target to test")
        message("TEST_ONLY     Optional - Defaults to TRUE, (TRUE/FALSE)")
        message("BUILD_OK      Optional - Defaults to TRUE, (TRUE/FALSE")
        message("RUN_OK        Optional - Defaults to TRUE, (TRUE/FALSE/IGNORE)"
        )
        message("")
        message("Description:")
        message("  Given some target to test,")
        message("    by default disable building (skipped in `cmake --build`),")
        message("    and `ctest` verifies built and/or executed successfully.")
        message("  Run success means runs and exits with success value 0 code.")
        message("")
        message(WARNING "Missing argument(s)")
    endif()

    set(build_test test_build_${${pre}_TARGET})
    set(run_test "test_run_${${pre}_TARGET}")
    enable_testing()

    # When provided target is only for testing, disable it in normal builds
    set(TEST_ONLY TRUE)  # Default value if ${pre}_TEST_ONLY is not defined
    if(DEFINED ${pre}_TEST_ONLY)
        if(${TEST_ONLY})  # Could be TRUE/IGNORE, but assume non-FALSE
            set(TEST_ONLY TRUE)
        else()
            set(TEST_ONLY FALSE)
        endif()
    endif()
    if(${TEST_ONLY})
        #message("TARGET: ${${pre}_TARGET}")
        set_target_properties(${${pre}_TARGET} PROPERTIES
            EXCLUDE_FROM_ALL TRUE
            EXCLUDE_FROM_DEFAULT_BUILD TRUE
        )
    endif()

    # Create target for build checking
    set(${BUILD_FAIL} FALSE)
    if(DEFINED ${pre}_BUILD_OK)
        if(${${pre}_BUILD_OK})
            set(BUILD_FAIL FALSE)
        else()
            set(BUILD_FAIL TRUE)
        endif()
    endif()
    add_test(${build_test}
        ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${${pre}_TARGET}
    )
    set_tests_properties("${build_test}" PROPERTIES
        WILL_FAIL "${BUILD_FAIL}"
    )

    # Create target for run checking
    set(RUN_FAIL FALSE)
    if(DEFINED ${pre}_RUN_OK)
        if("${${pre}_RUN_OK}" STREQUAL "IGNORE")
            set(RUN_FAIL IGNORE)
        else()
            if(${${pre}_RUN_OK})
                set(RUN_FAIL FALSE)
            else()
                set(RUN_FAIL TRUE)
            endif()
        endif()
    endif()
    if(${BUILD_FAIL})
        set(RUN_FAIL IGNORE)
    endif()
    if(NOT "${RUN_FAIL}" STREQUAL "IGNORE")
        add_test(${run_test} ${${pre}_TARGET})
        set_tests_properties(${run_test} PROPERTIES
            DEPENDS ${build_test}
        )
        set_tests_properties("${run_test}" PROPERTIES
            WILL_FAIL "${RUN_FAIL}"
        )
    endif()
endfunction()
