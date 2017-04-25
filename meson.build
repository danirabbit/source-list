project('com.github.danrabbit.source-list', ['vala', 'c'],
    version : '0.1'
)

executable(
    'com.github.danrabbit.source-list',
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

install_data(
    'data/com.github.danrabbit.source-list.desktop',
    install_dir : 'share/applications'
)
