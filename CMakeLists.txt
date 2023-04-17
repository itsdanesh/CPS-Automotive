# Minimum CMake version required
cmake_minimum_required(VERSION 3.2)

# Set project name
project(helloworld)

set(CMAKE_CXX_STANDARD 11)

# Set the search path for .cmake files.
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" ${CMAKE_MODULE_PATH})

# Add executable and its dependencies
add_executable(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/src/helloworld.cpp ${CMAKE_CURRENT_SOURCE_DIR}/src/PrimeChecker.cpp)

# Enable code coverage
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --coverage")
endif()

# Enable testing
enable_testing()

# Add test runner executable and its dependencies
add_executable(${PROJECT_NAME}-Runner ${CMAKE_CURRENT_SOURCE_DIR}/src/TestPrimeChecker.cpp ${CMAKE_CURRENT_SOURCE_DIR}/src/PrimeChecker.cpp)

# Link --coverage option to the test runner executable for code coverage
target_link_libraries(${PROJECT_NAME}-Runner --coverage)

# Add test suite
add_test(NAME ${PROJECT_NAME}-Runner COMMAND ${PROJECT_NAME}-Runner)

# Add a custom target for generating the coverage report
add_custom_target(coverage
    COMMAND mkdir -p coverage_report
    COMMAND ${CMAKE_COMMAND} -E chdir coverage_report gcovr -r .. --xml --exclude '.*\/catch.hpp' --print-summary -o coverage.xml
    COMMAND ${CMAKE_COMMAND} -E chdir coverage_report gcovr -r .. --html-details --exclude '.*\/catch.hpp' -o gcov_details.html
    DEPENDS ${PROJECT_NAME}-Runner
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
