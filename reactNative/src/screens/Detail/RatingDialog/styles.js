import { StyleSheet } from 'react-native'
import { colors, dimens } from '../../../styles'

const styles = StyleSheet.create({
    container: {
        display:  'flex',
        flex: 2,
        justifyContent: 'center',
        alignItems: 'center'
    },
    viewMargin:{
        flex: 0.1
    },
    rating: {
        flex: 1,
    }, 
    button: {
        flex: 1,
    },
    absolute: {
        position: 'absolute',
        top: 0,
        left: 0,
        bottom: 0,
        right: 0
    }
})

export default styles