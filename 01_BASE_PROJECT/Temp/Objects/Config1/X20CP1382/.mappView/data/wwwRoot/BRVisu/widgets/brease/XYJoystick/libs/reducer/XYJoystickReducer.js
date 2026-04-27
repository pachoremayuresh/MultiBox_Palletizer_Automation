define([
    'widgets/brease/common/libs/redux/reducers/Status/StatusReducer',
    'widgets/brease/common/libs/redux/reducers/Size/SizeReducer',
    'widgets/brease/common/libs/redux/reducers/Numeric/NumericReducer',
    'widgets/brease/common/libs/redux/reducers/Track/TrackReducer',
    'widgets/brease/common/libs/redux/reducers/Thumb/ThumbReducer',
    'widgets/brease/common/libs/redux/reducers/Style/StyleReducer',
    'widgets/brease/common/libs/external/redux'
], function (
    StatusReducer, SizeReducer, NumericReducer, 
    TrackReducer, ThumbReducer, StyleReducer, Redux
) {

    'use strict';

    return Redux.combineReducers({
        status: StatusReducer,
        size: SizeReducer,
        numeric: NumericReducer,
        track: TrackReducer,
        thumb: ThumbReducer,
        style: StyleReducer
    });

});
