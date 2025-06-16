local Library = {}

-- Theme settings (can be customized)
Library.Theme = {
    Primary = Color3.fromRGB(25, 25, 25),
    Secondary = Color3.fromRGB(30, 30, 30),
    Accent = Color3.fromRGB(0, 120, 215),
    TextColor = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Gotham
}

function Library:Window(name)
    local WindowInstance = {
        Name = name,
        Tabs = {},
        Visible = true
    }
    
    local WindowFunctions = {}
    
    -- Window methods
    function WindowFunctions:Toggle()
        WindowInstance.Visible = not WindowInstance.Visible
        -- Update UI visibility here
        print(("Window '%s' visibility: %s"):format(WindowInstance.Name, WindowInstance.Visible))
    end
    
    function WindowFunctions:Tab(name)
        local TabInstance = {
            Name = name,
            Sections = {}
        }
        table.insert(WindowInstance.Tabs, TabInstance)
        
        local TabFunctions = {}
        
        function TabFunctions:Section(name)
            local SectionInstance = {
                Name = name,
                Elements = {}
            }
            table.insert(TabInstance.Sections, SectionInstance)
            
            local SectionFunctions = {}
            
            -- Button element
            function SectionFunctions:Button(text, callback)
                local ButtonInstance = {
                    Type = "Button",
                    Text = text,
                    Callback = callback
                }
                table.insert(SectionInstance.Elements, ButtonInstance)
                
                -- Return button-specific functions if needed
                local ButtonFunctions = {}
                
                function ButtonFunctions:SetText(newText)
                    ButtonInstance.Text = newText
                    -- Update UI here
                    print(("Button text updated to: %s"):format(newText))
                end
                
                print(("Created button '%s' in section '%s'"):format(text, name))
                
                return ButtonFunctions
            end
            
            -- Toggle element
            function SectionFunctions:Toggle(text, default, callback)
                local ToggleInstance = {
                    Type = "Toggle",
                    Text = text,
                    Value = default or false,
                    Callback = callback
                }
                table.insert(SectionInstance.Elements, ToggleInstance)
                
                local ToggleFunctions = {}
                
                function ToggleFunctions:SetValue(value)
                    ToggleInstance.Value = value
                    -- Update UI here
                    if callback then callback(value) end
                    print(("Toggle '%s' set to: %s"):format(text, value))
                end
                
                print(("Created toggle '%s' in section '%s'"):format(text, name))
                
                return ToggleFunctions
            end
            
            -- Slider element
            function SectionFunctions:Slider(text, min, max, default, callback)
                local SliderInstance = {
                    Type = "Slider",
                    Text = text,
                    Min = min,
                    Max = max,
                    Value = default or min,
                    Callback = callback
                }
                table.insert(SectionInstance.Elements, SliderInstance)
                
                local SliderFunctions = {}
                
                function SliderFunctions:SetValue(value)
                    SliderInstance.Value = math.clamp(value, min, max)
                    -- Update UI here
                    if callback then callback(SliderInstance.Value) end
                    print(("Slider '%s' set to: %d"):format(text, SliderInstance.Value))
                end
                
                print(("Created slider '%s' (%d-%d) in section '%s'"):format(text, min, max, name))
                
                return SliderFunctions
            end
            
            -- Label element
            function SectionFunctions:Label(text)
                local LabelInstance = {
                    Type = "Label",
                    Text = text
                }
                table.insert(SectionInstance.Elements, LabelInstance)
                
                local LabelFunctions = {}
                
                function LabelFunctions:SetText(newText)
                    LabelInstance.Text = newText
                    -- Update UI here
                    print(("Label text updated to: %s"):format(newText))
                end
                
                print(("Created label '%s' in section '%s'"):format(text, name))
                
                return LabelFunctions
            end
            
            print(("Created section '%s' in tab '%s'"):format(name, TabInstance.Name))
            
            return SectionFunctions
        end
        
        print(("Created tab '%s' in window '%s'"):format(name, WindowInstance.Name))
        
        return TabFunctions
    end
    
    print(("Created window '%s'"):format(name))
    
    return WindowFunctions
end
