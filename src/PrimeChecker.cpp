#include "PrimeChecker.hpp"

bool PrimeChecker::isPrime(uint16_t n) {
    bool retVal{true};
    // Check if number is less than 2
    if (n<2 || 0 == n%2) {
        retVal = false;
    }
    // Check if number is prime
    else {
        for(uint16_t i{3}; (i*i) <= n; i += 2) {
            if (0 == n%i) {
                return false;
                break;
            }
        }
    }
    return retVal;
}