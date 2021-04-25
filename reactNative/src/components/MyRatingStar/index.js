import React, { useState, Component } from 'react';
import StarRating from 'react-native-star-rating'

class MyRatingStar extends Component {

    EMPTY_STAR = require('../../assets/images/empty_star.png')
    STAR = require('../../assets/images/star.png')

    constructor(props) {
        super(props)
        this.state = {
            starCount: 0
        }
    }

    onStarRatingPress(rating) {
        this.setState({
            starCount:rating
        })
    }

    render() {
        return (
            <StarRating 
                disabled={false}
                maxStars={5}
                halfStarEnabled={false}
                emptyStar={this.EMPTY_STAR}
                fullStar={this.STAR}
                rating={this.state.starCount}
                selectedStar={(rating) => this.onStarRatingPress(rating)}/>
            
        )
    }
}

export default MyRatingStar