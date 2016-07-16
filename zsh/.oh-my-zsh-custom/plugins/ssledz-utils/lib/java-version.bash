ssu_java_version() {
  version=`java -version 2>&1`;
  version=${version##java version \"}
  version=${version%%\"*}
  echo $version
}
