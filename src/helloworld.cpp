#include <iostream>
#include "PrimeChecker.hpp"

// main program
int main(int argc, char** argv) {
    if (argc == 2) {
        int number = std::stoi(argv[1]);
        PrimeChecker pc;
        std::cout << "Tumenjargal, Altansukh; " << number << " is a prime number? " << pc.isPrime(number) << std::endl;
    }
    return 0;
}