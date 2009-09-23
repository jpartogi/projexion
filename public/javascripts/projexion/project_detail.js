
    //Ext.state.Manager.setProvider(new Ext.state.SessionProvider({state: Ext.appState}));
	Ext.BLANK_IMAGE_URL = 'images/default/s.gif';
		
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

        tbar: [{
                xtype: 'button',
                text: 'Add New',
                iconCls: 'icon-add',
                listeners: {
                    click: function(button, event){
                        backlogFormWindow.show();
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
                        addTabHandler(projectDetailTabPanel, backlogDetailTab);
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
            "Product owner": 'joe',
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
					text: 'Add New Product Backlog',
					leaf: true
				},{
                    text: 'Search Backlog',
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
		items: [ projectMemberGrid, projectTreeMenu ]
	});

    var tpl = new Ext.XTemplate(
		'<tpl for=".">',
            '<div class="backlog-block" id="{code}">',
		    '<div class="backlog">{code} {name}</div>',
		    '</div>',
        '</tpl>',
        '<div class="x-clear"></div>'
	);
    
	var sprintTaskboardTab = new Ext.Panel({
		title: 'Sprint Taskboard',
        layout: 'fit',     
        items:  new Ext.DataView({
            store: store,
            tpl: tpl,
            itemSelector:'div.backlog-block', // make sure not to forget this
            multiSelect: true
        })
	});

    var burndownStore = new Ext.data.JsonStore({
        fields:['tasks', 'days'],
        data: [
            {days: 1, tasks: 20},
            {days: 2, tasks: 18},
            {days: 3, tasks: 17},
            {days: 4, tasks: 15},
            {days: 5, tasks: 13},
            {days: 6, tasks: 10},
            {days: 7, tasks: 9},    
        ]
    });

	var sprintBurndownChartTab = new Ext.Panel({
		title: 'Sprint Burndown',
        layout:'fit',

        items: {
            xtype: 'linechart',
            store: burndownStore,
            url: '../charts.swf',
            xField: 'days',
            yField: 'tasks',
            tipRenderer : function(chart, record){
                return record.data.tasks + ' tasks left on day ' + record.data.days;
            }
        }
	});

    var productBacklogTab = new Ext.Panel({
		id: 'productBacklog',
		title: 'Product Backlog',
		layout: 'fit',
		items: [ productBacklogGrid ]
	});

    var releaseBurndownChartTab = new Ext.Panel({
		title: 'Release Burndown',
        layout:'fit',
        items: {
            xtype: 'linechart',
            store: burndownStore,
            url: '../charts.swf',
            xField: 'days',
            yField: 'tasks',
            tipRenderer : function(chart, record){
                return record.data.tasks + ' tasks left on day ' + record.data.days;
            }
        }
	});

    var velocityChartTab = new Ext.Panel({
        title: 'Velocity Chart',
        layout: 'fit',
        items: {
            xtype: 'linechart',
            store: burndownStore,
            url: '../charts.swf',
            xField: 'days',
            yField: 'tasks',
            tipRenderer : function(chart, record){
                return record.data.tasks + ' tasks left on day ' + record.data.days;
            }
        }
    });

    // TODO: This will tend to get really big. Separate into its own component 
    var projectDetailTabPanel = new Ext.TabPanel({
		enableTabScroll: true,
        autoDestroy: false,
		border: false,		
		activeTab: 0,
		items: [ sprintTaskboardTab, sprintBurndownChartTab, productBacklogTab, releaseBurndownChartTab, velocityChartTab ]
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
        title: 'Add New Project',
        closable:true,
        plain:true,
        width:600,
        //border:false,
        //layout: 'border',
        //items: [nav, tabs],
        height:350,
        closeAction: 'hide'
    });