macro(drishti_set_hunter_version DRISHTI_HUNTER_GATE_URL DRISHTI_HUNTER_GATE_SHA1)
  #set(${DRISHTI_HUNTER_GATE_URL} "https://github.com/ruslo/hunter/archive/v0.16.29.tar.gz")
  #set(${DRISHTI_HUNTER_GATE_SHA1} "309d7d8eedc5b1229b710f856dc7a19e04fb7737")

  # Temporary release for cereal update: Archive::is_{loading,saving}
  set(${DRISHTI_HUNTER_GATE_URL} "https://github.com/headupinclouds/hunter/archive/v0.16.33-rc1.tar.gz")
  set(${DRISHTI_HUNTER_GATE_SHA1} "7dbd9e15317052266dbbb7181f1ba7f08dcda763")
endmacro()
