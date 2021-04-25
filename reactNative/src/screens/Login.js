import React, { Component } from 'react'
import { SafeAreaView, StyleSheet } from 'react-native'
import LoginButton from '../components/LoginButton'


class Login extends Component {

    render() {
        return(
            <SafeAreaView style={style.container}>
                <LoginButton title="LOG IN"/>
                <LoginButton title="SIGN IN"/>
            </SafeAreaView>
        )
    }
}


const style = StyleSheet.create({
    container: {
        flex: 2,
    }
})