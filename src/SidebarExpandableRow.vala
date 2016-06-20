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
    public abstract class SidebarExpandableRow : Gtk.Grid {
        protected Gtk.ListBox children;
        protected Gtk.Revealer revealer;
        protected Gtk.Image disclosure_triangle;

        public SidebarExpandableRow () {
            children = new Gtk.ListBox ();

            revealer = new Gtk.Revealer ();
            revealer.reveal_child = true;
            revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_DOWN;
            revealer.add (children);

            disclosure_triangle = new Gtk.Image.from_icon_name ("pan-down-symbolic", Gtk.IconSize.BUTTON);

            revealer.notify["reveal-child"].connect (() => {
                if (revealer.reveal_child) {
                    disclosure_triangle.icon_name = "pan-down-symbolic";
                } else {
                    disclosure_triangle.icon_name = "pan-end-symbolic";
                }
            });

            orientation = Gtk.Orientation.VERTICAL;
        }

        public void toggle_reveal_children () {
            if (revealer.reveal_child) {
                revealer.reveal_child = false;
            } else {
                revealer.reveal_child = true;
            }
        }

        public void add_child (SidebarRow child) {
            children.add (child);
        }

        public void remove_child (SidebarRow child) {
            children.remove (child);
        }

    }
}
