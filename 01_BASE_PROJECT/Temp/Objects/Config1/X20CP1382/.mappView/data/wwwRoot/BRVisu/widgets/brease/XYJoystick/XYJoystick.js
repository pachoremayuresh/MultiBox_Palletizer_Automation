define([
    'brease/core/BaseWidget',
    'brease/events/BreaseEvent',
    'widgets/brease/XYJoystick/libs/config/Config',
    'widgets/brease/XYJoystick/libs/config/InitState',
    'widgets/brease/XYJoystick/libs/view/XYJoystickView/XYJoystickView',
    'widgets/brease/XYJoystick/libs/reducer/XYJoystickActions',
    'widgets/brease/XYJoystick/libs/reducer/XYJoystickReducer',
    'widgets/brease/common/libs/external/redux',
    'widgets/brease/common/libs/wfUtils/UtilsEditableBinding',
    'brease/decorators/DragAndDropCapability',
    'widgets/brease/common/libs/BreaseResizeObserver',
    'brease/decorators/ContentActivatedDependency',
    'widgets/brease/common/DragDropProperties/libs/DroppablePropertiesEvents'
], function (
    SuperClass, BreaseEvent, Config, InitState,
    XYJoystickView, XYJoystickActions, XYJoystickReducer,
    Redux, UtilsEditableBinding, dragAndDropCapability, BreaseResizeObserver, contentActivatedDependency
) {

    'use strict';

    /**
    * @class widgets.brease.XYJoystick
    * @extends brease.core.BaseWidget
    *
    * @mixins widgets.brease.common.DragDropProperties.libs.DroppablePropertiesEvents
    * 
    * @iatMeta studio:license
    * licensed
    * @iatMeta category:Category
    * Numeric
    * @iatMeta description:short
    * Schieberegler auf welcher in X oder Y Richtung verschoben werden kann
    * @iatMeta description:de
    * Ermöglicht dem Benutzer numerische Werte mit einem Schiebeschalter in X oder Y Richtung zu verändern
    * @iatMeta description:en
    * Enables the user to change numeric values by a slider in X or Y direction
    * @iatMeta studio:visible
    * true
    */

    var defaultSettings = Config,

        WidgetClass = SuperClass.extend(function XYJoystick() {
            SuperClass.apply(this, arguments);
        }, defaultSettings),

        p = WidgetClass.prototype;

    WidgetClass.static.multitouch = true;

    p.init = function () {
        this.addInitialClass('breaseXYJoystick');
        this.triggerXValueChangedThrottled = _.throttle(this.triggerXValueChangedEvent, 100);
        this.triggerYValueChangedThrottled = _.throttle(this.triggerYValueChangedEvent, 100);
        SuperClass.prototype.init.apply(this, arguments);  
        //Calculate init state
        var initState = InitState.calculateInitState(this.settings, this.isEnabled(), this.isVisible());

        //Create store
        this.store = Redux.createStore(XYJoystickReducer, initState);

        //Create View
        this.View = this._createView();

        //Subscribe master view to the store
        this.store.subscribe(this.View.render.bind(this.View));

        // prevent parent gestures when the user interacts with the thumb (e.g.: ContentCarousel)
        this.el.on('mousedown pointerdown touchstart', '.ThumbView', this._bind(_stopEventPropagation));
        this.observer = new BreaseResizeObserver(this.elem, this._bind('redrawView'));
        this.addListeners();
    };

    p._createView = function () {
        return new XYJoystickView(this.store, this.el, this);
    };

    p.contentActivatedHandler = function () {
        if (this.observer.initialized) {
            this.observer.wake();
        } else {
            this.observer.init();
        }
    };
    /**
        * @method setXValue
        * Sets xValue
        * @param {Number} xValue
        */
    p.setXValue = function (xValue) {
        this.settings.xValue = xValue;
        this.updateValues();
    };

    /**
        * @method getXValue 
        * Returns xValue.
        * @iatStudioExposed
        * @return {Number}
        */
    p.getXValue = function () {
        return this.settings.xValue;
    };

    /**
        * @method setYValue
        * Sets yValue
        * @param {Number} yValue
        */
    p.setYValue = function (yValue) {
        this.settings.yValue = yValue;
        this.updateValues();
    };

    /**
        * @method getYValue 
        * Returns yValue.
        * @iatStudioExposed
        * @return {Number}
        */
    p.getYValue = function () {
        return this.settings.yValue;
    };

    /**
        * @method setTrackSize
        * Sets trackSize
        * @param {PixelVal} trackSize
        */
    p.setTrackSize = function (trackSize) {
        this.settings.trackSize = trackSize;
        var action = XYJoystickActions.changeTrackSize(trackSize);
        this.store.dispatch(action);
    };

    /**
        * @method getTrackSize 
        * Returns trackSize.
        * @return {PixelVal}
        */
    p.getTrackSize = function () {
        return this.settings.trackSize;
    };

    /**
        * @method setThumbSize
        * Sets thumbSize
        * @param {PixelVal} thumbSize
        */
    p.setThumbSize = function (thumbSize) {
        this.settings.thumbSize = thumbSize;
        var action = XYJoystickActions.changeThumbSize(thumbSize);
        this.store.dispatch(action);
    };

    /**
        * @method getThumbSize 
        * Returns thumbSize.
        * @return {PixelVal}
        */
    p.getThumbSize = function () {
        return this.settings.thumbSize;
    };

    /**
        * @method setDecimalPlaces
        * Sets decimalPlaces
        * @param {UInteger} decimalPlaces
        */
    p.setDecimalPlaces = function (decimalPlaces) {
        this.settings.decimalPlaces = decimalPlaces;
    };

    /**
        * @method getDecimalPlaces 
        * Returns decimalPlaces.
        * @return {UInteger}
        */
    p.getDecimalPlaces = function () {
        return this.settings.decimalPlaces;
    };

    /**
        * @method setImage
        * Sets image
        * @iatStudioExposed
        * @param {ImagePath} image
        */
    p.setImage = function (image) {
        this.settings.image = image;
        var action = XYJoystickActions.changeThumbImage(image);
        this.store.dispatch(action);
    };

    /**
        * @method getImage 
        * Returns image.
        * @return {ImagePath}
        */
    p.getImage = function () {
        return this.settings.image;
    };

    /**
        * @method LockYAxis
        * If true, locks the YAxis
        * @iatStudioExposed
        * @param {Boolean} value
        */
    p.LockYAxis = function (value) {
        this.settings.lockYAxis = value;
        this.lockAxis();
    };

    /**
        * @method LockXAxis
        * If true, locks the XAxis
        * @iatStudioExposed
        * @param {Boolean} value
        */
    p.LockXAxis = function (value) {
        this.settings.lockXAxis = value;
        this.lockAxis();
    };

    p.updateValues = function () {
        var action = XYJoystickActions.updateValue([this.settings.xValue, this.settings.yValue]);
        this.store.dispatch(action);
    };

    p.lockAxis = function () {
        var action = XYJoystickActions.lockTrack([this.settings.lockXAxis, this.settings.lockYAxis]);
        this.store.dispatch(action);
    };

    //WORKAROUND FOR EDITORHANDLING
    p._setHeight = function (h) {
        SuperClass.prototype._setHeight.apply(this, arguments);
        //this.settings.size = this.settings.size ? this.settings.size : h;
        
        var action = XYJoystickActions.changeHeight(h);
        this.store.dispatch(action);
    };

    p._setWidth = function (w) {
        SuperClass.prototype._setWidth.apply(this, arguments);
        //this.settings.size = this.settings.size ? this.settings.size : w;
        
        var action = XYJoystickActions.changeWidth(w);
        this.store.dispatch(action);
    };

    //UPDATING DATA ON PLC
    p.sendXValueChange = function () {
        var state = this.store.getState();
        this.settings.xValue = Number(state.numeric.value[0].toFixed(this.getDecimalPlaces()));
        this.sendValueChange({ xValue: this.settings.xValue });

        this.triggerXValueChangedThrottled();
    };

    p.sendYValueChange = function () {
        var state = this.store.getState();
        this.settings.yValue = Number(state.numeric.value[1].toFixed(this.getDecimalPlaces()));
        this.sendValueChange({ yValue: this.settings.yValue });

        this.triggerYValueChangedThrottled();
    };

    p.triggerXValueChangedEvent = function () {
        /**
        * @event XValueChanged
        * @iatStudioExposed
        * Fired when xValue changes.
        * @param {Number} value
        */
        var ev = this.createEvent('XValueChanged', { value: this.settings.xValue });
        ev.dispatch();
    };

    p.triggerYValueChangedEvent = function () {
        /**
        * @event YValueChanged
        * @iatStudioExposed
        * Fired when yValue changes.
        * @param {Number} value
        */
        var ev = this.createEvent('YValueChanged', { value: this.settings.yValue });
        ev.dispatch();
    };

    //EVENTS
    p.triggerMouseDownEvent = function (e) {
        /**
        * @event MouseDown
        * @iatStudioExposed
        * Fired when mouseDown is triggered.
        * @param {String} horizontalPos horizontal position of mouse in pixel i.e '10px'
        * @param {String} verticalPos vertical position of mouse in pixel i.e '10px'
        */
        var ev = this.createMouseEvent('MouseDown', {}, e);
        ev.dispatch();
    };

    p.triggerMouseUpEvent = function (e) {
        /**
        * @event MouseUp
        * @iatStudioExposed
        * Fired when mouseUp is triggered.
        * @param {String} horizontalPos horizontal position of mouse in pixel i.e '10px'
        * @param {String} verticalPos vertical position of mouse in pixel i.e '10px'
        */
        var ev = this.createMouseEvent('MouseUp', {}, e);
        ev.dispatch();
    };

    //FUNCTIONS FOR DISPOSING AND CONTENTCACHING
    p.updateVisibility = function (initial) {
        SuperClass.prototype.updateVisibility.apply(this, arguments);
        if (this.store !== undefined) {
            var action = XYJoystickActions.changeVisible(this.isVisible());
            this.store.dispatch(action);
        }
    };

    p._enableHandler = function () {
        SuperClass.prototype._enableHandler.apply(this, arguments);
        var action = XYJoystickActions.changeEnable(this.isEnabled());
        this.store.dispatch(action);
    };

    p.setEditable = function (editable, metaData) {
        UtilsEditableBinding.handleEditable(editable, metaData, this, ['xValue', 'yValue']);
    };

    p.suspend = function () {
        if (this.store !== undefined) {
            //Set the status to innactive
            var action = XYJoystickActions.changeActive(false);
            this.store.dispatch(action);
        }
        this.observer.suspend();
        this.removeListeners();
        SuperClass.prototype.suspend.apply(this, arguments);
    };

    p.wake = function () {
        if (this.store !== undefined) {
            //Set the status to active
            var action = XYJoystickActions.changeActive(true);
            this.store.dispatch(action);
        }
        this.addListeners();
        SuperClass.prototype.wake.apply(this, arguments);
    };

    p.dispose = function () {
        this.observer.dispose();
        this.observer = undefined;
        this.View.dispose();
        this.removeListeners();
        this.triggerXValueChangedThrottled.cancel();
        this.triggerYValueChangedThrottled.cancel();
        SuperClass.prototype.dispose.apply(this, arguments);
    };

    p.themeChange = function () {
        var action = XYJoystickActions.themeChange();
        this.store.dispatch(action);
    };

    p.redrawView = function () {
        if (this.View && this.isVisible()) {
            this.View.render();
        }
        
    };
    p._stylePropsChanged = function () {
        if (this.View) {
            this.View.render();
        }
    };
    p._visibleHandler = function () {
        SuperClass.prototype._visibleHandler.apply(this, arguments);
        this.redrawView();
    };

    function reDrawListener(e) {
        if (e.detail.contentId === this.getParentContentId()) {
            this.redrawView();
        }
    }

    /**
        * @method setStyle
        * Sets a predefined style for the widget
        * @iatStudioExposed
        * @param {StyleReference} value
        */
    p.setStyle = function (value) {
        SuperClass.prototype.setStyle.apply(this, arguments);
        var action = XYJoystickActions.styleChange(value);
        this.store.dispatch(action);
    };

    p.addListeners = function () {
        brease.bodyEl.on(BreaseEvent.THEME_CHANGED, this._bind('themeChange'));
        if (isNaN(this.settings.height) || isNaN(this.settings.width)) {
            brease.bodyEl.on(BreaseEvent.FRAGMENT_SHOW, this._bind(reDrawListener));
        }
    };

    p.removeListeners = function () {
        brease.bodyEl.off(BreaseEvent.THEME_CHANGED, this._bind('themeChange'));
        brease.bodyEl.off(BreaseEvent.FRAGMENT_SHOW, this._bind(reDrawListener));
    };

    // override method called in BaseWidget.init
    p._initEditor = function () {
        var widget = this;
        require(['widgets/brease/common/libs/EditorHandlesSquare'], function (EditorHandles) {
            var editorHandles = new EditorHandles(widget);
            editorHandles.onResize(function (widget) {
                widget._setWidth(widget.settings.width);
                widget._setHeight(widget.settings.height);
            });
                
            widget.getHandles = function () {
                return editorHandles.getHandles();
            };
            widget.designer.getSelectionDecoratables = function () {
                return editorHandles.getSelectionDecoratables();
            };
            widget.designer.isSquare = function () {
                return true;
            };
            widget.dispatchEvent(new CustomEvent(BreaseEvent.WIDGET_EDITOR_IF_READY, { bubbles: true }));
            widget.observer.init();
        });
        
        this.elem.addEventListener(BreaseEvent.WIDGET_STYLE_PROPERTIES_CHANGED, this._bind('_stylePropsChanged'));
    };
    function _stopEventPropagation(e) {
        if (!brease.config.editMode && this.isEnabled()) {
            e.stopPropagation();
        }
    }
    return contentActivatedDependency.decorate(dragAndDropCapability.decorate(WidgetClass, false), true);

});
