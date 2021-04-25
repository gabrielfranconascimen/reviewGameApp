import React from 'react'
import { Dimensions, FlatList, View } from 'react-native'
import GameItem from '../../components/GameItem'
import SegmentControl from '../../components/PlatformSegmentControl'

import styles from './style'

import Game from '../../models/IGame'

export default Home = (props) => {
    const screenWidth = Math.round(Dimensions.get('window').width ) / 3 ;
    const [tabIndex, setTabIndex] = React.useState(0);
    const handleTabsChange = index => {
        setTabIndex(index)
    };
    
    const [games, setGames] = React.useState([
        {
            identifier: "BlodBorne",
            description: "Jogo de PS",
            image: 'https://image.api.playstation.com/cdn/UP9000/CUSA00900_00/b5uuNMulpxnRpWZDG7lPexwMY7i9Pns7.png'

        },
        {
            identifier: "Space",
            description: "Jogo de PS",
            image: 'https://images-na.ssl-images-amazon.com/images/I/41sPQ+tmJsL._SX331_BO1,204,203,200_.jpg'

        },
        {
            identifier: "God Of War",
            description: "Jogo de PS",
            image: 'https://i.pinimg.com/originals/ca/b2/43/cab243d020819718ce7d367f2915ad4d.jpg'

        }
    ])
    const handleGamesChange = games => {
        setGames(games)
    };

    return (
        <View style={styles.container}>
            <SegmentControl 
            style={styles.segmentControl}
            tabs={['Playstation', 'X-Box', 'Wii', 'Computer']} 
            currentIndex={tabIndex}
            onChange={handleTabsChange}/>
            <FlatList 
            data={games}
            keyExtractor = {({ identifier }) => String(identifier)} 
            numColumns= {2}
            renderItem={
                ({item}) => <GameItem name={item.identifier} uri={item.image} height={screenWidth}/>
            }
            />

        </View>
    )
}