cmake_minimum_required(VERSION 2.18)

include(CTest)

# Shall build ok, and run will return zero error code
function(assert_run_ok target_name src_list)
    set(test_name "test_${target_name}")

    add_executable(${target_name} ${src_list})

    enable_testing()
    add_test(${test_name} ${target_name})
endfunction()

# Shall build ok, and run will return non-zero error code
function(assert_run_fail target_name src_list)
    set(test_name "test_${target_name}")

    add_executable(${target_name} ${src_list})

    enable_testing()
    add_test(${test_name} ${target_name})
    set_tests_properties(${test_name} PROPERTIES WILL_FAIL TRUE)
endfunction()

# Shall build ok, and not be run
function(assert_build_ok target_name src_list)
    set(test_name "test_${target_name}")
    add_executable(${target_name} ${src_list})

    add_test(${test_name} ${target_name})

    set_target_properties(${target_name} PROPERTIES
        EXCLUDE_FROM_ALL TRUE
        EXCLUDE_FROM_DEFAULT_BUILD TRUE
    )

    add_test(${test_name}
        ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${target_name}
    )
endfunction()

function(assert_build_fail target_name src_list)
    set(test_name "test_${target_name}")
    add_executable(${target_name} ${src_list})

    add_test(${test_name} ${target_name})
    set_tests_properties(${test_name} PROPERTIES WILL_FAIL TRUE)

    set_target_properties(${target_name} PROPERTIES
        EXCLUDE_FROM_ALL TRUE
        EXCLUDE_FROM_DEFAULT_BUILD TRUE
    )

    add_test(${test_name}
        ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${target_name}
    )
endfunction()
