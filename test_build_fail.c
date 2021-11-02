#define STATIC_ASSERT(COND,MSG) typedef char static_assertion_##MSG[(COND)?1:-1]
STATIC_ASSERT(1 == 0, ALWAYS_TRUE);

int main(void) {
    return 0;  // If compiled, always returns "success" error code
                // which ensure the test is checking the build success and not this return code
}
