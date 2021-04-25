import {StyleSheet} from 'react-native'
import { colors, dimens } from '../../styles'

const style = StyleSheet.create({
    container: {
        textAlign: 'center',
        borderWidth: 1,
        borderColor: colors.iceBeigeColor,
        borderRadius: 8,
        backgroundColor: colors.primaryBlue,
        margin: 16,
    },
    text: {
        textAlign: 'center',
        padding: dimens.regularMargin,
        color: colors.iceBeigeColor
    }
})

export default style