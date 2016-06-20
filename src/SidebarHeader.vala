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
    public class SidebarHeader : SidebarExpandableRow {
        public SidebarHeader (string label) {
            var header_label = new Gtk.Label (label);
            header_label.get_style_context ().add_class ("h4");
            header_label.halign = Gtk.Align.START;
            header_label.hexpand = true;

            var header_revealer = new Gtk.Revealer ();
            header_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
            header_revealer.add (disclosure_triangle);

            var header_layout = new Gtk.Grid ();
            header_layout.add (header_label);
            header_layout.add (header_revealer);

            var header = new Gtk.Button ();
            header.get_style_context ().add_class ("sidebar-item");
            header.get_style_context ().remove_class ("button");
            header.add (header_layout);

            add (header);
            add (revealer);

            header.clicked.connect (() => {
                toggle_reveal_children ();
            });

            header.enter_notify_event.connect (() => {
                header_revealer.reveal_child = true;
                return false;
            });

            header.leave_notify_event.connect (() => {
                header_revealer.reveal_child = false;
                return false;
            });
        }
    }
}
