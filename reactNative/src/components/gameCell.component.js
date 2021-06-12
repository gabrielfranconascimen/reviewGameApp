import React, { useState, useEffect } from 'react';
import { StyleSheet, View, Text, Image, TouchableHighlight, Alert, ActivityIndicator, Dimensions } from 'react-native';
import storage from '@react-native-firebase/storage';

export default function GameCell({ game, onTap }) {
    const [imageURL, setImageURL] = useState(null);
    const [isLoading, setIsLoading] = useState(false);

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

        fetchImageURL(game.thumbnail)
    }, [])

    return (
        <TouchableHighlight onPress={onTap}>
            <View style={styles.componentView}>
                <Image 
                    onLoadStart={() => setIsLoading(true)}
                    onLoad={() => setIsLoading(false)}
                    source={{ uri: imageURL }} 
                    style={styles.image} />
                { isLoading || !imageURL ? <ActivityIndicator color={"#000"} type={"large"} style={styles.loadingImage} /> : null }
                <Text style={styles.text}>{game.name}</Text>
            </View>
        </TouchableHighlight>
    )
}

const halfWidthScreen = Dimensions.get('window').width/2

const styles = StyleSheet.create({
    componentView: {
        alignItems: 'center',
        justifyContent: 'center',
        width: halfWidthScreen,
        padding: 16,
    },
    image: {
        width: "100%",
        height: 150,
        resizeMode: 'contain',
    },
    loadingImage: {
        position: 'absolute',
    },
    text: {
        marginTop: 16,
        color: "#666",
        textAlign: 'center',
        fontWeight: 'bold',
    },
});