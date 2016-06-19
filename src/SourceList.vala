/*
* Copyright (c) 2016 elementary LLC (https://launchpad.net/granite)
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

namespace Granite.Widgets {
    public class Sidebar : Gtk.ListBox {
        public Sidebar () {
            get_style_context ().add_class (Gtk.STYLE_CLASS_SIDEBAR);
            width_request = 150;
            vexpand = true;
        }
    }

    public class SidebarHeader : Gtk.ListBoxRow {
        private Gtk.ListBox children;
        private Gtk.Revealer revealer;

        public SidebarHeader (string label) {
            var header_label = new Gtk.Label (label);
            header_label.get_style_context ().add_class ("h4");
            header_label.halign = Gtk.Align.START;
            header_label.hexpand = true;

            var reveal_image = new Gtk.Image.from_icon_name ("pan-down-symbolic", Gtk.IconSize.BUTTON);

            var header_layout = new Gtk.Grid ();
            header_layout.add (header_label);
            header_layout.add (reveal_image);

            var header = new Gtk.ListBoxRow ();
            header.get_style_context ().add_class ("sidebar-item");
            header.add (header_layout);

            children = new Gtk.ListBox ();

            revealer = new Gtk.Revealer ();
            revealer.reveal_child = true;
            revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_DOWN;
            revealer.add (children);

            var layout = new Gtk.Grid ();
            layout.orientation = Gtk.Orientation.VERTICAL;
            layout.add (header);
            layout.add (revealer);

            add (layout);

            activate.connect (() => {
                if (revealer.reveal_child) {
                    revealer.reveal_child = false;
                    reveal_image.icon_name = "pan-end-symbolic";
                } else {
                    revealer.reveal_child = true;
                    reveal_image.icon_name = "pan-down-symbolic";
                }
            });
        }

        public void add_child (SidebarRow child) {
            children.add (child);
        }
    }
}
