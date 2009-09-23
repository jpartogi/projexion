var adminMenu = new Ext.menu.Menu({
    items: [{
        text: 'Add New Project',
        listeners: {
            click : function (button, event){
                projectFormWindow.show();
            }
        }
    },{
        text: 'Add New User'
    },{
        text: 'Configurations'
    }]
});

Projexion.menu.Menubar = Ext.extend( Ext.Toolbar, {
    height: 35,
    width: '100%',
    defaults: {
        scale: 'medium',
        width: 75
    },

    initComponent: function(config){
        config = {
            items: [{
                    text: 'User',
                    listeners: {
                        click: function (button, event){
                            addTabHandler(mainTabPanel, userListTab);
                        }
                    }
                },{
                    text: 'Admin',
                    menu: adminMenu
                },{
                    xtype: 'tbfill' // start of right aligned
                },{
                    xtype: 'searchfield', // extension
                    width: 200,
                    emptyText: 'Quick Search...'
                },{
                    xtype: 'tbspacer', // give space to the right
                    width: 10
                }
            ]
        }
        
        Ext.apply(this, config);

        Projexion.menu.Menubar.superclass.initComponent.call(this);

    }
});

Ext.reg('menubar', Projexion.menu.Menubar);