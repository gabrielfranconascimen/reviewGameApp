import React, { useState, useEffect } from 'react';
import { useDispatch } from 'react-redux'
import { SafeAreaView, View, Text, Image, TextInput, Alert } from 'react-native';
import auth from '@react-native-firebase/auth';
import firestore from '@react-native-firebase/firestore';

import Button from '../../components/button.component';
import styles from './styles.js';

export default function Register() {
    const [name, setName] = useState("");
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [confirmPassword, setConfirmPassword] = useState("");
    const dispatch = useDispatch();
    const [isLoading, setIsLoading] = useState(false);
    const ref = firestore().collection('user');

    const handlerSignUp = async () => {
        if(name.length === 0 || email.length === 0 || password.length === 0 || confirmPassword.length === 0) {
            Alert.alert("Atention", "Fill in all fields to continue!")
            return 
        } else if (password != confirmPassword) {
            Alert.alert("Atention", "Passwords and confirm password do not match!")
            return 
        }

        setIsLoading(true);
        auth().createUserWithEmailAndPassword(email, password)
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
                        name,
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
    }, [name]);

    return(
        <SafeAreaView style={styles.container}>
            <View style={styles.logoBlock}>
                <Image style={styles.logoImage} source={require('../../assets/logo/app-logo.png')}/>
                <Text style={styles.logoText}>{"Review Game App"}</Text>
            </View>
            <View style={styles.formBlock}>
                <TextInput 
                    style={styles.textInput}
                    autoCapitalize={'words'}
                    autoCorrect={false}
                    autoCompleteType={"name"}
                    placeholder={"Name"}
                    placeholderTextColor={"white"}
                    onChangeText={text => setName(text)}
                    value={name}
                    />
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
                <TextInput 
                    style={styles.textInput}
                    autoCapitalize={'none'}
                    autoCorrect={false}
                    autoCompleteType={"password"}
                    placeholder={"Confirm Password"}
                    secureTextEntry={true}
                    placeholderTextColor={"white"}
                    onChangeText={text => setConfirmPassword(text)}
                    value={confirmPassword}
                    />
                <Button 
                    text={"Submit"}
                    onTap={handlerSignUp}
                    isLoading={isLoading}
                />
            </View>
        </SafeAreaView>
    )
}