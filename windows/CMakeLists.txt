cmake_minimum_required(VERSION 3.14)

# Suppress the deprecation warning
if(POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif()

# Include the generated CMakeLists.txt file
include(${CMAKE_CURRENT_SOURCE_DIR}/flutter/ephemeral/generated_config.cmake)
s