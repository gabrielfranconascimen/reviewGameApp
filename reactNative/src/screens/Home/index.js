import React, { useState, useEffect } from 'react';
import { SafeAreaView, Image, ActivityIndicator, RefreshControl, Text, FlatList, View } from 'react-native';
import firestore from '@react-native-firebase/firestore';

import TabComponent from '../../components/tab.component';
import { playstation, nintendoSwitch, xbox, computer } from './consoles';
import GameCell from '../../components/gameCell.component';
import styles from './styles';

export default function Home({ navigation }) {
    const allConsoles = [
        playstation, xbox, nintendoSwitch, computer
    ]
    const [selectedTabID, setSelectedTabID] = useState(allConsoles[0].id);
    const [isLoading, setIsLoading] = useState(false);
    const [pullToRefresh, setPullToRefresh] = useState(false);
    const [games, setGames] = useState([]);
    const ref = firestore().collection('consoles');

    useEffect(() => {
        setGames([])
        return ref.doc(selectedTabID)
        .collection("games")
        .onSnapshot(querySnapshot => {
            var newGames = []; 
            querySnapshot.forEach((doc) => {
                newGames.push(doc.data());
            });
            setGames(newGames)
        });
    }, [selectedTabID, pullToRefresh])

    const tapCardHandler = (game) => {
        navigation.push('GameDetail', { game, title: game.name });
    }

    return (
        <SafeAreaView style={styles.container}>
            <TabComponent items={allConsoles.map(console => ({
                ...console,
                isSelected: selectedTabID == console.id,
                onTap: () => setSelectedTabID(console.id),
            }))} />
            <View style={styles.tabContent}>
            <FlatList 
                data={games}
                ListEmptyComponent={isLoading ? null : <Text style={styles.emptyText}>Empty list</Text>}
                keyExtractor={(item) => item.gameReference}
                numColumns={2}
                refreshControl={
                  <RefreshControl
                      refreshing={isLoading}
                      onRefresh={() => setPullToRefresh(!pullToRefresh)}
                      title="Pull to refresh"
                      tintColor="#000"
                      titleColor="black"
                   />
                }
                renderItem={({ item }) => <GameCell game={item} onTap={() => tapCardHandler(item)} />}
            />
            </View>
        </SafeAreaView>
    );
}