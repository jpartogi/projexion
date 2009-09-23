var Projexion = { version: '0.5.0' };

Ext.namespace('Projexion.menu');

var addTabHandler = function(/** Component */ tabPanel, /** Component */ tabItem ){
    var tabId = tabItem.getId();
    if(tabPanel.getItem( tabId ) === undefined){
        tabPanel.add( tabItem ).show();
    }else{
        tabPanel.activate(tabItem);
    }
}

/* Temporary only for mocking */
var data = [ // temporary mock data
    ['foo','bar'],
    ['spock', 'baz']
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