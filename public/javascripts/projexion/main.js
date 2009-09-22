/**
 * Copyright (c) 2008 Scrum8
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
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