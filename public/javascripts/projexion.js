Ext.onReady(function() {
    
    //Ext.state.Manager.setProvider(new Ext.state.SessionProvider({state: Ext.appState}));
	Ext.BLANK_IMAGE_URL = 'images/default/s.gif';
			
	var homeSideTabPanel = new Ext.TabPanel({
		border: false, // already wrapped so don't add another border
		activeTab: 0, 
		items: [{
			title: 'My Tasks',
			autoScroll: true
		},{
			title: 'My Profile',
			autoScroll: true
		}]
	});
					
	var homeTab = new Ext.Panel({
		id: 'home',
        title: 'Home',
		layout: 'border',
        border: false,
		items: [{
			region: 'center'
		},{
			region: 'east',
			collapsible: true, 
			animate: false, 
			split: true,
			animCollapse:false, 
			collapseMode:'mini', 
			width: 210,
			minSize: 175,
            maxSize: 400,
			layout: 'fit',
			items: [homeSideTabPanel]
		}]
	});

    var data = [ // temporary mock data
		['foo','bar']
	];

    // temporary mock store, will be changed to JsonStore
	var store = new Ext.data.ArrayStore({
		// store configs
		autoDestroy: true,
		storeId: 'store',
		// reader configs
		idIndex: 0,
		data: data,
		fields: [
		   'code',
		   'name'
		]
	});

    var backlogDetailTab = new Ext.Panel({
        id: 'backlogDetail',
        title: 'Backlog xxx',
        closable: true
    });

    var backlogFormWindow = new Ext.Window({
        title: 'Backlog',
        closable:true,
        plain:true,
        width:600,
        //layout: 'border',
        //items: [nav, tabs],
        height:350,
        closeAction: 'hide'
    });

    var productBacklogGrid = new Ext.grid.GridPanel({
        store: store,
        border: false,

        columns:[{
			header: 'Code'
		},{
			header: 'Name'
		}],

        tbar: [
            new Ext.Button({
                text: 'Add New',
                listeners: {
                    click: function(button, event){
                        backlogFormWindow.show();
                    }
                }
            }),

            new Ext.Button({
                text: 'Delete'
            }),

            new Ext.Button({
                text: 'Detail',
                listeners: {
                    click: function(button, event){
                        addTabHandler(projectDetailTabPanel, backlogDetailTab);
                    }
                }
            })
	    ]
    });

    var projectInfoGrid = new Ext.grid.PropertyGrid({
        title: 'Project Info',
        width: '100%',
        autoExpandColumn: true,
        autoWidth: true,
        region: 'center',

        source: {
            "Name": "Project xxx",
            "Created": new Date(Date.parse('10/15/2006')),
            "Scrum master": 'jpartogi',
            "Version": .01,
            "Description": "Project desc"
        }
    });	

    var projectMemberGrid = new Ext.grid.GridPanel({
		title: 'Project Member',
        border: false,
		store: store,
		columns:[{
			header: 'Name'
		},{
			header: 'Role'
		}]
    });
	
	var projectTreeMenu = new Ext.tree.TreePanel({
		title: 'Project Menu',
		border: false,
		rootVisible: false,
		root: new Ext.tree.AsyncTreeNode({
            expanded: true,
            children: [{
				text: 'Backlog',
				children: [{
					text: 'Add New Backlog',
					leaf: true
				}]
			}, {
                text: 'Release',
				children: [{
					text: 'Add New Release',
					leaf: true
				},{
					text: 'Search Release',
					leaf: true
				}]
            }, {
                text: 'Sprint',
                children: [{
					text: 'Add New Sprint',
					leaf: true
				},{
					text: 'Search Sprint',
					leaf: true
				}]
            }, {
				text: 'Member',
				children: [{
					text: 'Add Member',
					leaf: true
				}]
            }]
        })	
	});
		
	var projectSidePanel = new Ext.Panel({
		region: 'south',
		layout: 'accordion',
        height: 300,
		split: true,
        animCollapse: false,
		collapsible: true,
		collapseMode:'mini',
		items: [ projectTreeMenu, projectMemberGrid ]
	});

	var productBacklogTab = new Ext.Panel({
		id: 'productBacklog',
		title: 'Product Backlog',
		layout: 'fit',
		items: [ productBacklogGrid ]
	});	
	
	var sprintBacklogTab = new Ext.Panel({
		title: 'Sprint Backlog'
	});	
	
	var burndownChartTab = new Ext.Panel({
		title: 'Burndown Chart'
	});	
	
	var projectDetailTabPanel = new Ext.TabPanel({
		enableTabScroll: true,
        autoDestroy: false,
		border: false,		
		activeTab: 0,
		items: [ sprintBacklogTab, burndownChartTab, productBacklogTab ]
	});
	
    var projectDetailTab = new Ext.Panel({
        id: 'projectDetail',
        title: 'Project xxx',
        layout: 'border',
        closable: true,
        items: [{
            region: 'west',
            width: 250,
            layout: 'border',
            collapsible: true,
			split: true,
			animCollapse:false,
			border: false,
			collapseMode:'mini',
            items: [ projectInfoGrid, projectSidePanel ]
        },{
            region: 'center',
            layout: 'fit',
			items:[ projectDetailTabPanel ]
        }]
    });

    var projectFormWindow = new Ext.Window({
        title: 'Project',
        closable:true,
        plain:true,
        width:600,
        //border:false,
        //layout: 'border',
        //items: [nav, tabs],
        height:350,
        closeAction: 'hide'
    });
        
	var projectListGrid = new Ext.grid.GridPanel({
		store: store,

		columns:[{
			header: 'Code'
		},{
			header: 'Name'
		}],

        tbar: [
            new Ext.Button({
                text: 'Add New',
                listeners: {
                    click: function(button, event){
                        projectFormWindow.show();
                    }
                }
            }),

            new Ext.Button({
                text: 'Delete'
            }),

            new Ext.Button({
                text: 'Detail',
                listeners: {
                    click: function(button, event){
                        addTabHandler(mainTabPanel, projectDetailTab);
                    }
                }
            })
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
		closable: true,
		layoutConfig: {
            padding:'5',
            align:'middle'
        },
		items: [ projectListGrid ]
	});
	
	var mainTabPanel = new Ext.TabPanel({
		height: '100%',
		region: 'center',
		activeTab: 0,
		enableTabScroll: true,
        autoDestroy: false,
		border: false,
		defaults: {
            autoScroll: true
        },
		items: [ homeTab ]	  
	});
	
	var addTabHandler = function(/** Component */ tabPanel, /** Component */ tabItem ){
		var tabId = tabItem.getId();
		if(tabPanel.getItem( tabId ) === undefined){
			tabPanel.add( tabItem ).show();
		}else{
			tabPanel.activate(tabItem);
		}	
	}
	
	var projectMenu = new Ext.menu.Menu({
		items: [{
			text: 'Project List',
			listeners: {
				click : function (button, event){
					addTabHandler(mainTabPanel, projectListTab);
				}
			}
		}]
	});
	
	var backlogMenu = new Ext.menu.Menu({
		items: [{
			text: 'Search Backlog',
			listeners: {
				click: function(button, event){
					addTabHandler(backlogSearchTab);
				}
			}
		},{
			text: 'Add New Backlog',
            listeners: {
                click: function(button, event){
                    backlogFormWindow.show();
                }
            }
		}]
	});
	
	var clientMenu = new Ext.menu.Menu({
		items: [{
			text: 'Client List'
		},{
			text: 'Add New Client'
		}]
	});
	
	var userMenu = new Ext.menu.Menu({
		items: [{
			text: 'User List'
		},{
			text: 'Add New User'
		}]
	});
	
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
			text: 'Add New Client'
		},{
			text: 'Settings'
		}]
	});
	
	var menubar = new Ext.Toolbar({
		height: 35,
		width: '100%',
		defaults: {
            scale: 'medium',
			width: 75
        },
		items: [{
				text: 'Project',
				menu: projectMenu
			},{
				text: 'Backlog',
				menu: backlogMenu
			},{
				text: 'Client'
				//menu: clientMenu
			},{
				text: 'User'
				//menu: userMenu
			},{
				text: 'Admin',
				menu: adminMenu
			},{
				xtype: 'tbfill' // start of right aligned
			}, {
				xtype: 'searchfield', // extension
				width: 200,
				emptyText: 'Quick Search...'
			},{
				xtype: 'tbspacer', // give space to the right 
				width: 10
			}
		]
	});


    new Ext.Viewport({
        layout: 'border',
        renderTo: Ext.getBody(),
        items: [
            {
                layout: 'vbox',
                region: 'north',
                height: 90,
                items: [
                    {
                        xtype: 'box',
                        width: '100%',
                        height: 30,
                        applyTo: 'header'
                    },{
                        id: 'statusbar',
                        xtype: 'panel',border: false,
                        width: '100%',
                        tbar: new Ext.Toolbar({
                            items:['->', 'Logged in as: jpartogi', '-', '<a href="#">Logout</a>']
                        }),

                        bbar: menubar
                    }
                ]
            },
            mainTabPanel // center region
            /*,{
                region: 'south',
                title: 'Logs',
                split: true,
                collapsible: true,
                animCollapse:false,
                closed: true,
                height: 70,
                maxSize: 200
            } */
        ]
    });
        
}); // Ext.onReady closer