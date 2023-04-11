cmake_minimum_required(VERSION 3.2)

# Set project name
project(helloworld)

set(CMAKE_CXX_STANDARD 11)

# Set the search path for .cmake files.
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" ${CMAKE_MODULE_PATH})

add_executable(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/src/helloworld.cpp ${CMAKE_CURRENT_SOURCE_DIR}/src/PrimeChecker.cpp)

enable_testing()
add_executable(${PROJECT_NAME}-Runner ${CMAKE_CURRENT_SOURCE_DIR}/src/TestPrimeChecker.cpp ${CMAKE_CURRENT_SOURCE_DIR}/src/PrimeChecker.cpp)
add_test(NAME ${PROJECT_NAME}-Runner COMMAND ${PROJECT_NAME}-Runner)