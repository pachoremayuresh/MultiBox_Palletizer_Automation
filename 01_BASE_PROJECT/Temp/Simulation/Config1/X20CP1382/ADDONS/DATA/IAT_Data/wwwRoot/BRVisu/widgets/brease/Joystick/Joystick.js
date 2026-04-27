define([
    'widgets/brease/XYJoystick/XYJoystick',
    'widgets/brease/Joystick/libs/JoystickView',
    'widgets/brease/common/DragDropProperties/libs/DroppablePropertiesEvents'], 
function (SuperClass, JoystickView) {

    'use strict';

    /**
    * @class widgets.brease.Joystick
    * @extends widgets.brease.XYJoystick
    *
    * @mixins widgets.brease.common.DragDropProperties.libs.DroppablePropertiesEvents
    * 
    * @iatMeta studio:license
    * licensed
    * @iatMeta category:Category
    * Numeric
    * @iatMeta description:short
    * Schieberegler auf welchem in jede Richtung verschoben werden kann
    * @iatMeta description:de
    * Ermöglicht dem Benutzer numerische Werte mit einem Schiebeschalter in jede Richtung zu verändern
    * @iatMeta description:en
    * Enables the user to change numeric values by a slider in any direction
    * @iatMeta studio:visible
    * true
    */

    var defaultSettings = {},
        WidgetClass = SuperClass.extend(function Joystick() {
            SuperClass.apply(this, arguments);
        }, defaultSettings),

        p = WidgetClass.prototype;

    p.init = function () {
        this.addInitialClass('breaseJoystick');
        SuperClass.prototype.init.apply(this, arguments);
    };

    p._createView = function () {
        return new JoystickView(this.store, this.el, this);
    };

    p._setHeight = function (h) {
        SuperClass.prototype._setHeight.apply(this, arguments);
        this.settings.width = this.settings.height ? this.settings.height : h;
        this.View.render();
    };

    p._setWidth = function (w) {
        SuperClass.prototype._setWidth.apply(this, arguments);
        this.settings.height = this.settings.width ? this.settings.width : w;
        this.View.render();
    };

    p.setXValue = function () {
    };

    p.setYValue = function () {
    };

    /**
    * @method LockYAxis
    * @hide
    */
    p.LockYAxis = function () {
        this.settings.lockYAxis = false;
    };

    /**
    * @method LockXAxis
    * @hide
    */
    p.LockXAxis = function () {
        this.settings.lockXAxis = false;
    };

    return WidgetClass;
});
