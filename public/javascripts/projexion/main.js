/**
 *
 */

// This is the entry point for the application layout. It's where everything starts.

var Projexion = { version: '0.5.0' };

Projexion.Main = function(){
        new Ext.Viewport({
        layout: 'border',
        renderTo: Ext.getBody(),
        items: [
            {
                layout: 'vbox',
                region: 'north',
                height: 65,
                items: [
                    {
                        xtype: 'box',
                        width: '100%',
                        height: 30,
                        applyTo: 'header'
                    },{
                        id: 'statusbar',
                        xtype: 'panel',
                        border: false,
                        width: '100%',
                        tbar: menubar
                    }
                ]
            },
            mainTabPanel // center region
            ,{
                region: 'south',
                layout: 'fit',
                border: false,
                height: 35,
                items: [{
                    xtype: 'box',
                    applyTo: 'footer'
                }]
            }
        ]
    });
}

Ext.onReady(Projexion.Main);