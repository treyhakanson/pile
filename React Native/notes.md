# React Native Notes

## Overview

React Native looks and feels like react, but produces native mobile app code for both iOS and Android. Also allows for the ability to polyfill by diving into native code (Swift, Obj-C, Java, etc.)

## Basics

Instead of html tags (div, span, etc.), all components are custom and representative of native components. Registering custom components will result in their display. The following example illustrates a very basic screen in React Native:

```javascript
import React, { Component } from 'react';
import { AppRegistry, Text, View } from 'react-native';

class Greeting extends Component {
  render() {
    return (
      <Text>Hello {this.props.name}!</Text>
    );
  }
}

class LotsOfGreetings extends Component {
  render() {
    return (
      <View style={{alignItems: 'center'}}>
        <Greeting name='Rexxar' />
        <Greeting name='Jaina' />
        <Greeting name='Valeera' />
      </View>
    );
  }
}

// `AppRegistry.registerComponent` is more or less equivalent to
// `ReactDOM.render` in React; it renders the given component to the screen
AppRegistry.registerComponent('LotsOfGreetings', () => LotsOfGreetings);
```

Styling is done with the `style` prop, and keys match CSS properties for the most part, except that the keys are camelcased:

```javascript
// the following text would be red, 30px, and bold
<Text style={{ fontWeight: 'bold', color: 'red', fontSize: 30 }}>Hello World</Text>
```

Note that all dimensions in React-Native are unitless, and represent density-independent pixels. Thus, dimensions are numbers and not strings (unless working in percentages).

React-Native supports the [flex](https://facebook.github.io/react-native/docs/flexbox.html) property, and defaults to `flexDirection: 'column'` instead of row, like on the web.

## Basic Components

The following are some basic components that are available more or less identically cross-platform

- *View* a simple container
- *Text* basic display text
- *TextLabel* basic editable text
  -  `onChangeText` takes a callback with 1 argument, text. Fires every time the input value changes
- *Image* displays an image on the screen
  -  `source` takes a data url to display or an object with a `uri` key specifying a url to pull the image from (must be manually sized in this case)
-  *ScrollView* allows for overflowing content to be scrolled through
-  *ListView* displays a list of items (more on *ListViews* in the 'ListViews' section)
-  *Navigator* is a basic navigation stack manager for scenes (more on *Navigator* in the 'Navigator' example application)

## ListViews

Listviews display a list of data. They are superior to a *ScrollView* in that they only render the elements currently visible on the screen. A *ScrollView* will render the entire view.

The original `ListView` and `DataSource` components have been deprecated, and one of the following are to be used instead, based on the application:

### FlatList

Main component for simple, performant lists:

```js
<FlatList
  data={[{title: 'Title Text', key: 'item1'}, ...]}
  renderItem={({item}) => <ListItem title={item.title} />}
/>
```

### SectionList

Renders a set of data broken into sections, which may be homogenous (address book) or heterogeneous (header view -> toolbar -> photos -> etc.):

```js
{/* Homogeneous */}
<SectionList
    renderItem={({item}) => <ListItem item={item} />}
    renderSectionHeader={({section}) => <ListHeader title={section.key} />}
    sections={[
        {data: [...], key: ...},
        {data: [...], key: ...},
        {data: [...], key: ...},
        ...
    ]}
/>

{/* Heterogeneous */}
<SectionList
    sections={[
        {data: [...], key: ..., renderItem: ...},
        {data: [...], key: ..., renderItem: ...},
        {data: [...], key: ..., renderItem: ...},
        ...
    ]}
/>
```

### VirtualizedList

Low-level list API that is flexible, but will rarely be needed. Only really comes into play when input data is not a plain array.

### General Features



## Miscellaneous

### Colors

Colors in React-Native can be declared any of the usual CSS ways, inclduing rgb() and rgba(). Named colors follow the [CSS3 Specification](https://facebook.github.io/react-native/docs/colors.html).

### Static Images

Static images can be be added anywhere in the project and are referenced through require, similar to using the file-loader in Reactjs:

`<Image source={require('./path/to/image.png')} />`

It is important to note that to use the require syntax for images, the image path must be statically determinant; thus, the following is unacceptable:

```javascript
const imageName = 'some_image.png';
return <Image source={require('./' + imageName + '.png')} />;
```

specifying platform for the image is also possible with the following syntax:

`image_name.<platform>.png`

so, `image_name.ios.png` for iOS and `image_name.android.png` for Android.

screen density can also be specified, and will be automatically chosen based on device size:

`image_name<size>.png`

so, `image_name@2x.png` and `image_name@3x.png` for higher density devices

images can also be loaded over the network, but if this is the case they MUST be sized manually:

```javascript
<Image
  soure={{ uri: 'https://some-url.com/some_image.png' }}
  style={{ width: 400, height: 400 }} />
```

the source object can take any number of metadata parameters as well, such as `crop: { top, right, width, height }` among others.

the concept of a background-image is easily implemented in React-Native simply by nesting whatever elements need to be overlayed within the `Image` component.

#### Platform Specific Quirks

##### iOS

The following specifications ar currently ignored by the iOS image component:

- `borderTopLeftRadius`
- `borderTopRightRadius`
- `borderBottomLeftRadius`
- `borderBottomRightRadius`

## Handling Touches

### Tapable Components

Tapable components have an `onPress` prop that fires any time the user taps the element. Tapable components include:

- *TouchableHighlight* the basic tapable component; darkens on tap. Generally used like a button of link on the web
- *TouchableNativeFeedback* works well on Android to display ink surface ripples wherever the user touched (from the material-ui spec)
- *TouchableOpacity* lowers opacity when the user taps
- *TouchableWithoutFeedback* gives no feedback when the user presses

Tapable components also have an `onLongPress` handler where needed.

### Scrolling Lists and Swiping Views

ScrollViews have an optionally `pagingEnabled` prop that allows for the ScrollView to be swiped left or right to page to another view. Similar behavior can be found more natively in Android via the `ViewPagerAndroid` component

## Animations

There are too main animation APIs in React-Native, `LayoutAnimation` for global transactional animations, and `Animation` for more granular and interactive control of specific values

Here is an example of a basic bounce animation for an Image component, which fires on the `Playground` component mounting:

```javascript
class Playground extends Component {
  componentDidMount() {
    this.state.bounceValue.setValue(1.5);     // Start large
    Animated.spring(                          // Base: spring, decay, timing
      this.state.bounceValue,                 // Animate `bounceValue`
      {
        toValue: 0.8,                         // Animate to smaller size
        friction: 1,                          // Bouncier spring
      }
    ).start();                                // Start the animation
  }

  constructor(props) {
    super(props);
    this.state = {
      bounceValue: new Animated.Value(0),
    };
  }

  render() {
    return (
      <Animated.Image                        // Base: Image, Text, View
        source={{uri: 'http://i.imgur.com/XMKOH81.jpg'}}
        style={{
          flex: 1,
          transform: [                       // `transform` is an ordered array
            { scale: this.state.bounceValue }, // Map `bounceValue` to `scale`
          ]
        }} />
    );
  }
}
```
