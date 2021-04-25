import { StyleSheet } from 'react-native'

import { colors, dimens } from '../../styles'

const style = StyleSheet.create({
    container: {
        display: "flex",
        flex: 2,
        alignItems: 'center',
        marginTop: dimens.largeMargin
    },
    image: {
        flex: 1,
        width: '100%',
        flexDirection: 'column',
        marginTop: 8,
        marginBottom: 8,
        resizeMode: 'contain'
    },
    text: {
        flex: 1,
        color: colors.gray,
        fontSize: dimens.mediumText,
    }
})

export default style