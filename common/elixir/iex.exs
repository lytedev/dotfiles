Application.put_env(:elixir, :ansi_enabled, true)

# PROTIP: to break, `#iex:break`

IEx.configure(
  colors: [enabled: true],
  inspect: [
    pretty: true,
    limit: :infinity
  ],
  default_prompt:
    [
      # ANSI CHA, move cursor to column 1
      "\e[G",
      :magenta,
      # IEx prompt variable
      "%prefix",
      "#",
      # IEx prompt variable
      "%counter",
      # plain string
      ">",
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)
