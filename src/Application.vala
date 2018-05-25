/*
* Copyright (c) {{yearrange}} cruelplatypus67 (https://surajmandalcell.github.io/)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: cruelplatypus67 <https://surajmandalcell.github.io/>
*/
using Granite;
using Granite.Widgets;
using Gtk;

namespace Elementary_x_Installer {
    public class Application : Granite.Application {

        public Application () {
            Object(
                application_id: "com.github.surajmandalcell.Elementary_x_Installer", 
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        public void init_css() {
            // Load CSS
            string css_file = "/mnt/sda3/Dropbox/Dev/Projects/git/ElementaryApps/Elementary-x-Installer/src/style.css";
            var provider = new Gtk.CssProvider();
            try {
                provider.load_from_path(css_file);
                Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(), provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
            } catch (Error e) {
                stderr.printf("Error: %s\n", e.message);
            }
        }

        protected override void activate () {
            var window = new Gtk.ApplicationWindow (this);
            var css = new Gtk.CssProvider();
            var main = new Gtk.Grid();

            window.title = "Elementary_x_Installer";
            window.set_decorated(false);
            window.set_default_size (-1, -1);
            this.init_css();

            var buttonClose = new Button.from_icon_name ("window-close" , BUTTON);
            // buttonClose.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            buttonClose.clicked.connect (() => {
                window.close();
                });
            main.attach(buttonClose, 0, 0, 1, 1);

            var buttonInfo = new Button.from_icon_name("documentinfo", BUTTON);
            // buttonInfo.clicked.connect (() => {
            //     window.dialog();
            // });
            main.attach(buttonInfo, 0, 1, 1, 1);

            var Progress = new Gtk.ProgressBar();
            main.attach(Progress, 1, 0, 2, 2);

            var buttonInstall = new Button.with_label ("Install");
    		buttonInstall.clicked.connect (() => {
        	buttonInstall.label = "Installing..."; });
        	main.attach(buttonInstall, 3, 0, 1, 2);

            window.add (main);
            window.show_all ();
        }

        public static int main (string[] args) {
            var app = new Elementary_x_Installer.Application ();
            return app.run (args);
        }
    }
}