import React, { useState } from 'react';
import { StyleSheet, View, Text, Image, TouchableHighlight, TouchableOpacity, Alert, ActivityIndicator, Dimensions } from 'react-native';
import { Rating } from 'react-native-ratings';
import firestore from '@react-native-firebase/firestore';

export default function RattingPopup({ game, closeAction }) {
    const [isLoading, setIsLoading] = useState(false);
    const [rattingValue, setRattingValue] = useState(0);

    const sendRatting = (_rattingValue) => {
        if (isLoading) { return }
        setIsLoading(true)
        const newScores = [...game.score, _rattingValue]
        firestore()
            .doc(game.gameReference)
            .update({
                score: newScores,
            })
            .then(() => {
                setIsLoading(false)
                closeAction()
            })
            .catch(error => {
                setIsLoading(false)
                closeAction()
                Alert.alert("Error", error.toString());
            });
    }

    const onPressCloseIfCan = () => {
        if (!isLoading) {
            closeAction()
        }
    }

    return (
        <TouchableOpacity activeOpacity={1} onPress={onPressCloseIfCan} style={styles.componentView}>
            <View style={styles.popupView}>
                <Rating
                    showRating
                    fractions={0}
                    startingValue={0}
                    onFinishRating={setRattingValue}
                    style={styles.ratting}/>
                <View style={styles.buttonBlock}>
                    <TouchableHighlight 
                        style={{ ...styles.buttonContainer, borderRightWidth: 1, }} 
                        onPress={onPressCloseIfCan}>
                        <Text>{"CANCEL"}</Text>
                    </TouchableHighlight>
                    <TouchableHighlight 
                        style={styles.buttonContainer} 
                        onPress={() => sendRatting(rattingValue)}>
                        {
                            isLoading ?
                            <ActivityIndicator color={"#000"} type={"large"} style={styles.loadingImage} />
                            :
                            <Text>{"SEND"}</Text>
                        }
                    </TouchableHighlight>
                </View>
            </View>
        </TouchableOpacity>
    )
}

const styles = StyleSheet.create({
    componentView: {
        alignItems: 'center',
        justifyContent: 'center',
        width: '100%',
        position: 'absolute',
        height: '100%',
        backgroundColor: 'rgba(0,0,0,0.3)',
    },
    popupView: {
        backgroundColor: '#FAFAFA',
        borderRadius: 4,
    },
    ratting: {
        padding: 24,
    },
    buttonBlock: {
        flexDirection: 'row',
        paddingTop: 12,
    },
    buttonContainer: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        height: 40,
        borderColor: "#DDD",
        borderTopWidth: 1,
    },
    loadingImage: {
        position: 'absolute',
    },
});