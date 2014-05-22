gitk() {
  command gitk "$@" 2>/dev/null&
  disown
}
