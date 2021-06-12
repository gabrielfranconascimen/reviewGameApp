import React from 'react';
import { Image, TouchableHighlight } from 'react-native';
import { useDispatch } from 'react-redux'
import Home from '../screens/Home';
import Button from '../components/button.component';
import GameDetail from '../screens/GameDetail';
import auth from '@react-native-firebase/auth';

export default function MainRoute({ Stack }) {
    const dispatch = useDispatch();

    return (
        <Stack.Navigator
            screenOptions={{
                headerTitleStyle: {
                    fontSize: 25,
                },
                headerStyle: {
                    backgroundColor: '#2F0781',
                },
                headerTintColor: 'white',
                headerBackTitle: " ",
            }}>
            <Stack.Screen 
                name="Home" 
                options={({ navigation }) => ({ 
                    headerTitle: "Review Game App",
                    headerRight: () =>  <Button 
                        text={"Logout"}
                        onTap={() => {
                            auth()
                            .signOut()
                            .then(() => {
                                dispatch({ type: "CLEAR_USER" })
                            })
                        }}
                        contentStyles={{ backgroundColor: "transparent", marginHorizontal: 4}}/>
                })} 
                component={Home} />
            <Stack.Screen 
                options={({ route }) => ({
                    headerTitle: route.params.title,
                    headerTitleStyle: {
                        fontSize: 20,
                    },
                })}
                name="GameDetail"
                component={GameDetail}
                />
        </Stack.Navigator>
    )
}