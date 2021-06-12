import React, { useState, useEffect } from 'react';
import { SafeAreaView, Image, ActivityIndicator, StyleSheet, View, Dimensions, Alert, Text, Linking, ScrollView } from 'react-native';
import storage from '@react-native-firebase/storage';
import firestore from '@react-native-firebase/firestore';

import Button from '../../components/button.component';
import RattingPopup from '../../components/rattingPopup.component';

export default function GameDetail({ route }) {
    const [imageURL, setImageURL] = useState(null);
    const [isLoading, setIsLoading] = useState(false);
    const [isReviewOpened, setIsReviewOpened] = useState(false);
    const [game, setGame] = useState(route.params.game);

    useEffect(() => {
        const fetchImageURL = async (imagePath) => {
            try {
                setIsLoading(true);
                const incomingGameURL = await storage().ref(imagePath).getDownloadURL();
                setImageURL(incomingGameURL)
                setIsLoading(false);
            } catch(err) {
                setIsLoading(false);
                Alert.alert("Error", err.toString());
            }
        }

        fetchImageURL(game.image)

        return firestore()
            .doc(game.gameReference)
            .onSnapshot(querySnapshot => {
                setGame(querySnapshot.data())
            });
    }, [])

    const scoreAverage = (scores) => {
        const average = scores.reduce((a, b) => a+b, 0)/scores.length
        return average.toFixed(1)
    }

    const openSite = async (url) => {
        const supported = await Linking.canOpenURL(url);
        if(supported) {
            await Linking.openURL(url);
        } else {
            Alert.alert(`Don't know how to open this URL: ${url}`);
        }
    }

    return (
        <>
        <SafeAreaView style={styles.container}>
            <ScrollView style={styles.scrollview}>
                <View style={styles.imageBlock}>
                    <Image 
                        onLoadStart={() => setIsLoading(true)}
                        onLoad={() => setIsLoading(false)}
                        source={{ uri: imageURL }} 
                        style={styles.image} />
                    { isLoading || !imageURL ? <ActivityIndicator color={"#000"} type={"large"} style={styles.loadingImage} /> : null }
                </View>
                <View style={styles.textBlock}>
                    <View style={styles.rattingBlock}>
                        <Text style={styles.rattingText}>{"Ratting: "}<Text style={styles.bold}>{scoreAverage(game.score)}</Text></Text>
                    </View>
                    <Text style={styles.descriptionText}>{game.description}</Text>
                    <Button 
                        text={"REVIEW GAME"} 
                        onTap={() => setIsReviewOpened(true)}/>
                    <Button 
                        text={"VISIT OFFICIAL SITE"} 
                        onTap={() => openSite(game.link)}/>
                </View>
            </ScrollView>
        </SafeAreaView>
        { 
            !isReviewOpened ? null :
            <RattingPopup game={game} closeAction={() => setIsReviewOpened(false)} /> 
        }
        </>
    );
}

const screenWidth = Dimensions.get('window').width

const styles = StyleSheet.create({
    container: { 
        flex: 1, 
        alignItems: 'center', 
        justifyContent: 'center', 
        backgroundColor: '#FAFAFA',
    },
    imageBlock: {
        alignItems: 'center', 
        justifyContent: 'center',
        width: '100%',
    },
    image: {
        width: '100%',
        height: screenWidth*3/5,
    },
    loadingImage: {
        position: 'absolute',
    },
    textBlock: {
        flex: 1,
        padding: 16,
    },
    scrollview: {
        width: '100%',
    },
    rattingBlock: {
        width: '100%',
        flexDirection: 'row-reverse',
    },
    rattingText: {
        fontSize: 20,
    },
    descriptionText: {
        color: "#666",
        fontSize: 15,
        paddingVertical: 16,
    },
    bold: {
        fontWeight: 'bold',
    },
});