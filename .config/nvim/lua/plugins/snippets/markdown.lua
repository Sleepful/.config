return {
  s({ trig = "one" }, {
    t("- [ ] "),
    i(1, "task"),
  }),
  s({ trig = "log" }, {
    t("`"),
    i(1, "end"),
    t("`: `"),
    i(2, "total"),
    t("`"),
  }),
}
