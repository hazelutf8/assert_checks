# Assert Checks

## Summary
This repository gives an example of creating build and compile tests to support arbitrary compile, test, mock, or coverage tools.


### Goals
* Provide helper methods for enabling `ctest` results
* Supports threading of tests by making run tasks dependent on build tasks


### Non-Goals
Interaction with specific testing tools or compiler environments.

### Features
Given some CMake target, the method asserts if the build and/or execution will complete with a pass/fail code.

For ease of use, targets provided for `ctest` by default are only built during `ctest` runs.

Because `ctest` targets specify their dependencies like normal targets, `cmake --build` can be skipped, and any required dependencies will be built on demand, even across multiple worker threads (`ctest -j 8`).
This has the side effect of sometimes reducing compilation for `ctest` only builds (unittests or coverage reports).


## Use
Given a specified target, ensure it runs/builds, pass/fails, and enable/disable target in normal builds.

### Getting Started

### Tools
Assumes an environment with:
* CMake 3.3+


#### Dependencies
None

### Create Tests
Import or copy the helper cmake methods into the wanted project.
This project top level `CMakeList.txt` provides an example of its import and use.

All arguments for `add_target_ctest(...)` are optional except the target to test.

Defaults for optional arguments:
* `TEST_ONLY` as `TRUE`, prevents provided target compilation unless `ctest` build
* `BUILD_OK` as `TRUE`, asserts target must build ok
* `RUN_OK` as `TRUE`, asserts target must run ok


```CMake
add_executable(test_build_and_run_ok
    main.c
)
add_target_ctest(test_build_and_run_ok)
```

### Configure and Build
```sh
mkdir <repo>/build
cd build

cmake install ..

cmake --build .   # Note, can be skipped, because ctest targets will trigger their required dependants
```

### Test
Run tests

```sh
cd <repo>/build

ctest
```

Results when `ctest` allowed 8 threads
```sh
$ ctest -j 8
Test project assert_checks/build
    Start 1: test_build_test_run_ok
    Start 3: test_build_test_run_fail
    Start 5: test_build_test_build_ok
    Start 6: test_build_test_build_fail
1/6 Test #3: test_build_test_run_fail .........   Passed    0.73 sec
    Start 4: test_run_test_run_fail
2/6 Test #4: test_run_test_run_fail ...........   Passed    0.01 sec
3/6 Test #5: test_build_test_build_ok .........   Passed    0.74 sec
4/6 Test #6: test_build_test_build_fail .......   Passed    0.80 sec
5/6 Test #1: test_build_test_run_ok ...........   Passed    1.31 sec
    Start 2: test_run_test_run_ok
6/6 Test #2: test_run_test_run_ok .............   Passed    0.03 sec

100% tests passed, 0 tests failed out of 6

Total Test time (real) =   1.35 sec
```

### Known Limitations
It is recommended to use the latest CMake, but for reference below is a summary of compatible CMake and MSVC versions.

Supported [CMake with MSVC](https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html#visual-studio-generators) combinations:
* Visual Studio 14 (2015) supported with CMake 3.1+
* Visual Studio 15 (2017) supported with CMake 3.11+
* Visual Studio 16 (2019) supported with CMake 3.14+
* Visual Studio 16 (2022) supported with CMake 3.21+

Although lower CMake versions may work, the below value is set as the minimum required.
Old CMake versions on Windows were installed with [Chocolatey](https://community.chocolatey.org/packages/cmake), using MinGW/GCC.

```batch
choco install -y cmake --version 3.3
```


## Additional Examples

### MSVC on Windows
Configure with default compiler (MSVC), skip building normal targets (`cmake --build .`), then build tests.
```batch
mkdir <repo>\build
cd <repo>\build

del /s /q ..\build\* && cmake install .. && ctest
```

### MinGW on Windows
Download [MinGW](https://sourceforge.net/projects/mingw/) for GCC on Windows.

Configure with MinGW environment compiler (GCC), build all normal targets, then build tests.
```batch
set PATH=C:\MinGW\mingw32\bin;C:\MinGW\bin;"C:\Program Files\CMake\bin"

mkdir <repo>\build
cd <repo>\build
del /s /q ..\build\* && cmake install .. -G "MinGW Makefiles" && ctest
```


## Contributions
Contributions are welcome.
Note that by submitting contributions, you agree to license your work under the same license used by this project.

### Code Expectations
Not nessisary before PR, but before merging, code should meet these criteria:
* Clear goal for the change
* Clear feature interface and documentation
* Passing lint checks
* New features or fixes should have a corresponding test set update
* Tests cover the behavior of the interface, not the implementation details

See `Contributing.md` for examples.

## License
Licensed under either of

 * Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
 * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.
