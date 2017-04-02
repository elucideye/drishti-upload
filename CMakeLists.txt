cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")

include("cmake/HunterGate.cmake")
### Hunter snapshot that will be used ###
# drishti specific hunter cache pacakges:
list(APPEND HUNTER_CACHE_SERVERS "https://github.com/elucideye/hunter-cache")

include(drishti_set_hunter_gate)
drishti_set_hunter_version(DRISHTI_HUNTER_GATE_URL DRISHTI_HUNTER_GATE_SHA1)

HunterGate(
  URL "${DRISHTI_HUNTER_GATE_URL}"
  SHA1 "${DRISHTI_HUNTER_GATE_SHA1}"
  FILEPATH "${CMAKE_CURRENT_LIST_DIR}/config.cmake"
  )

### Main project ###
project(drishti-upload)

#####################################################################
## IMPORTANT: Set platform variables after project() and before
## the first hunter_add_package() call. The cmake/Hunter/config.cmake
## file will be parsed at the time of the first hunter_add_package()
## call, so we need to populate system variable before that.
## Do note move this!!!!!!!!
#####################################################################
string(COMPARE EQUAL "${CMAKE_SYSTEM_NAME}" "Linux" is_linux)

set(LEVEL "$ENV{LEVEL}")
string(COMPARE EQUAL "${LEVEL}" "" is_empty)
if(is_empty)
  message(FATAL_ERROR "Environment variable LEVEL is empty")
endif()

if(LEVEL EQUAL 1)
  # TODO: Update imshow package to avoid GL_BGR(A) enum for MSVC builds
  if(NOT (ANDROID OR IOS OR MSVC))
    hunter_add_package(glfw) 
    hunter_add_package(imshow) # depends on glfw
  endif()
  hunter_add_package(boost-pba)  
  hunter_add_package(Boost COMPONENTS filesystem system serialization iostreams)
  hunter_add_package(Eigen)
  hunter_add_package(PNG)
  hunter_add_package(dlib)
  hunter_add_package(spdlog)
  hunter_add_package(cereal)
  hunter_add_package(flatbuffers)
  if(APPLE OR ${is_linux} OR MSVC)
    hunter_add_package(Jpeg)
  endif()
elseif(LEVEL EQUAL 2)
  hunter_add_package(OpenCV)
elseif(LEVEL EQUAL 3)
  hunter_add_package(sse2neon)
  hunter_add_package(ARM_NEON_2_x86_SSE)
  hunter_add_package(cvmatio) # depends on OpenCV
  hunter_add_package(half)
  hunter_add_package(GTest)
  hunter_add_package(thread-pool-cpp)
  hunter_add_package(xgboost)
  hunter_add_package(cxxopts)
  hunter_add_package(ogles_gpgpu)
  hunter_add_package(nlohmann-json) # test
  if(ANDROID)
    hunter_add_package(Android-SDK)
  endif()
else()
  message(FATAL_ERROR "Unexpected value of LEVEL: '${LEVEL}'")
endif()
