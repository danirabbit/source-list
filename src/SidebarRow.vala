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
        public signal void action_clicked ();

        private Gtk.Button button;
        private Gtk.Image button_image;
        private Gtk.Image icon;
        private Gtk.Label badge_label;
        private Gtk.Label row_label;
        private Gtk.Revealer button_revealer;
        private Gtk.Spinner spinner;
        private Gtk.Stack button_stack;

        public SidebarRow (string label, string icon_name) {
            icon = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.BUTTON);

            row_label = new Gtk.Label (label);
            row_label.halign = Gtk.Align.START;
            row_label.hexpand = true;

            badge_label = new Gtk.Label ("");
            badge_label.get_style_context ().add_class ("badge");
            badge_label.valign = Gtk.Align.CENTER;
            badge_label.no_show_all = true;

            button_image = new Gtk.Image ();
            button_image.icon_size = Gtk.IconSize.BUTTON;

            button = new Gtk.Button ();
            button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            button.image = button_image;

            spinner = new Gtk.Spinner ();

            button_stack = new Gtk.Stack ();
            button_stack.transition_type = Gtk.StackTransitionType.CROSSFADE;
            button_stack.add (button);
            button_stack.add (spinner);

            button_revealer = new Gtk.Revealer ();
            button_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
            button_revealer.add (button_stack);

            var layout = new Gtk.Grid ();
            layout.margin_start = 6;
            layout.add (icon);
            layout.add (row_label);
            layout.add (button_revealer);
            layout.add (badge_label);

            get_style_context ().add_class ("sidebar-item");
            add (layout);

            button.clicked.connect (() => {
                action_clicked ();
            });
        }

        public string action_icon_name {
            set {
                button_image.icon_name = value;
            }
        }

        public int badge {
            set {
                if (value != 0) {
                    if (value > 999) {
                        badge_label.label = "∞";
                    } else {
                        badge_label.label = value.to_string ();
                    }
                    badge_label.visible = true;
                } else {
                    badge_label.visible = false;
                }
            }
        }

        public bool busy {
            get {
                if (button_stack.visible_child == spinner) {
                    return spinner.active;
                }
                return false;
            }
            set {
                spinner.active = value;
                if (value) {
                    button_stack.visible_child = spinner;
                    button_revealer.reveal_child = true;
                }
            }
        }

        public string icon_name {
            set {
                icon.icon_name = value;
            }
        }

        public string label {
            get {
                return row_label.label;
            }
            set {
                row_label.label = value;
            }
        }

        public bool reveal_button {
            get {
                if (button_stack.visible_child == button) {
                    return button_revealer.reveal_child;
                }
                return false;
            }
            set {
                if (value) {
                    button_stack.visible_child = button;
                }
                button_revealer.reveal_child = value;
            }
        }
    }
}
