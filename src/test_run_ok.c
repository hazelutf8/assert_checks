/**
 * @file test_run_ok.c
 * @brief Example executable which compiles, with runtime success
 * @copyright Copyright (C) 2022 hazelutf8 SPDX-License-Identifier: MIT OR Apache-2.0
 * @author hazelutf8
 *
 * @since Version 0.1.0
 */

//
// Includes
//
// --- Self
// --- Language
// --- OS
// --- PKGs
// --- Local
#include "some_method.h"

//
// Constants
//

//
// Macros
//

//
// Types
//

//
// Variables
//

//
// Prototypes
//

//
// Functions
//
/**
 * @brief A main which compiles, and returns success
 * @details Use subcall to ensure dependencies are implicitly built for tests
 * @return The value 0 for runtime success
 *
 * @since Version 0.1.0
 */
int main(void) {
    // An array length greater than zero is always a build success.
    int a[2] = {1, -1};

    return add(a[0], a[1]);  // If compiled, always returns "success" code
}

//
// Templates
//

//
// Classes
//
