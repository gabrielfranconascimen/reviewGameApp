/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import type {Node} from 'react';
import { Platform, StatusBar } from 'react-native';
import KeyboardManager from 'react-native-keyboard-manager';
import { Provider } from 'react-redux';
import { store, persistor } from './src/reducers';
import { PersistGate } from 'redux-persist/integration/react'

import LoadingScreen from './src/screens/Loading';
import Routes from './src/routes';

const App: () => Node = () => {
  if(Platform.OS === 'ios') {
    KeyboardManager.setEnable(true);
    KeyboardManager.setToolbarDoneBarButtonItemText("Pronto");
    KeyboardManager.setToolbarPreviousNextButtonEnable(true);
  }
  return (
    <Provider store={store}>
      <PersistGate loading={<LoadingScreen />} persistor={persistor}>
        <StatusBar barStyle={"light-content"} />
        <Routes />
      </PersistGate>
    </Provider>
  );
};

export default App;
