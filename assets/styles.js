import {RFValue} from 'react-native-responsive-fontsize';
import colors from '@assets/colors';
import dimens from '@assets/dimens';

const baseText = {
  color: colors.black2,
};

export default {
  text: {
    size: {
      extraSmall: RFValue(11),
      small: RFValue(12),
      medium: RFValue(14),
      large: RFValue(16),
      extraLarge: RFValue(20),
      superLarge: RFValue(32),
    },
    heading1: {
      ...baseText,
      fontSize: RFValue(20),
      fontWeight: 'bold',
    },
    heading2: {
      ...baseText,
      fontSize: RFValue(16),
      fontWeight: 'bold',
    },
    heading3: {
      ...baseText,
      fontSize: RFValue(14),
      fontWeight: 'bold',
    },
    heading4: {
      ...baseText,
      fontSize: RFValue(12),
      fontWeight: 'bold',
    },
    heading5: {
      ...baseText,
      fontSize: RFValue(10),
      fontWeight: 'bold',
    },
    regular1: {
      ...baseText,
      fontSize: RFValue(20),
    },
    regular2: {
      ...baseText,
      fontSize: RFValue(16),
    },
    regular3: {
      ...baseText,
      fontSize: RFValue(14),
    },
    regular4: {
      ...baseText,
      fontSize: RFValue(12),
    },
    regular5: {
      ...baseText,
      fontSize: RFValue(10),
    },
    paragraph: {
      ...baseText,
      fontSize: RFValue(16),
      opacity: 0.8,
    },
    label: {
      ...baseText,
      fontSize: RFValue(14),
      fontWeight: 'bold',
    },
    placeholder: {
      ...baseText,
      fontSize: RFValue(12),
    },
    value: {
      ...baseText,
      fontSize: RFValue(14),
    },
    strikeThrough: {
      textDecorationLine: 'line-through',
      textDecorationStyle: 'solid',
    },
    alignCenter: {
      textAlign: 'center',
    },
  },
  shadow: {
    normal: {
      shadowColor: '#000',
      shadowOffset: {
        width: 0,
        height: 0,
      },
      shadowOpacity: 0.15,
      shadowRadius: 4,
      elevation: 2,
    },
    large: {
      shadowColor: '#000',
      shadowOffset: {
        width: 0,
        height: 0,
      },
      shadowOpacity: 0.3,
      shadowRadius: 6,
      elevation: 5,
    },
  },
  component: {
    handler: {
      backgroundColor: colors.lightGrey,
      width: 36,
      height: 6,
      borderRadius: 99999,
      marginTop: dimens.spacerNormal,
    },
  },
  layout: {
    blackOverlay: {
      width: '100%',
      height: '100%',
      backgroundColor: colors.blackTransparent,
      zIndex: 0,
    },
    hide: {
      opacity: 0,
    },
    containerCentered: {
      flex: 1,
      alignItems: 'center',
      justifyContent: 'center',
    },
    containerDimensionForced: {
      width: '100%',
      height: '100%',
      alignItems: 'center',
      justifyContent: 'center',
    },
  },
};
