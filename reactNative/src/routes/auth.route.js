import React from 'react';
import Login from '../screens/Login';
import Register from '../screens/Register';
import Welcome from '../screens/Welcome';

export default function AuthRoute({ Stack }) {
    return (
        <Stack.Navigator
            screenOptions={{
                headerTitleStyle: {
                    fontSize: 16,
                },
                headerStyle: {
                    backgroundColor: '#4331B5',
                },
                headerTintColor: 'white',
                headerBackTitle: " ",
            }}
        >
            <Stack.Screen name="Welcome" options={{ headerShown: false }} component={Welcome} />
            <Stack.Screen name="Login" options={{ headerTitle: "Log in" }} component={Login} />
            <Stack.Screen name="Register" options={{ headerTitle: "Sign up" }} component={Register} />
        </Stack.Navigator>
    )
}