import { BlurView } from '@react-native-community/blur'
import React, { Component } from 'react'
import { Button, View } from 'react-native'
import MyRatingStar from '../../../components/MyRatingStar'

import styles from './styles'

class RatingDialog extends Component {

    render() {
        return (
            <View style={styles.container} blurType='light' blurRadius={1}>
                <BlurView style={styles.absolute} blurType='light' blurAmount={10}/> 
                <MyRatingStar style={styles.rating}/>
                <View style={styles.viewMargin}/>
                <Button style={styles.button} title="Vote" onPress={this.props.onPress}/>
            </View>
        )
    }
}

export default RatingDialog