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



