jdebug_set() {
    jenv shell-options "$JENV_OPTIONS -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=8000,suspend=n"
}

jdebug_unset() {
    jenv shell-options --unset
}

gc_set() {
    jenv shell-options "$JENV_OPTIONS -XX:+PrintGCDetails -Xloggc:gc.log"
}

gc_unset() {
    jenv shell-options --unset
}

jrebel_set() {
    jenv shell-options "$JENV_OPTIONS -javaagent:$HOME_BIN/jrebel/jrebel.jar -noverify"
}

jrebel_unset() {
    jenv shell-options --unset
}

jprofiler_set() {
    jenv shell-options "$JENV_OPTIONS -javaagent:$HOME_BIN/jprofiler/bin/agent.jar"
}

jprofiler_unset() {
    jenv shell-options --unset
}

jboss_debug_set() {
    jenv shell-options "$JENV_OPTIONS -Xrunjdwp:server=y,transport=dt_socket,address=8787,suspend=n"
}

jboss_debug_unset() {
    jenv shell-options --unset
}

hotswap_set() {
    jenv shell-options "$JENV_OPTIONS -XXaltjvm=dcevm -javaagent:$HOME_BIN/hotswap/hotswap-agent.jar=autoHotswap=true"
}

hotswap_unset() {
    jenv shell-options --unset
}

