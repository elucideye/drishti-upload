cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")

include("cmake/HunterGate.cmake")
### Hunter snapshot that will be used ###

# drishti specific hunter cache pacakges:
list(APPEND HUNTER_CACHE_SERVERS "https://github.com/elucideye/hunter-cache")

HunterGate(
  URL "https://github.com/ruslo/hunter/archive/v0.16.27.tar.gz"
  SHA1 "19973adf6829011eb8102a554ef78f248423a0a7"
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
  hunter_add_package(Boost COMPONENTS filesystem system serialization iostreams)
  hunter_add_package(Eigen)
  hunter_add_package(PNG)
  hunter_add_package(TIFF)
  hunter_add_package(dlib)
  hunter_add_package(spdlog)
  hunter_add_package(cereal)
  hunter_add_package(flatbuffers)
elseif(LEVEL EQUAL 2)
  hunter_add_package(OpenCV)
elseif(LEVEL EQUAL 3)
  hunter_add_package(cvmatio) # depends on OpenCV
  hunter_add_package(half)
  hunter_add_package(GTest)
  hunter_add_package(thread-pool-cpp)
  hunter_add_package(xgboost)
  hunter_add_package(ogles_gpgpu)
else()
  message(FATAL_ERROR "Unexpected value of LEVEL: '${LEVEL}'")
endif()
