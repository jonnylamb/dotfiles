-- awesome 3 configuration file

-- Include awesome library, with lots of useful function!
require("awful")
require("tabulous")
require("beautiful")

-- {{{ Variable definitions
-- This is a file path to a theme file which will defines colors.
theme_path = "/home/" .. os.getenv("USER") .. "/.config/awesome/theme"

-- This is used later as the default terminal to run.
terminal = "x-terminal-emulator"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Control"

-- Whether we are in Dvorak or not
dvorak = false

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    "tile",
    "tileleft",
    "tilebottom",
    "tiletop",
    "magnifier",
    "max",
    "spiral",
    "dwindle",
    "floating"
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    x-terminal-emulator -name mocp -e mocp
floatapps =
{
    -- by class
    --["MPlayer"] = true,
    --["pinentry"] = true,
    --["gimp"] = true,
    -- by instance
    --["mocp"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
    -- ["Firefox"] = { screen = 1, tag = 2 },
    -- ["mocp"] = { screen = 2, tag = 4 },
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{ Initialization
-- Initialize theme (colors).
beautiful.init(theme_path)

-- Register theme in awful.
-- This allows to not pass plenty of arguments to each function
-- to inform it about colors we want it to draw.
awful.beautiful.register(beautiful)

-- Uncomment this to activate autotabbing
-- tabulous.autotab_start()
-- }}}

-- {{{ Tags
-- Define tags table.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = {}
    -- Create 9 tags per screen.
    for tagnumber = 1, 16 do
        tags[s][tagnumber] = tag({ name = tagnumber, layout = layouts[1] })
        -- Add tags to screen one by one
        tags[s][tagnumber].screen = s
    end
    -- I'm sure you want to see at least one tag.
    tags[s][1].selected = true
end
-- }}}

-- {{{ Statusbar
-- Create a taglist widget
mytaglist = widget({ type = "taglist", name = "mytaglist" })
mytaglist:mouse_add(mouse({}, 1, function (object, tag) awful.tag.viewonly(tag) end))
mytaglist:mouse_add(mouse({ modkey }, 1, function (object, tag) awful.client.movetotag(tag) end))
mytaglist:mouse_add(mouse({}, 3, function (object, tag) tag.selected = not tag.selected end))
mytaglist:mouse_add(mouse({ modkey }, 3, function (object, tag) awful.client.toggletag(tag) end))
mytaglist:mouse_add(mouse({ }, 4, awful.tag.viewprev))
mytaglist:mouse_add(mouse({ }, 5, awful.tag.viewnext))
mytaglist.label = awful.widget.taglist.label.all

-- Create a tasklist widget
mytasklist = widget({ type = "tasklist", name = "mytasklist" })
mytasklist:mouse_add(mouse({ }, 1, function (object, c) client.focus = c; c:raise() end))
mytasklist:mouse_add(mouse({ }, 4, function () awful.client.focusbyidx(1) end))
mytasklist:mouse_add(mouse({ }, 5, function () awful.client.focusbyidx(-1) end))
mytasklist.label = awful.widget.tasklist.label.currenttags

-- Create a systray
mysystray = widget({ type = "systray", name = "mysystray", align = "right" })

-- Create a textbox widget
mytextbox = widget({ type = "textbox", name = "mytextbox", align = "right" })
function hook_timer ()
    mytextbox.text = " " .. os.date("%a, %b %d, %I:%M %p") .. " "
end
hook_timer()

--Create a promptbox
mypromptbox = widget({ type = "textbox", name = "mypromptbox", align = "left" })

-- Create an iconbox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
mylayoutbox = {}
for s = 1, screen.count() do
    mylayoutbox[s] = widget({ type = "textbox", name = "mylayoutbox", align = "left" })
    mylayoutbox[s]:mouse_add(mouse({ }, 1, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 3, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 4, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 5, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s].text = "<bg image=\"/usr/share/awesome/icons/layouts/tilew.png\" resize=\"true\"/>"
end

-- Create a statusbar for each screen and add it
mystatusbar = {}
for s = 1, screen.count() do
    mystatusbar[s] = statusbar({ position = "top", name = "mystatusbar" .. s,
                                 fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the statusbar - order matters
    mystatusbar[s]:widgets({
        mytaglist,
        mylayoutbox[s],
        mytasklist,
        mypromptbox,
        s == 1 and mysystray or nil,
        mytextbox
    })
    mystatusbar[s].screen = s
end
-- }}}

-- {{{ Mouse bindings
--awesome.mouse_add(mouse({ }, 3, function () awful.spawn(terminal) end))
--awesome.mouse_add(mouse({ }, 4, awful.tag.viewnext))
--awesome.mouse_add(mouse({ }, 5, awful.tag.viewprev))
-- }}}

-- {{{ Key bindings

-- Bind keyboard digits
-- Compute the maximum number of digit we need, limited to 20
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(20, math.max(#tags[s], keynumber));
end

if dvorak then
    bindings = {'0', 'apostrophe', 'comma', 'period', 'p', 'y', 'f', 'g', 'c', 'r', 'l' }
else
    bindings = {'0', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p' }
end

-- This is rather irssi-esque
for i = 1, keynumber do
    bind = i
    if i > 9 then
        bind = bindings[i - 9]
    end

    keybinding({ modkey, "Mod1" }, bind,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           awful.tag.viewonly(tags[screen][i])
                       end
                   end):add()
    keybinding({ modkey, "Shift" }, bind,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           tags[screen][i].selected = not tags[screen][i].selected
                       end
                   end):add()
    keybinding({ modkey, "Mod1", "Shift" }, bind,
                   function ()
                       local sel = client.focus
                       if sel then
                           if tags[sel.screen][i] then
                               awful.client.toggletag(tags[sel.screen][i])
                           end
                       end
                   end):add()
end

if dvorak then
    keybinding({ modkey }, "apostrophe", awful.tag.viewprev):add()
    keybinding({ modkey }, "comma", awful.tag.viewnext):add()
    keybinding({ modkey }, "at", awful.tag.viewprev):add()
    keybinding({ modkey }, "less", awful.tag.viewnext):add()

    -- These bindings are for qwerty keyboards on a dvorak layout (e.g. when using synergy)
    keybinding({ "Mod4" }, "q", awful.tag.viewprev):add()
    keybinding({ "Mod4" }, "w", awful.tag.viewnext):add()

else
    keybinding({ "Mod4" }, "q", awful.tag.viewprev):add()
    keybinding({ "Mod4" }, "w", awful.tag.viewnext):add()
end

-- Standard program
keybinding({ "Mod1" }, "grave", function () awful.spawn(terminal) end):add()

if dvorak then
    keybinding({ "Mod1" }, "asciitilde", function () awful.spawn(terminal) end):add()
end

keybinding({ modkey, "Shift" }, "r", awesome.restart):add()
keybinding({ modkey, "Shift" }, "q", awesome.quit):add()

keybinding({ modkey, "Mod1" }, "l", function () awful.spawn("gnome-screensaver-command -l") end):add()

-- Client manipulation
keybinding({ modkey, "Mod1" }, "m", awful.client.maximize):add()
keybinding({ "Mod1" }, "F4", function () client.focus:kill() end):add()
keybinding({ "Mod1" }, "Tab", function () awful.client.focusbyidx(1); client.focus:raise() end):add()
keybinding({ "Mod1", "Shift" }, "Tab", function () awful.client.focusbyidx(-1);  client.focus:raise() end):add()
keybinding({ modkey, "Mod1" }, "space", awful.client.togglefloating):add()
keybinding({ modkey, "Mod1" }, "Return", function () client.focus:swap(awful.client.master()) end):add()

-- Moving windows
function move_window_cb(trans_fn, post_fn)
    local sel = client.focus_get()
    if not sel then
        return
    end

    for tagnumber = 1, 16 do
        tag = tags[sel.screen][tagnumber]
        if tag.selected then
            awful.client.toggletag(tags[sel.screen][trans_fn(tagnumber)])
            awful.client.toggletag(tag)
        end
    end

    post_fn()
    sel:raise()
end

keybinding({ modkey, "Mod1" }, "Right", function ()
    move_window_cb(function (t) return (t % 16) + 1 end, awful.tag.viewnext)
end):add()
keybinding({ modkey, "Mod1" }, "Left", function ()
    move_window_cb(function (t) return ((t + 16 - 2) % 16) + 1 end, awful.tag.viewprev)
end):add()

-- Layout manipulation
keybinding({ modkey }, "space", function () awful.layout.inc(layouts, 1) end):add()
keybinding({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end):add()

-- Prompt
keybinding({ "Mod1" }, "F2", function ()
                                 awful.prompt.run({ prompt = "Run: " }, mypromptbox, awful.spawn, awful.completion.bash,
os.getenv("HOME") .. "/.cache/awesome/history") end):add()

--[[ Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
keybinding({ modkey }, "t", awful.client.togglemarked):add()
keybinding({ modkey, 'Shift' }, "t", function ()
    local tabbedview = tabulous.tabindex_get()
    local clients = awful.client.getmarked()

    if not tabbedview then
        tabbedview = tabulous.tab_create(clients[1])
        table.remove(clients, 1)
    end

    for k,c in pairs(clients) do
        tabulous.tab(tabbedview, c)
    end

end):add()

for i = 1, keynumber do
    keybinding({ modkey, "Shift" }, "F" .. i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           for k, c in pairs(awful.client.getmarked()) do
                               awful.client.movetotag(tags[screen][i], c)
                           end
                       end
                   end):add()
end
-- }}} ]]

-- {{{ Hooks
-- Hook function to execute when focusing a client.
function hook_focus(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end

-- Hook function to execute when unfocusing a client.
function hook_unfocus(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end

-- Hook function to execute when marking a client
function hook_marked(c)
    c.border_color = beautiful.border_marked
end

-- Hook function to execute when unmarking a client
function hook_unmarked(c)
    c.border_color = beautiful.border_focus
end

-- Hook function to execute when the mouse is over a client.
function hook_mouseover(c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= "magnifier" then
        client.focus = c
    end
end

-- Hook function to execute when a new client appears.
function hook_manage(c)
    -- Set floating placement to be smart!
    c.floating_placement = "smart"
    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:mouse_add(mouse({ }, 1, function (c) client.focus = c; c:raise() end))
    c:mouse_add(mouse({ "Mod1" }, 1, function (c) c:mouse_move() end))
    c:mouse_add(mouse({ "Mod1" }, 2, function (c) c:mouse_resize() end))
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal
    client.focus = c

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] then
        c.floating = floatapps[cls]
    elseif floatapps[inst] then
        c.floating = floatapps[inst]
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Honor size hints
    c.honorsizehints = true
end

-- Hook function to execute when arranging the screen
-- (tag switch, new client, etc)
function hook_arrange(screen)
    local layout = awful.layout.get(screen)
    if layout then
        mylayoutbox[screen].text =
            "<bg image=\"/usr/share/awesome/icons/layouts/" .. awful.layout.get(screen) .. "w.png\" resize=\"true\"/>"
        else
            mylayoutbox[screen].text = "No layout."
    end

    -- If no window has focus, give focus to the latest in history
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end

    -- Uncomment if you want mouse warping
    --[[
    local sel = client.focus
    if sel then
        local c_c = sel:coords()
        local m_c = mouse.coords()

        if m_c.x < c_c.x or m_c.x >= c_c.x + c_c.width or
            m_c.y < c_c.y or m_c.y >= c_c.y + c_c.height then
            if table.maxn(m_c.buttons) == 0 then
                mouse.coords({ x = c_c.x + 5, y = c_c.y + 5})
            end
        end
    end
    ]]
end

-- Set up some hooks
awful.hooks.focus.register(hook_focus)
awful.hooks.unfocus.register(hook_unfocus)
awful.hooks.marked.register(hook_marked)
awful.hooks.unmarked.register(hook_unmarked)
awful.hooks.manage.register(hook_manage)
awful.hooks.mouseover.register(hook_mouseover)
awful.hooks.arrange.register(hook_arrange)
awful.hooks.timer.register(10, hook_timer)
-- }}}
