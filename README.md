# CMake Tests

## Usage
Given a user specified target, if it runs/builds, pass/fails.

```
set(target test_run_ok)
add_executable(${target} main.c)
assert_run_success(${target})
```

## Configure and Build
```
mkdir <repo>/build
cd build

cmake install ..
cmake --build .
```

## Test
```
cd <repo>/build

ctest
```
