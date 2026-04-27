define([
    'brease/enum/Enum'
], function (
    Enum
) {

    'use strict';

    /**
     * @class widgets.brease.XYJoystick.config.Config
     * @extends core.javascript.Object
     * @override widgets.brease.XYJoystick
     */

    /**
     * @cfg {Number} xValue=0
     * @iatStudioExposed
     * @iatCategory Data
     * @bindable
     * @readonly
     * @not_projectable
     * @editableBinding
     * Bindable Value (ReadOnly) of XAxis.  
     */

    /**
     * @cfg {Number} yValue=0
     * @iatStudioExposed
     * @iatCategory Data
     * @bindable
     * @readonly
     * @not_projectable
     * @editableBinding
     * Bindable Value (ReadOnly) of YAxis.  
     */

    /**
     * @cfg {UInteger} decimalPlaces=2
     * @iatStudioExposed
     * @iatCategory Data
     * Defines the decimalPlaces of the Values.  
     */

    /**
     * @cfg {PixelVal} trackSize='7px'
     * @iatStudioExposed
     * @iatCategory Appearance
     * Defines the Track size.  
     */

    /**
     * @cfg {PixelVal} thumbSize='50px'
     * @iatStudioExposed
     * @iatCategory Appearance
     * Defines the Size of the Thumb.  
     */

    /**
     * @cfg {ImagePath} image=''
     * @iatStudioExposed
     * @bindable
     * @iatCategory Appearance
     * Defines the image on the Thumb.  
     */

    return {
        xValue: 0,
        yValue: 0,
        trackSize: '7px',
        thumbSize: '50px',
        image: '',
        decimalPlaces: 2,
        lockXAxis: false,
        lockYAxis: false
    };

});
