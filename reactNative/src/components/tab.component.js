import React from 'react';
import { StyleSheet, View, Text, TouchableHighlight } from 'react-native';

function TabItem({text, onTap, isSelected}) {
    const selectedViewStyles = {
        backgroundColor: "#FAFAFA",
    }
    const selectedTextStyles = {
        color: "#050566",
        fontWeight: 'bold',
    }
    return (
        <TouchableHighlight style={styles.tabItemButton} onPress={isSelected ? () => null : onTap}>
            <View style={{...styles.tabItemView, ...(isSelected ? selectedViewStyles : {})}}>
                <Text style={{...styles.text, ...(isSelected ? selectedTextStyles : {})}}>{text}</Text>
            </View>
        </TouchableHighlight>
    )
}

export default function TabComponent({ items }) {
    return (
        <View
            style={styles.tabComponentView}>
             {
                 items.map(item => <TabItem key={item.text} {...item} />)
             }
        </View>
    )
}

const styles = StyleSheet.create({
    tabComponentView: {
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#050566',
        height: 50,
        width: '100%',
        flexDirection: 'row',
    },
    tabItemButton: {
        flex: 1,
    },
    tabItemView: {
        justifyContent: 'center',
        alignItems: 'center',
        flex: 1,
    },
    text: {
        color: "white",
        fontSize: 15,
    },
});