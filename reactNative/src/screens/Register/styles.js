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
        flexDirection: 'row'
    },
    logoText: {
        fontSize: 35,
        color: "#666",
        textAlign: 'center',
        fontWeight: 'bold',
        flex: 3,
    },
    logoImage: {
        flex: 5,
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
})