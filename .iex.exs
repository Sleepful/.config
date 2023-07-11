defmodule R do
  def reload! do
    Mix.Task.reenable("compile.elixir")
    Application.stop(Mix.Project.config()[:app])
    Mix.Task.run("compile.elixir")
    Application.start(Mix.Project.config()[:app], :permanent)
  end
end

import R

defmodule CustomIEXHelpers do
  def iex(n), do: IEx.Helpers.v(n)
end

import CustomIEXHelpers

defmodule AC do
  IEx.configure(
    colors: [
      syntax_colors: [
        number: :light_yellow,
        atom: :light_cyan,
        string: :light_black,
        boolean: [:light_blue],
        nil: [:magenta, :bright]
      ],
      ls_directory: :cyan,
      ls_device: :yellow,
      doc_code: :green,
      doc_inline_code: :magenta,
      doc_headings: [:cyan, :underline],
      doc_title: [:cyan, :bright, :underline]
    ],
    default_prompt:
      [
        # ANSI CHA, move cursor to column 1
        "\e[G",
        :light_magenta,
        # plain string
        # "%counter 🧪",
        "%prefix(%counter)",
        " 🧪 ",
        :white,
        :reset
      ]
      |> IO.ANSI.format()
      |> IO.chardata_to_string()
  )
end
