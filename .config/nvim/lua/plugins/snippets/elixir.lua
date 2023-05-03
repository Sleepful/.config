return {
  s(":::", t("->")),
  s("pp", t("|>")),
  s("fn", {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    t("fn "),
    i(1, "x"),
    t(" -> "),
    i(2, "x"),
    t(" end"),
  }),
}
