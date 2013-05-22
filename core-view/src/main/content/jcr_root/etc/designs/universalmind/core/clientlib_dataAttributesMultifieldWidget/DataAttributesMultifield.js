//console.log("load Data Attributes Multifield Widget");
// Create the namespace
DataAttributeMultifield = {};
// Create a new class based on existing CompositeField
DataAttributeMultifield.Input = CQ.Ext.extend(CQ.form.CompositeField, {

    /**
     * @private
     * @type CQ.Ext.form.TextField
     */
    hiddenField: null,

    /**
     * @private
     * @type CQ.Ext.form.TextField
     */
    nameField: null,

    /**
     * @private
     * @type CQ.Ext.form.TextField
     */
    valueField: null,


    constructor: function(config) {
        config = config || { };
        var defaults = {
            "border": false,
            "layout": "table",
            "columns":2
        };
        config = CQ.Util.applyDefaults(config, defaults);
        DataAttributeMultifield.Input .superclass.constructor.call(this, config);
    },

    // overriding CQ.Ext.Component#initComponent
    initComponent: function() {
        DataAttributeMultifield.Input.superclass.initComponent.call(this);

        this.hiddenField = new CQ.Ext.form.Hidden({
            name: this.name
        });
        this.add(this.hiddenField);


        this.add(new CQ.Ext.form.Label({
            text: "data-"
        }));

        this.nameField= new CQ.Ext.form.TextField({
            listeners: {
                change: {
                    scope:this,
                    fn:this.updateHidden
                }
            }
        });
        this.add(this.nameField);


        this.add(new CQ.Ext.form.Label({
            text: "="
        }));


        this.valueField= new CQ.Ext.form.TextField({
            listeners: {
                change: {
                    scope:this,
                    fn:this.updateHidden
                }
            }
        });
        this.add(this.valueField);

    },


    // overriding CQ.form.CompositeField#setValue
    setValue: function (value) {
        var parts = value.split("=");
        this.nameField.setValue(parts[0]);
        this.valueField.setValue(parts[1]);
        this.hiddenField.setValue(value);
    },

    // overriding CQ.form.CompositeField#getValue
    getValue: function() {
        return this.getRawValue();
    },

    getRawValue: function () {
        return this.nameField.getValue() + "=" +
            this.valueField.getValue();
    },

    // private
    updateHidden: function() {
        this.hiddenField.setValue(this.getValue());
    }

});

CQ.Ext.reg("dataAttributeMultifield", DataAttributeMultifield.Input);
