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
    public class SidebarRow : Gtk.ListBoxRow {
        private Gtk.Label item_badge;
        private Gtk.Image item_icon;

        public SidebarRow (string label, string icon_name) {
            item_icon = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.BUTTON);

            var item_label = new Gtk.Label (label);
            item_label.halign = Gtk.Align.START;
            item_label.hexpand = true;

            item_badge = new Gtk.Label ("");
            item_badge.get_style_context ().add_class ("badge");
            item_badge.valign = Gtk.Align.CENTER;
            item_badge.no_show_all = true;

            var layout = new Gtk.Grid ();
            layout.margin_start = 6;
            layout.add (item_icon);
            layout.add (item_label);
            layout.add (item_badge);

            get_style_context ().add_class ("sidebar-item");
            add (layout);
        }

        public int badge {
            get {
                return item_badge.label.to_int ();
            }
            set {
                item_badge.label = value.to_string ();
                if (value != 0) {
                    item_badge.visible = true;
                }
            }
        }

        public string icon_name {
            set {
                item_icon.icon_name = value;
            }
        }
    }
}
