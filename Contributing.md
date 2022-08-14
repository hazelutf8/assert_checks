# Assert Checks

## Run Tests

```sh
mkdir <repo>/build
cd <repo>/build

rm -Rf ../build/* ; cmake install .. ; ctest -j 8
```

## Run Lints

Example usage of lints

### codespell
```sh
cd <repo>

python -m pip install -y codespell

codespell . --skip ./build*
```

### cpplint
```sh
python -m pip install -y cpplint
cd <repo>

cpplint --recursive *.c *.h
```

### CMakeLint
```sh
python -m pip install -y cmakelint
cd <repo>

cmakelint ./* ./cmake/*
```

### Clang Format

Download [release](https://github.com/llvm/llvm-project/releases) (llvm-x-win64.exe), then update code formatting in place.

```sh
cd <repo>

clang-format -i ./src/*.c ./src/*.h
```
