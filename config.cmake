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

option(DRISHTI_BUILD_MIN_SIZE "Build minimum size lib (exclude training)" ON)
option(DRISHTI_BUILD_OPENCV_WORLD "Build OpenCV world (monolithic lib)" ON)

list(APPEND OPENCV_CMAKE_ARGS
  BUILD_opencv_world=${DRISHTI_BUILD_OPENCV_WORLD}
  BUILD_opencv_ts=OFF
  BUILD_opencv_python2=OFF
  BUILD_opencv_shape=OFF
  BUILD_opencv_superres=OFF
  HAVE_OPENCL=OFF
  WITH_OPENCL=OFF
  BUILD_EIGEN=OFF  ### for convenient linking
  BUILD_SHARED_LIBS=OFF
  )

set(drishti_boost_version 1.64.0)

# Maintain hunter default args (no testing, license name) and eliminate
# eigen fortrn dependencies
set(EIGEN_CMAKE_ARGS
  BUILD_TESTING=OFF
  HUNTER_INSTALL_LICENSE_FILES=COPYING.MPL2
  CMAKE_Fortran_COMPILER=OFF
  )

# Set xgboost args
set(XGBOOST_CMAKE_ARGS
  XGBOOST_USE_HALF=ON
  XGBOOST_USE_CEREAL=ON
  )
if(DRISHTI_BUILD_MIN_SIZE)
  list(APPEND XGBOOST_CMAKE_ARGS XGBOOST_DO_LEAN=ON)
else()
  list(APPEND XGBOOST_CMAKE_ARGS XGBOOST_DO_LEAN=OFF)
endif()

if(APPLE OR ${is_linux} OR MSVC)
  hunter_config(Jpeg VERSION 9b-p1)
endif()

hunter_config(ARM_NEON_2_x86_SSE VERSION 1.0.0-p0)
hunter_config(Boost VERSION ${drishti_boost_version})
hunter_config(Eigen VERSION 3.3.1-p4 CMAKE_ARGS ${EIGEN_CMAKE_ARGS})
hunter_config(GTest VERSION 1.8.0-hunter-p5)
hunter_config(OpenCV VERSION 3.0.0-p11 CMAKE_ARGS "${OPENCV_CMAKE_ARGS}")
hunter_config(PNG VERSION 1.6.26-p1)
hunter_config(Qt VERSION 5.5.1-cvpixelbuffer-2-p9)
hunter_config(RapidXML VERSION 1.13)
hunter_config(cereal VERSION 1.2.1-p1)
hunter_config(cvmatio VERSION 1.0.27-p3)
hunter_config(dlib VERSION 19.2-p1)
hunter_config(glfw VERSION 3.3.0-p1)
hunter_config(half VERSION 1.1.0-p1)
hunter_config(nlohmann_json VERSION 2.1.1-p0)
hunter_config(spdlog VERSION 0.13.0-p0)
hunter_config(sse2neon VERSION 1.0.0-p0)

# experimental: lock verison but not used for CI builds
hunter_config(dest VERSION 0.8.0-p4)
hunter_config(eos VERSION 0.12.1)
hunter_config(glm VERSION 0.9.8.5)
hunter_config(flatbuffers VERSION 1.3.0-p3)
hunter_config(tinydir VERSION 1.2-p0)
hunter_config(Beast VERSION 1.0.0-b32-hunter-4)

if(NOT DRISHTI_UPLOAD_IGNORE_SUBMODULES)

  if(DRISHTI_OPENGL_ES3)
    set(use_opengl_es3 ON)
  else()
    set(use_opengl_es3 OFF)
  endif()

  set(OGLES_GPGPU_CMAKE_ARGS
    OGLES_GPGPU_VERBOSE=OFF
    OGLES_GPGPU_OPENGL_ES3=${use_opengl_es3})

  set(AGLET_CMAKE_ARGS
    AGLET_OPENGL_ES3=${use_opengl_es3})

  # Use submodules for first packaged version:
  hunter_config(drishti_assets GIT_SUBMODULE "src/3rdparty/drishti-assets")
  hunter_config(drishti_faces GIT_SUBMODULE "src/3rdparty/drishti-faces")
  hunter_config(aglet GIT_SUBMODULE "src/3rdparty/aglet" CMAKE_ARGS ${AGLET_CMAKE_ARGS})

  hunter_config(ogles_gpgpu GIT_SUBMODULE "src/3rdparty/ogles_gpgpu" CMAKE_ARGS ${OGLES_GPGPU_CMAKE_ARGS})
  hunter_config(xgboost GIT_SUBMODULE "src/3rdparty/xgboost" CMAKE_ARGS ${XGBOOST_CMAKE_ARGS})
  hunter_config(thread-pool-cpp GIT_SUBMODULE "src/3rdparty/thread-pool-cpp")

  # Note: MSVC currently broken due to internal GL_BGR(A) enums
  # TODO: Update imshow package
  if(NOT (ANDROID OR IOS OR MSVC))
    hunter_config(imshow GIT_SUBMODULE "src/3rdparty/imshow")
  endif()
endif()
