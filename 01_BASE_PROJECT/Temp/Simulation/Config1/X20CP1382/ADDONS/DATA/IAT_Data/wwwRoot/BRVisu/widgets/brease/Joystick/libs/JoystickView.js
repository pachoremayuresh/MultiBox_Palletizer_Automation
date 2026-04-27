define([
    'widgets/brease/XYJoystick/libs/view/XYJoystickView/XYJoystickView',
    'brease/core/Utils'
], function (SuperClass, Utils) {

    'use strict';

    var JoystickView = SuperClass.extend(function JoystickView(store, parent, widget) {
            this.el = parent;
            this.store = store;
            this.widget = widget;
            if (this.containerEl === undefined) {
                var widgetId = this.el[0].id;
                this.containerEl = $('<div id="' + widgetId + '_squareContainer" class="squareContainer" style="box-sizing: border-box;"></div>');
                this.el[0].appendChild(this.containerEl[0]);
            }
            SuperClass.apply(this, arguments);

        }, null),
        p = JoystickView.prototype;
    p.render = function () {
        var squareContainerEl;
        this.el.addClass('breaseWidget JoystickView');
        squareContainerEl = this.containerEl;
        this.border = {
            top: parseInt((squareContainerEl).css('border-top-width'), 10),
            right: parseInt((squareContainerEl).css('border-right-width'), 10),
            bottom: parseInt((squareContainerEl).css('border-bottom-width'), 10),
            left: parseInt((squareContainerEl).css('border-left-width'), 10)
        };
        SuperClass.prototype.render.apply(this, arguments);
       
    };

    p.calculateThumbProps = function (state) {
        var crossSliderView = this;
        return {
            left: (this.shiftingDimensions.x) + (this.scaleX(state.numeric.value[0]) - state.thumb.thumbSize / 2),
            top: (this.shiftingDimensions.y) + (this.scaleY(state.numeric.value[1]) - state.thumb.thumbSize / 2),    
            thumbSize: state.thumb.thumbSize,
            thumbImage: state.thumb.thumbImage,
            onMouseMove: function (e) {               
                crossSliderView.updateXValue(e);
                crossSliderView.updateYValue(e);
                e.stopImmediatePropagation();
            },
            onMouseDown: function (e) {
                crossSliderView.thumbSelected(e);
                e.stopImmediatePropagation();
            },
            onMouseUp: function (e) {
                crossSliderView.thumbUnselected(e);
                e.stopImmediatePropagation();
            },
            selected: state.thumb.thumbSelected,
            enabled: state.status.enabled
        };
    };
    p.calculateTrackYProps = function (state) {
        return {
            height: this._getSize() - this.border.top - this.border.bottom,
            width: state.track.trackSize,
            top: (this.widgetHeight - this._getSize()) * 0.5,
            left: ((this.widgetWidth - this.border.left - this.border.right - state.track.trackSize) / 2),
            size: this._getSize(),
            additionalClass: 'TrackYView',
            arrowClasses: ['top', 'bottom'],
            widgetId: this.el[0].id,
            borderWidth: this.border
        };
    };

    p.calculateTrackXProps = function (state) {
        return {
            height: state.track.trackSize,
            width: this._getSize() - this.border.left - this.border.right,
            left: (this.widgetWidth - this._getSize()) * 0.5,
            top: ((this.widgetHeight - this.border.top - this.border.bottom - state.track.trackSize) / 2),
            size: this._getSize(),
            additionalClass: 'TrackXView',
            arrowClasses: ['left', 'right'],
            xTrackIsSet: true,
            widgetId: this.el[0].id,
            borderWidth: this.border
        };
    };

    p.getXYValues = function () {
        var x = this.scaleX.invert(this.x),
            y = this.scaleY.invert(this.y),
            r = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2)),
            array;

        if (r < 1) {
            array = [x, y];
        } else {
            if (x === 0) {
                array = [0, 1];
            } if (y === 0) {
                array = [(x === 0) ? x : x / Math.abs(x), 0];
            } else { // r = 1
                var f = x / y,
                    signX = (x === 0) ? 1 : x / Math.abs(x),
                    signY = (y === 0) ? 1 : y / Math.abs(y),
                    ny = Math.sqrt(1 / (Math.pow(f, 2) + 1)),
                    nx = f * ny;
                array = [signX * Math.abs(nx), signY * Math.abs(ny)];
            }
        }
        
        return array;
    };

    return JoystickView;

});
