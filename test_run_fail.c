#define STATIC_ASSERT(COND,MSG) typedef char static_assertion_##MSG[(COND)?1:-1]
STATIC_ASSERT(1 == 1, ALWAYS_TRUE);

int main(void) {
    return -1;  // If compiled, always returns "failure" error code
}
