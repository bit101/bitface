using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Application;

const _useMilitaryFormatKey = "use_military_format";

class SettingsView extends WatchUi.Menu2 {

    function initialize() {
        Menu2.initialize({:title => "Settings"});
        
        Menu2.addItem(
            new MenuItem(
                "Use Military Format",
                Application.Properties.getValue("UseMilitaryFormat") ? "Enabled (24h format)" : "Disabled",
                _useMilitaryFormatKey,
                {}
            )
        );
	}
}

class SettingsDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        if (item.getId().equals(_useMilitaryFormatKey)) {
            var toggle = Application.Properties.getValue("UseMilitaryFormat");
            Application.Properties.setValue("UseMilitaryFormat", !toggle);
            onBack();
        }
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}