set(
    HUNTER_CACHE_SERVERS
    "https://github.com/elucideye/hunter-cache"
    CACHE
    STRING
    "Hunter cache servers"
)

# https://docs.travis-ci.com/user/environment-variables/#Default-Environment-Variables
string(COMPARE EQUAL "$ENV{TRAVIS}" "true" is_travis)

# https://www.appveyor.com/docs/environment-variables/
string(COMPARE EQUAL "$ENV{APPVEYOR}" "True" is_appveyor)

string(COMPARE EQUAL "$ENV{GITHUB_USER_PASSWORD}" "" password_is_empty)

if(password_is_empty)
  set(default_upload OFF)
elseif(is_travis OR is_appveyor)
  set(default_upload ON)
else()
  set(default_upload OFF)
endif()

option(HUNTER_RUN_UPLOAD "Upload cache binaries" ${default_upload})
message("HUNTER_RUN_UPLOAD: ${HUNTER_RUN_UPLOAD}")

set(
    HUNTER_PASSWORDS_PATH
    "${CMAKE_CURRENT_LIST_DIR}/passwords.cmake"
    CACHE
    FILEPATH
    "Hunter passwords"
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")

HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.20.6.tar.gz"
    SHA1 "d9771027e1b14b1281fc9c06bc05df47bd90503b"
    FILEPATH "${CMAKE_CURRENT_LIST_DIR}/config.cmake"
)
