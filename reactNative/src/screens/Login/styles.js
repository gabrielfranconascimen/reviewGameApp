import { StyleSheet } from 'react-native';

export default StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: "#FAFAFA",
    },
    logoBlock: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        padding: 18,
    },
    logoText: {
        fontSize: 50,
        color: "#666",
        textAlign: 'center',
        fontWeight: 'bold',
    },
    logoImage: {
        flex: 1,
        resizeMode: 'contain',
        overflow: 'hidden',
    },
    formBlock: {
        padding: 18,
        alignItems: 'center',
    },
    textInput: {
        height: 50,
        backgroundColor: '#2F0781',
        width: '100%',
        paddingHorizontal: 24,
        marginVertical: 8,
        borderRadius: 4,
        color: 'white',
        fontSize: 15,
    },
    orText: {
        color: "#666",
        textAlign: 'center',
        paddingVertical: 12,
    },
    googleButton: {
        width: '100%',
    },
})