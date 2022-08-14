/**
 * @file test_build_fail.c
 * @brief Example executable which fails to compile
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
 * @brief A main which never compiles, but would return success
 *
 * @return The value 0 for runtime success
 *
 * @since Version 0.1.0
 */
int main(void) {
    int a[-1];  // Negative array size is always a build error
    (void)a;

    // If compiled, always returns "success" error code which,
    // ensures the test is checking the build success and not the return code
    return 0;
}

//
// Templates
//

//
// Classes
//
