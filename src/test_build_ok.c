/**
 * @file test_build_ok.c
 * @brief Example executable which compiles, but if run returns failure
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
 * @brief A main which compiles, but would return failure
 *
 * @return The value -1 for runtime failure
 *
 * @since Version 0.1.0
 */
int main(void) {
    int a[1];  // An array of one element is always a build success.
    (void)a;

    // If compiled, always returns "failure" error code,
    // which ensures the test is checking the build success and not the return code
    return -1;
}

//
// Templates
//

//
// Classes
//
