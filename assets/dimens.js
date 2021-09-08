import {Dimensions} from 'react-native';
import {RFValue} from 'react-native-responsive-fontsize';

const {width, height} = Dimensions.get('screen');

export default {
  navbarHeight: RFValue(60),
  spacerSmall: RFValue(4),
  spacerNormal: RFValue(8),
  spacerLarge: RFValue(16),
  spacerExtraLarge: RFValue(25),
  screenWidth: width,
  screenHeight: height,
  radiusSmall: RFValue(4),
  radiusNormal: RFValue(8),
  radiusLarge: RFValue(16),
  radiusExtraLarge: RFValue(25),
  radiusDoubleExtraLarge: RFValue(40),
  radiusVeryLarge: RFValue(50),
  responsive: RFValue,
};
