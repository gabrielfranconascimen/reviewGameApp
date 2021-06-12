import React, { useState, useEffect } from 'react';
import { useDispatch } from 'react-redux'
import { SafeAreaView, View, Text, Image, TextInput, Alert } from 'react-native';
import { GoogleSignin, GoogleSigninButton, statusCodes } from '@react-native-google-signin/google-signin';
import auth from '@react-native-firebase/auth';
import firestore from '@react-native-firebase/firestore';

import Button from '../../components/button.component';
import styles from './styles.js';

export default function Register() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [isLoading, setIsLoading] = useState(false);
    const dispatch = useDispatch();
    const ref = firestore().collection('user');

    const handlerGoogleSignIn = async () => {
        GoogleSignin.configure({
            webClientId: "766209976148-81qsstln9f7m7hrgrusttmmgn0huhj9p.apps.googleusercontent.com",
            androidClientId: '766209976148-fbr9akpme2l2hqq9fbate96849v5pbk2.apps.googleusercontent.com',
            offlineAccess: false,
        })
        try {
            setIsLoading(true);
            await GoogleSignin.hasPlayServices();
            const userInfo = await GoogleSignin.signIn();
            const googleCredential = auth.GoogleAuthProvider.credential(userInfo.idToken);
            auth().signInWithCredential(googleCredential).then(() => {
                setIsLoading(false);
            })
            .catch(error => {
                setIsLoading(false);
                Alert.alert("Error", error.toString())
            })
        } catch (error) {
            if (error.code === statusCodes.SIGN_IN_CANCELLED) {
                console.log(error)
            } else {
                Alert.alert("Error", error.toString())
            }
            setIsLoading(false);
        }
    };

    const handlerSignIn = async () => {
        if(email.length === 0 || password.length === 0) {
            Alert.alert("Atention", "Fill in all fields to continue!")
            return 
        }

        setIsLoading(true);
        auth().signInWithEmailAndPassword(email, password)
        .then(() => {
            setIsLoading(false);
        })
        .catch(error => {
            setIsLoading(false);
            Alert.alert("Error", error.toString())
        });
    };

    const onAuthStateChanged = (user) => {
        if(user) {
            const userUID = user.uid
            ref.doc(userUID).get()
            .then(result => {
                if(result.exists) {
                    dispatch({ type: 'SET_USER', payload: user });
                } else {
                    ref.doc(userUID)
                    .set({
                        name: user.displayName,
                        email: user.email,
                        })
                    .then(() => {
                        dispatch({ type: 'SET_USER', payload: user });
                    }).catch(console.log);
                }
            }).catch(console.log);
        }
    };

    useEffect(() => {
        const subscriber = auth().onAuthStateChanged(onAuthStateChanged);
        return subscriber;
    }, []);

    return(
        <SafeAreaView style={styles.container}>
            <View style={styles.logoBlock}>
                <Text style={styles.logoText}>{"Review Game App"}</Text>
                <Image style={styles.logoImage} source={require('../../assets/logo/app-logo.png')}/>
            </View>
            <View style={styles.formBlock}>
                <TextInput 
                    style={styles.textInput}
                    autoCapitalize={'none'}
                    autoCorrect={false}
                    autoCompleteType={"email"}
                    keyboardType={"email-address"}
                    placeholder={"E-mail"}
                    placeholderTextColor={"white"}
                    onChangeText={text => setEmail(text)}
                    value={email}
                    />
                <TextInput 
                    style={styles.textInput}
                    autoCapitalize={'none'}
                    autoCorrect={false}
                    autoCompleteType={"password"}
                    placeholder={"Password"}
                    secureTextEntry={true}
                    placeholderTextColor={"white"}
                    onChangeText={text => setPassword(text)}
                    value={password}
                    />
                <Button 
                    text={"Submit"}
                    onTap={handlerSignIn}
                    isLoading={isLoading}
                />
                <Text style={styles.orText}>{"Or"}</Text>
                <GoogleSigninButton
                    style={styles.googleButton}
                    size={GoogleSigninButton.Size.Wide}
                    onPress={handlerGoogleSignIn}
                    disabled={isLoading}
                />
            </View>
        </SafeAreaView>
    )
}