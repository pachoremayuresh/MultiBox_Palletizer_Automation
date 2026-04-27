define(function () {

    'use strict';

    var InitState = {};

    InitState.calculateInitState = function (settings, enabled, visible) {

        var initState = {};

        initState.status = {
            enabled: enabled,
            visible: visible,
            active: true
        };

        initState.size = {
            height: settings.height,
            width: settings.width
        };

        initState.numeric = {
            value: [settings.xValue, settings.yValue]
        };

        initState.track = {
            trackSize: parseInt(settings.trackSize, 10),
            trackLocked: [settings.lockXAxis, settings.lockYAxis]
        };

        initState.thumb = {
            thumbSize: parseInt(settings.thumbSize, 10),
            thumbImage: settings.image
        };

        initState.style = {
            style: settings.style
        };

        return initState;
    };

    return InitState;

});
