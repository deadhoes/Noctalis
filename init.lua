local Noctalis = {}

function Noctalis.new()
    local self = {}
    local windows = {}

    -- Varsayılan tema ayarları
    local theme = {
        primary = Color3.fromRGB(98, 181, 255),
        secondary = Color3.fromRGB(55, 55, 70),
        accent = Color3.fromRGB(255, 85, 127),
        text = Color3.fromRGB(240, 240, 240)
    }

    function self:Window(name, options)
        options = options or {}
        local window = {
            name = name,
            tabs = {},
            size = options.size or Vector2.new(500, 400)
        }

        function window:Tab(name, icon)
            local tab = {
                name = name,
                icon = icon,
                sections = {}
            }

            function tab:Section(title, side)
                local section = {
                    title = title,
                    side = side or "left",
                    elements = {}
                }

                -- Buton elementi
                function section:Button(text, callback)
                    local btn = {
                        type = "button",
                        text = text,
                        callback = callback
                    }
                    table.insert(section.elements, btn)
                    return section -- Zincirleme kullanım
                end

                -- Toggle elementi
                function section:Toggle(text, default, callback)
                    local toggle = {
                        type = "toggle",
                        text = text,
                        value = default or false,
                        callback = callback
                    }
                    table.insert(section.elements, toggle)
                    return section
                end

                table.insert(tab.sections, section)
                return section
            end

            table.insert(window.tabs, tab)
            return tab
        end

        table.insert(windows, window)
        return window
    end

    -- Tema değiştirme fonksiyonu
    function self:SetTheme(customTheme)
        for k, v in pairs(customTheme) do
            theme[k] = v
        end
    end

    return self
end
