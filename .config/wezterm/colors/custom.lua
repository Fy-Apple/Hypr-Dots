-- A slightly altered version of catppucchin mocha
local mocha = {
   rosewater = '#ffebe8',
   flamingo = '#ffdfdf',
   pink = '#ffcee7',
   mauve = '#d8b6ff',
   red = '#ff99aa',
   maroon = '#ffb3b6',
   peach = '#ffc387',
   yellow = '#fff3af',
   green = '#bbf3b1',
   teal = '#a2f2e5',
   sky = '#9aefff',
   sapphire = '#85e7fc',
   blue = '#a0c7ff',
   lavender = '#c2cfff',
   text = '#dfe6ff',
   subtext1 = '#cbd3ed',
   subtext0 = '#bfccdd',
   overlay2 = '#a7afce',
   overlay1 = '#96a3b4',
   overlay0 = '#8296a1',
   surface2 = '#7174a1',
   surface1 = '#5a5d7e',
   surface0 = '#494b56',
   base = '#262635',
   mantle = '#1e1e2b',
   crust = '#191919',
}

local colorscheme = {
   foreground = mocha.text,
   background = mocha.base,
   cursor_bg = mocha.rosewater,
   cursor_border = mocha.rosewater,
   cursor_fg = mocha.crust,
   selection_bg = mocha.surface2,
   selection_fg = mocha.text,
   ansi = {
      '#131313', -- black
      '#ff181f', -- red
      '#23b50e', -- green
      '#d1a800', -- yellow
      '#0045ea', -- blue
      '#9917a8', -- magenta/purple
      '#4aa6ff', -- cyan
      '#dddddd', -- white
   },
   brights = {
      '#888888', -- black
      '#ff5866', -- red
      '#27d70c', -- green
      '#ffffc5', -- yellow
      '#4a88ff', -- blue
      '#c51ab2', -- magenta/purple
      '#72e6e6', -- cyan
      '#ffffff', -- white
   },
   tab_bar = {
      background = 'rgba(0, 0, 0, 0.4)',
      active_tab = {
         bg_color = mocha.surface2,
         fg_color = mocha.text,
      },
      inactive_tab = {
         bg_color = mocha.surface0,
         fg_color = mocha.subtext1,
      },
      inactive_tab_hover = {
         bg_color = mocha.surface0,
         fg_color = mocha.text,
      },
      new_tab = {
         bg_color = mocha.base,
         fg_color = mocha.text,
      },
      new_tab_hover = {
         bg_color = mocha.mantle,
         fg_color = mocha.text,
         italic = true,
      },
   },
   visual_bell = mocha.surface0,
   indexed = {
      [16] = mocha.peach,
      [17] = mocha.rosewater,
   },
   scrollbar_thumb = mocha.surface2,
   split = mocha.overlay0,
   compose_cursor = mocha.flamingo, -- nightbuild only
}

return colorscheme
