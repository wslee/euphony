cmake_minimum_required(VERSION 2.8.11)
project(libeusolver)

set(CMAKE_CXX_FLAGS_RELEASE
  "-pipe -Wall -pedantic -flto -fPIC -std=c++11 -O3"
  CACHE STRING "C++ compiler flags for release build" FORCE)

set(CMAKE_C_FLAGS_RELEASE
  "-pipe -Wall -pedantic -std=c11 -flto -fPIC -O3"
  CACHE STRING "C compiler flags for release build" FORCE)

set(CMAKE_CXX_FLAGS_PROFILE
  "-pipe -Wall -pedantic -flto -fPIC -std=c++11 -O3 -pg"
  CACHE STRING "C++ compiler flags for release build" FORCE)

set(CMAKE_C_FLAGS_PROFILE
  "-pipe -Wall -pedantic -std=c11 -flto -fPIC -O3 -pg"
  CACHE STRING "C compiler flags for release build" FORCE)

set(CMAKE_CXX_FLAGS_RELEASENOLTO
  "-pipe -Wall -pedantic -fPIC -std=c++11 -O3"
  CACHE STRING "C++ compiler flags for release build" FORCE)

set(CMAKE_C_FLAGS_RELEASENOLTO
  "-pipe -Wall -pedantic -std=c11 -fPIC -O3"
  CACHE STRING "C compiler flags for release build" FORCE)

set(CMAKE_CXX_FLAGS_DEBUG
  "-pipe -Wall -pedantic -ggdb3 -fno-inline -O0 -fPIC -std=c++11"
  CACHE STRING "C++ compiler flags for debug build" FORCE)

set(CMAKE_C_FLAGS_DEBUG
  "-pipe -Wall -pedantic -ggdb3 -fno-inline -O0 -fPIC -std=c11"
  CACHE STRING "C compiler flags for debug build" FORCE)

set(LIBEUSOLVER_CXX_SOURCE_FILES
  src/BitSet.cpp
  src/BitSetCAPI.cpp
  src/DecisionTree.cpp
  src/DecisionTreeCAPI.cpp
  src/LibEUSolver.cpp
  src/MultiLabelDecisionTreeLearner.cpp
  src/MultiLabelDecisionTreeLearnerCAPI.cpp
  )

set(LIBEUSOLVER_C_SOURCE_FILES
  )

add_library(eusolver
  SHARED
  ${LIBEUSOLVER_CXX_SOURCE_FILES}
  ${LIBEUSOLVER_C_SOURCE_FILES}
  )

add_custom_target(eusolver_python
  ALL
  COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/src/python/eusolver.py ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/src/python/eusolver.py
  )

# tests
add_executable(eusolver_bitset_tests
  tests/BitSetTests.cpp)
target_link_libraries(eusolver_bitset_tests
  eusolver)
set_target_properties(eusolver_bitset_tests
  PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests)

add_custom_target(eusolver_all_tests
  ALL
  DEPENDS eusolver_bitset_tests
  )

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release
    CACHE STRING "Build Type: One of Release, ReleaseNOLTO, Debug" FORCE)
endif()
