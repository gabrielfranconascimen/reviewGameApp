import React from 'react'
import { TouchableOpacity, Text, Image } from 'react-native'

import styles from './styles'

export default GameItem = ({onPress, name, uri, height}) => {
    return (
        <TouchableOpacity onPress={onPress} style={styles.container}>
            <Image source={{uri: uri }} style={[styles.image, {height:height}]}/>
            <Text style={styles.text}>{ name }</Text>
        </TouchableOpacity>
    )
}