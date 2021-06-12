import React from 'react';
import { StyleSheet, View, Text, TouchableHighlight, ActivityIndicator, Image } from 'react-native';

function ButtonContent({isLoading, text, icon}) {
    if(isLoading) {
        return (
            <View>
                <ActivityIndicator color="#FFFFFF" />
            </View>
        )
    }
    return (
        <View style={styles.buttonView}>
            { icon ? <Image source={icon} style={styles.image} /> : null }
            <Text style={styles.textButton}>{text}</Text>
        </View>
    )
}

export default function Button({text, onTap, isLoading, icon, textStyles, contentStyles}) {
    return (
        <TouchableHighlight
            style={{...styles.button, ...contentStyles}}
            onPress={isLoading ? () => null : onTap}>
             <ButtonContent 
                isLoading={isLoading} 
                text={text}
                icon={icon}
             />
        </TouchableHighlight>
    )
}

const styles = StyleSheet.create({
    button: {
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#050566',
        marginVertical: 8,
        borderRadius: 4,
        height: 50,
        width: '100%',
    },
    buttonView: {
        flexDirection: 'row',
        width: '100%',
        justifyContent: 'center',
        alignItems: 'center',
    },
    textButton: {
        color: "white",
        fontSize: 15,
    },
    image: {
        height: 30,
        width: 30,
        position: 'absolute',
        right: 0,
        marginRight: 18,
        tintColor: 'white',
    },
});