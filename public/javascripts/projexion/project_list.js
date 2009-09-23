var projectListGrid = new Ext.grid.GridPanel({
    store: store,

    columns:[{
        header: 'Code'
    },{
        header: 'Name'
    }],

    tbar: [{
            text: 'Add New',
            iconCls: 'icon-add',
            listeners: {
                click: function(button, event){
                    projectFormWindow.show();
                }
            }
        },'-',{
            xtype: 'button',
            text: 'Delete',
            iconCls: 'icon-delete'
        },'-',{
            xtype: 'button',
            text: 'Detail',
            iconCls: 'icon-edit',
            listeners: {
                click: function(button, event){
                    addTabHandler(mainTabPanel, projectDetailTab);
                }
            }
        }
    ],

    bbar: new Ext.PagingToolbar({
        pageSize: 25,
        displayInfo: true,
        displayMsg: 'Displaying topics {0} - {1} of {2}',
        emptyMsg: "No topics to display"
    })
});

var projectListTab = new Ext.Panel({
    layout: 'fit',
    id: 'projectList',
    title: 'Project List',
    layoutConfig: {
        padding:'5',
        align:'middle'
    },
    items: [ projectListGrid ]
});