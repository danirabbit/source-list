project('source-list', ['vala', 'c'],
    version : '0.1'
)

glib = dependency('glib-2.0')
gobject = dependency('gobject-2.0')
gtk = dependency('gtk+-3.0')

executable(
    'source-list',
    'src/main.vala',
    'src/Sidebar.vala',
    'src/SidebarHeader.vala',
    'src/SidebarExpandableRow.vala',
    'src/SidebarRow.vala',
    dependencies :[
        glib,
        gobject,
        gtk
    ],
    install : true
)
