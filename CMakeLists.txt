cmake_minimum_required(VERSION 3.10)

project(Deutsch VERSION 0.1)

file(GLOB redefs_SRC
    "deutsch/*.h"
)

add_library(redefs INTERFACE)
add_executable(demo "demo.c")

target_include_directories(redefs INTERFACE ${redefs_SRC})
target_link_libraries(demo redefs)