/*
* Copyright (c) 2018 Suraj Mandal (https://surajmandalcell.github.io/)
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
* Authored by: Suraj Mandal <https://surajmandalcell.github.io/>
*/

// Dependencies --pkg=glib-2.0 --pkg=gtk+-3.0 --pkg=granite

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
            string css_file = "style.css";
            var provider = new Gtk.CssProvider();
            try {
                provider.load_from_path(css_file);
                Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(), provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
            } catch (Error e) {
                stderr.printf("Error: %s\n", e.message);
            }
        }

        public void info_diag(){
            var dialog = new Granite.MessageDialog.with_image_from_icon_name (
                "About",
                "Install elementary-x gtk-theme which is based on official elementary theme.\n\nTo install plank theme and icon theme as shown in preview then Select from the drop down and click install",
                "gtk-about",
                Gtk.ButtonsType.CLOSE
             );

            // var custom_widget = new Gtk.CheckButton.with_label ("Custom widget");
            // custom_widget.show ();
            // dialog.custom_bin.add (custom_widget);

            dialog.run ();
            dialog.destroy ();
        }

        public void notify (string title, string message, int durationMillis, string urgency){
            try{
                string s = "notify-send -t %d -u %s -i info.png \"%s\" \"%s\"".printf(durationMillis, urgency, title, message);
                Process.spawn_command_line_sync(s);
            }

            catch (Error e){
                stderr.printf("Error: %s\n", e.message);
            }
        }

        // Install theme function
        public void installTheme(){
        }

        protected override void activate () {
            var window = new Gtk.ApplicationWindow (this);
            var main = new Gtk.Grid();
            window.title = "Elementary_x_Installer";
            window.set_decorated(false);
            window.set_default_size (52, -1);
            this.init_css();

            // Close button
            var buttonClose = new Button.from_icon_name ("dialog-close" , BUTTON);
            buttonClose.clicked.connect (() => {
                window.close();
                });
            main.attach(buttonClose, 0, 0, 1, 1);

            // Info button
            var buttonInfo = new Button.from_icon_name("documentinfo", BUTTON);
            buttonInfo.clicked.connect (() => {
                info_diag();
            });
            main.attach(buttonInfo, 0, 1, 1, 1);



            // Progress bar
            var bar = new Gtk.ProgressBar();
            main.attach(bar, 1,0,1,2);


            // Install button
            var buttonInstall = new Button.with_label ("Install");
            buttonInstall.clicked.connect (() => {
                buttonInstall.label = "Installing...";
                string tit="Theme Installed!",desc="elementary-x has been sucessfully installed.",priority="normal";
                notify(tit, desc, 2000, priority);
                installTheme();
                buttonInstall.label = "Installed!";
            });
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