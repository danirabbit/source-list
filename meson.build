project('source-list', ['vala', 'c'],
    version : '0.1'
)

executable(
    'source-list',
    'src/main.vala',
    'src/Sidebar.vala',
    'src/SidebarHeader.vala',
    'src/SidebarExpandableRow.vala',
    'src/SidebarRow.vala',
    dependencies :[
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('gtk+-3.0')
    ],
    install : true
)
