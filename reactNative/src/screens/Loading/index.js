import * as React from 'react';

import { SafeAreaView, Image, ActivityIndicator, StyleSheet, Dimensions } from 'react-native';

export default function LoadingScreen() {
    return (
        <SafeAreaView style={styles.container}>
            <ActivityIndicator size="large" color="white" />
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: { 
        flex: 1, 
        alignItems: 'center', 
        justifyContent: 'center', 
        backgroundColor: '#808080',
    }
});