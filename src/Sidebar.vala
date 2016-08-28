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
    public class Sidebar : Gtk.Grid {
        enum Target {
            INT32,
            STRING,
            ROOTWIN
        }

        const Gtk.TargetEntry[] target_list = {
            { "INTEGER",    0, Target.INT32 },
            { "STRING",     0, Target.STRING },
            { "text/plain", 0, Target.STRING },
            { "application/x-rootwindow-drop", 0, Target.ROOTWIN }
        };

        public Sidebar () {
            orientation = Gtk.Orientation.VERTICAL;
            get_style_context ().add_class (Gtk.STYLE_CLASS_SIDEBAR);
            width_request = 200;
            vexpand = true;

            // Make this widget a DnD destination.
            Gtk.drag_dest_set (
                    this,                     // widget that will accept a drop
                    Gtk.DestDefaults.MOTION       // default actions for dest on DnD
                    | Gtk.DestDefaults.HIGHLIGHT,
                    target_list,              // lists of target to support
                    Gdk.DragAction.COPY           // what to do with data after dropped
                );

            // All possible destination signals
            this.drag_motion.connect(this.on_drag_motion);
            this.drag_leave.connect(this.on_drag_leave);
            this.drag_drop.connect(this.on_drag_drop);
            this.drag_data_received.connect(this.on_drag_data_received);
        }

        /** Emitted when a drag is over the destination */
        private bool on_drag_motion (Gtk.Widget widget, Gdk.DragContext context, int x, int y, uint time) {
            // Fancy stuff here. This signal spams the console something horrible.
            // print ("%s: on_drag_motion\n", widget.name);
            return false;
        }

        /** Emitted when a drag leaves the destination */
        private void on_drag_leave (Gtk.Widget widget, Gdk.DragContext context, uint time) {
            print ("%s: on_drag_leave\n", widget.name);
        }

        /**
         * Emitted when the user releases (drops) the selection. It should check
         * that the drop is over a valid part of the widget (if its a complex
         * widget), and itself to return true if the operation should continue. Next
         * choose the target type it wishes to ask the source for. Finally call
         * Gtk.drag_get_data which will emit "drag_data_get" on the source.
         */
        private bool on_drag_drop (Gtk.Widget widget, Gdk.DragContext context, int x, int y, uint time) {
            print ("%s: on_drag_drop\n", widget.name);

            // Check to see if (x, y) is a valid drop site within widget
            bool is_valid_drop_site = true;

            // If the source offers a target
            if (context.list_targets() != null) {
                // Choose the best target type
                var target_type = (Gdk.Atom) context.list_targets().nth_data (Target.INT32);

                // Request the data from the source.
                Gtk.drag_get_data (
                        widget,         // will receive 'drag_data_received' signal
                        context,        // represents the current state of the DnD
                        target_type,    // the target type we want
                        time            // time stamp
                    );
            } else {
                // No target offered by source => error
                is_valid_drop_site = false;
            }

            return is_valid_drop_site;
        }

        /**
         * Emitted when the data has been received from the source. It should check
         * the Gtk.SelectionData sent by the source, and do something with it. Finally
         * it needs to finish the operation by calling Gtk.drag_finish, which will
         * emit the "data_delete" signal if told to.
         */
        private void on_drag_data_received (Gtk.Widget widget, Gdk.DragContext context, int x, int y, Gtk.SelectionData selection_data, uint target_type, uint time) {
            bool dnd_success = false;
            bool delete_selection_data = false;

            print ("%s: on_drag_data_received\n", widget.name);

            // Deal with what we are given from source
            if ((selection_data != null) && (selection_data.get_length() >= 0)) {
                if (context.get_suggested_action() == Gdk.DragAction.ASK) {
                    // Ask the user to move or copy, then set the context action.
                }

                if (context.get_suggested_action() == Gdk.DragAction.MOVE) {
                    delete_selection_data = true;
                }

                // Check that we got the format we can use
                print (" Receiving ");
                switch (target_type) {
                case Target.INT32:
                    long* data = (long*) selection_data.get_data();
                    print ("integer: %ld", (*data));
                    dnd_success = true;
                    break;
                case Target.STRING:
                    print ("string: %s", (string) selection_data.get_data());
                    dnd_success = true;
                    break;
                default:
                    print ("nothing good");
                    break;
                }

                print (".\n");
            }

            if (dnd_success == false) {
                print ("DnD data transfer failed!\n");
            }

            Gtk.drag_finish (context, dnd_success, delete_selection_data, time);
        }
    }
}
