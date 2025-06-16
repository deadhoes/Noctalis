local Library = {}

function Library:Window(name)
    local window = {
        name = name,
        tabs = {},
        _theme = {
            primary = Color3.fromRGB(70, 175, 255),
            secondary = Color3.fromRGB(40, 40, 50),
            accent = Color3.fromRGB(255, 85, 127),
            text = Color3.fromRGB(240, 240, 240)
        }
    }

    -- Window methods
    function window:SetTheme(themeTable)
        for k, v in pairs(themeTable) do
            window._theme[k] = v
        end
        return self -- For chaining
    end

    function window:Tab(name)
        local tab = {
            name = name,
            sections = {}
        }

        -- Tab methods
        function tab:Section(title)
            local section = {
                title = title,
                elements = {}
            }

            -- Section methods (with smooth chaining)
            function section:Button(text, callback)
                local btn = {
                    type = "button",
                    text = text,
                    callback = callback,
                    _theme = window._theme
                }
                table.insert(section.elements, btn)
                return self -- Return section for chaining
            end

            function section:Toggle(text, default, callback)
                local toggle = {
                    type = "toggle",
                    text = text,
                    value = default or false,
                    callback = callback,
                    _theme = window._theme
                }
                table.insert(section.elements, toggle)
                return self
            end

            function section:Slider(text, options, callback)
                local slider = {
                    type = "slider",
                    text = text,
                    min = options.min or 0,
                    max = options.max or 100,
                    value = options.default or 50,
                    callback = callback,
                    _theme = window._theme
                }
                table.insert(section.elements, slider)
                return self
            end

            table.insert(tab.sections, section)
            return section
        end

        table.insert(window.tabs, tab)
        return tab
    end

    return window
end
