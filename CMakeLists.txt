cmake_minimum_required(VERSION 3.3)

project(ctest_example
    VERSION 0.1.0
    LANGUAGES C
)
set(CMAKE_C_STANDARD 99)

# Include cmake assert checks
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(assert_checks)
#include(GNUInstallDirs)  # If objects exported

# Create normal object depended on by a test
set(lib some_method)
add_library(${lib} src/${lib}.c)
target_include_directories(${lib}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src/>
        # When exports:
        #$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}_pkg>
)

# Create cmake build and ctest examples
set(target test_run_ok)
add_executable(${target} src/${target}.c)
target_link_libraries(${target}
    PRIVATE
        $<BUILD_INTERFACE:${lib}>
)
add_target_ctest(TARGET ${target})

set(target test_run_fail)
add_executable(${target} src/${target}.c)
add_target_ctest(TARGET ${target} RUN_OK FALSE)

set(target test_build_ok)
add_executable(${target} src/${target}.c)
add_target_ctest(TARGET ${target} RUN_OK IGNORE)

set(target test_build_fail)
add_executable(${target} src/${target}.c)
add_target_ctest(TARGET ${target} BUILD_OK FALSE RUN_OK IGNORE)
