/*
* Copyright (c) 2016 Daniel Foré (https://github.com/danrabbit/minifighter)
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
* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
* Boston, MA 02111-1307, USA.
*
*/

public class SourceList : Gtk.Application {

    private string APPNAME = "Source List Demo";

    public SourceList () {
        Object (application_id: "org.danrabbit.sourcelist",
        flags: ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        var header = new Gtk.HeaderBar ();
        header.get_style_context ().add_class ("compact");
        header.show_close_button = true;
        header.title = APPNAME;

        var window = new Gtk.ApplicationWindow (this);
        window.title = APPNAME;
        window.set_titlebar (header);
        window.set_default_size (1024, 768);


        var personal = new Granite.Widgets.SidebarHeader ("Personal");

        var home = new Granite.Widgets.SidebarRow ("Home", "user-home");
        var recent = new Granite.Widgets.SidebarRow ("Recent", "folder-recent");
        var documents = new Granite.Widgets.SidebarRow ("Documents", "folder-documents");
        var music = new Granite.Widgets.SidebarRow ("Music", "folder-music");
        var trash = new Granite.Widgets.SidebarRow ("Trash", "user-trash-empty");
        trash.icon_name = "user-trash-full";

        var devices = new Granite.Widgets.SidebarHeader ("Devices");

        var filesystem = new Granite.Widgets.SidebarRow ("Filesystem", "drive-harddisk");
        filesystem.button_icon_name = "media-eject-symbolic";
        filesystem.badge = 4;

        var sidebar = new Granite.Widgets.Sidebar ();
        sidebar.add (personal);
        personal.add_child (home);
        personal.add_child (recent);
        personal.add_child (documents);
        personal.add_child (music);
        personal.add_child (trash);
        sidebar.add (devices);
        devices.add_child (filesystem);

        var filesystem_button = new Gtk.Button.with_label ("Toggle Eject Button");
        filesystem_button.clicked.connect (() => {
            if (filesystem.reveal_button) {
                filesystem.reveal_button = false;
            } else {
                filesystem.reveal_button = true;
            }
        });

        var filesystem_busy = new Gtk.Button.with_label ("Toggle Busy");
        filesystem_busy.clicked.connect (() => {
            if (filesystem.busy) {
                filesystem.busy = false;
            } else {
                filesystem.busy = true;
            }
        });

        var badge_spin = new Gtk.SpinButton.with_range (0, 99999, 7);
        badge_spin.bind_property ("value", home, "badge", BindingFlags.DEFAULT);

        var layout = new Gtk.Grid ();
        layout.row_spacing = 12;
        layout.orientation = Gtk.Orientation.VERTICAL;
        layout.width_request = 650;
        layout.margin = 24;
        layout.add (badge_spin);
        layout.add (filesystem_button);
        layout.add (filesystem_busy);

        var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
        paned.add (sidebar);
        paned.add (layout);

        window.add (paned);
        window.show_all ();
    }

    public static int main (string[] args) {
        var app = new SourceList ();
        return app.run (args);
    }
}
