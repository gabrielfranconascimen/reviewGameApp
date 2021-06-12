import React, { useState, useEffect } from 'react';
import { SafeAreaView, View, Text, ImageBackground } from 'react-native';

import Button from '../../components/button.component';
import styles from './styles.js';

export default function Welcome({ navigation }) {

    return(
        <ImageBackground source={require('../../assets/background/background-welcome.png')} blurRadius={3} style={styles.imageBackground}>
            <SafeAreaView style={styles.container}>
                <View style={styles.logoBlock}>
                    <Text style={styles.logoText}>{"Welcome to the Review Game App"}</Text>
                </View>
                <View style={styles.buttonBlock}>
                    <Button 
                        text={"LOG IN"}
                        onTap={() => navigation.push('Login')}
                    />
                    <Button 
                        text={"SIGN UP"}
                        onTap={() => navigation.push('Register')}
                    />
                </View>
            </SafeAreaView>
        </ImageBackground>
    )
}

