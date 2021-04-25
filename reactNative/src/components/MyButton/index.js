import React from 'react'
import { Text, TouchableOpacity } from 'react-native'

import styles from './styles'

// Adicionar action

export default MyButton = ({onPress, title}) => {
    return (
        <TouchableOpacity 
            style={styles.container}
            onPress={onPress}>
                <Text style={styles.text}>{title}</Text>
        </TouchableOpacity>
    )
}

TouchableOpacity.defaultProps = { activeOpacity: 0.75}