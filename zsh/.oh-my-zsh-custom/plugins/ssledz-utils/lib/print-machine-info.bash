ssu_print_machine_info() {
  whoami
  uname -n
  ifconfig | grep "inet addr" | cut -d: -f2 | cut -d" " -f1
  cat /proc/cpuinfo | grep -E "model name|stepping|cpu MHz|cpu cores|cache size|physical id|core id"
  grep MemTotal /proc/meminfo
  df -hl
}

