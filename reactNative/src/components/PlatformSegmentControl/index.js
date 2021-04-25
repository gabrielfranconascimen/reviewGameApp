import PropTypes from 'prop-types'
import React, { useEffect } from 'react'
import { Animated, TouchableOpacity, StyleSheet, Dimensions, Text } from 'react-native'
import { colors, dimens } from '../../styles'

const shadow = {
    shadowColor: "#000",
    shadowOffset: {
        width: 0,
        height: 2
    },
    shadowOpacity: 0.23,
    shadowRadius: 2.62,
    elevation: 4
}

const width = Dimensions.get('screen').width - 32

const SegmentControl = (props) => {
    const translateValue = ((width - 4) / props?.tabs?.length)
    const [tabTranslate, setTabTranslate] = React.useState(new Animated.Value(0))

    const memoizedTabPressCallback = React.useCallback(
        (index) => {
            props?.onChange(index)
        },
        []
    );

    useEffect(() => {
        Animated.spring(tabTranslate, {
            toValue: props?.currentIndex * translateValue,
            stiffness: 180,
            damping: 20,
            mass: 1, 
            useNativeDriver: true
        }).start()
    }, [props?.currentIndex])

    return (
        <Animated.View style={[ styles.segmentedControlWrapper,
        {backgroundColor: props?.segmentedControlBackgroundColor},
        {paddingVertical: props?.paddingVertical}]}>
            <Animated.View style={
                [{
                    ...StyleSheet.absoluteFill,
                    position: "absolute",
                    width: (width - 4) / props?.tabs?.length,
                    top: 0,
                    marginVertical: 2,
                    marginHorizontal: 2,
                    backgroundColor: props?.activeSegmentbackgroundColor,
                    borderRadius: 8,
                    ...shadow
                },{
                    transform: [{translateX: tabTranslate}]
                }]
            } />
            {
                props?.tabs.map((tab, index) => {
                    const isCurrentIndex = props?.currentIndex === index
                    return (
                        <TouchableOpacity 
                        key={index}
                        style={[styles.textWrapper]}
                        onPress={() => memoizedTabPressCallback(index)}
                        activeOpacity={0.75}>
                            <Text 
                            numberOfLines={1}
                            style={[styles.textStyles, {color: props?.textColor}, isCurrentIndex && {color: props?.activeTextColor } ]}>
                                {tab}
                            </Text>
                        </TouchableOpacity>
                    )
                })
            }
        
        </Animated.View>
    )
}

const styles = StyleSheet.create({
    segmentedControlWrapper: {
        display: 'flex',
        flexDirection: 'row',
        alignItems: 'center',
        borderRadius: dimens.regularMargin,
        width: width,
        margin: dimens.largeMargin
    },
    textWrapper: {
        flex: 1,
        elevation: 9,
    },
    textStyles: {
        fontSize: dimens.smallText,
        textAlign: 'center',
        elevation: 9,
        fontWeight: '600',
        padding: dimens.xsmallPadding
    }
})

SegmentControl.propTypes = {
    tabs: PropTypes.arrayOf(PropTypes.string).isRequired,
    onChange: PropTypes.func.isRequired,
    currentIndex: PropTypes.number.isRequired,
    segmentedControlBackgroundColor: PropTypes.string,
    activeSegmentbackgroundColor: PropTypes.string,
    textColor: PropTypes.string,
    activeTextColor: PropTypes.string,
    paddingVertical: PropTypes.number
}

SegmentControl.defaultProps = {
    tabs: [],
    onChange: () => {},
    currentIndex: 0,
    segmentedControlBackgroundColor: colors.gray,
    activeSegmentbackgroundColor: colors.black,
    textColor: colors.black,
    activeTextColor: colors.white,
    paddingVertical: 12
}

export default SegmentControl 