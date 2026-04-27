define([
    'widgets/brease/common/libs/redux/reducers/Status/StatusActions',
    'widgets/brease/common/libs/redux/reducers/Size/SizeActions',
    'widgets/brease/common/libs/redux/reducers/Numeric/NumericActions',
    'widgets/brease/common/libs/redux/reducers/Thumb/ThumbActions',
    'widgets/brease/common/libs/redux/reducers/Track/TrackActions',
    'widgets/brease/common/libs/redux/reducers/Style/StyleActions'
], function (
    StatusActions, SizeActions, NumericActions, 
    ThumbActions, TrackActions, StyleActions
) {

    'use strict';

    var XYJoystickActions = _.assign({}, StatusActions, SizeActions, NumericActions, ThumbActions, TrackActions, StyleActions);

    return XYJoystickActions;

});
