import { StyleSheet } from 'react-native';

export default StyleSheet.create({
    imageBackground: {
      flex: 1,
      resizeMode: 'cover',
    },
    container: {
        flex: 1,
    },
    logoBlock: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        padding: 18,
    },
    logoText: {
        fontSize: 50,
        color: "black",
        textAlign: 'center',
        fontWeight: 'bold',
    },
    buttonBlock: {
        padding: 18,
        alignItems: 'center',
    },
})