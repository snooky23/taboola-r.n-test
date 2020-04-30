import PropTypes from 'prop-types';
import { 
    requireNativeComponent, 
    ViewPropTypes,
    NativeComponent } from 'react-native';

var iface = {
  name: 'RNTaboolaView',
  propTypes: {
     mode: PropTypes.string,
     publisher: PropTypes.string,
     pageType: PropTypes.string,
     pageUrl: PropTypes.string,
     placement: PropTypes.string,
     targetType: PropTypes.string,
     interceptScroll: PropTypes.bool,
     scrollEnabled: PropTypes.bool,
     viewID:PropTypes.string,
    ...ViewPropTypes, // include the default view properties
  },
};

module.exports = requireNativeComponent('RNTaboolaView', iface);



// import {
//     findNodeHandle,
//     NativeModules,
//   } from 'react-native';
// var TaboolaViewManager = NativeModules.TaboolaViewManager;

// export default class TaboolaView extends NativeComponent.RNTaboolaView {
    
//     fetchContent() {
//         TaboolaViewManager.fetchContent(findNodeHandle(this));
//     }
// }