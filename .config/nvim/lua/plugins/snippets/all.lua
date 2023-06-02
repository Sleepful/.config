return {
  s("a.", t("-> ")),
  s("a,", t("<- ")),
  s("a=", t("=> ")),
  s("pp", t("|> ")),
  s("map", { t("%{"), i(1), t("} ") }),
  s("smap", { t("%"), i(1), t("{"), i(2), t("} ") }),
  s("todo", t("TODO: ")),
  s("note", t("NOTE: ")),
  s("coauthor", { t("Co-authored-by: "), i(1, "NAME"), t(" <"), i(2, "EMAIL"), t(">") }),
}
