message(">:>:>:>:>:>:>:>:>:>:>:>:>:>:>:>:>: ${CMAKE_MODULE_PATH} <:<:<:<:<:<:<:<:<:<:<:<:<:<:<:<:<:<:<:<:<:<:<:")

message("-- config.cmake --")
message("  MSVC: ${MSVC}")
message("  APPLE: ${APPLE}")
message("  ANDROID: ${ANDROID}")
message("  IOS: ${IOS}")
message("  is_linux: ${is_linux}")
message("  XCODE: ${XCODE}")

### OpenCV
if(ANDROID)
  message("ANDROID ========================================================================")
  include(drishti_set_opencv_cmake_args_android)
  drishti_set_opencv_cmake_args_android()
elseif(IOS)
  message("IOS ============================================================================")
  include(drishti_set_opencv_cmake_args_ios)
  drishti_set_opencv_cmake_args_ios()
elseif(APPLE)
  message("APPLE ==========================================================================")
  include(drishti_set_opencv_cmake_args_osx)
  drishti_set_opencv_cmake_args_osx()
elseif(${is_linux})
  message("is_linux =======================================================================")
  include(drishti_set_opencv_cmake_args_nix)
  drishti_set_opencv_cmake_args_nix()
elseif(MSVC)
  message("MSVC ===========================================================================")
  include(drishti_set_opencv_cmake_args_windows)
  drishti_set_opencv_cmake_args_windows()
endif()

list(APPEND OPENCV_CMAKE_ARGS
  BUILD_opencv_world=ON
  BUILD_opencv_ts=OFF
  BUILD_opencv_python2=OFF
  BUILD_opencv_shape=OFF
  BUILD_opencv_superres=OFF
  HAVE_OPENCL=OFF
  WITH_OPENCL=OFF
  BUILD_EIGEN=OFF  ### for convenient linking
  )

if(XCODE)
  list(APPEND OPENCV_CMAKE_ARGS CMAKE_XCODE_ATTRIBUTE_WARNING_CFLAGS=-Wno-narrowing)
elseif(NOT MSVC)
  list(APPEND OPENCV_CMAKE_ARGS CMAKE_CXX_FLAGS=-Wno-narrowing)
endif()

# Note: boost_portable_binary_[io]archive incompatibility encountered
# with upgrade from 1.58.0 to 1.62.0, so boost should stay at 1.58.0
# until that is resolved.  Most likely those models will be abandoned
# in favor of cereal.
set(drishti_boost_version 1.58.0-p1) # 1.62.0

hunter_config(OpenCV VERSION 3.0.0-p9 CMAKE_ARGS "${OPENCV_CMAKE_ARGS}")
hunter_config(Boost VERSION ${drishti_boost_version} CMAKE_ARGS IOSTREAMS_NO_BZIP2=1)
hunter_config(ogles_gpgpu VERSION 0.1.6-p1 CMAKE_ARGS OGLES_GPGPU_VERBOSE=OFF)
hunter_config(xgboost VERSION 0.40-p4 CMAKE_ARGS XGBOOST_DO_LEAN=ON XGBOOST_USE_HALF=ON XGBOOST_USE_BOOST=ON)
hunter_config(PNG VERSION 1.6.26-p1)
hunter_config(TIFF VERSION 4.0.2-p3)
hunter_config(cereal VERSION 1.2.1-p1)
hunter_config(cvmatio VERSION 1.0.27-p3)
hunter_config(dlib VERSION 19.2-p1)
hunter_config(flatbuffers VERSION 1.3.0-p3)
hunter_config(nlohmann-json VERSION 1.0.0-rc1-hunter-3)
hunter_config(GTest VERSION 1.8.0-hunter-p5)
hunter_config(half VERSION 1.1.0-p1)
hunter_config(Eigen VERSION 3.3.1-p3)
hunter_config(spdlog VERSION 1.0.0-p0)
hunter_config(Qt VERSION 5.5.1-cvpixelbuffer-2-p9)
