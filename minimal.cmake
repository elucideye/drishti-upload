message("Using config 'minimal'")

hunter_config(
    xgboost
    VERSION 0.40-p10
    CMAKE_ARGS
    XGBOOST_USE_HALF=ON
    XGBOOST_USE_CEREAL=ON
    XGBOOST_DO_LEAN=ON
)
