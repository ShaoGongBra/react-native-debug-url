import { NativeModules, Platform } from 'react-native'

export const getDebugUrl = async () => {
  if (Platform.OS === 'ios') {
    let { address } = await NativeModules.RNDeubgUrl.getAddress()
    address = address.replace('http://', '').replace('https://', '')
    return address
  } else {
    console.error('安卓端暂不支持:getDebugUrl')
    return ''
  }
}

export const setDebugUrl = url => {
  if (Platform.OS === 'ios') {
    if (!url) {
      NativeModules.RNDeubgUrl.setAddress('')
    } else {
      NativeModules.RNDeubgUrl.setAddress(url.startsWith('http') ? url : ('http://' + url))
    }
  } else {
    console.error('安卓端暂不支持:setDebugUrl')
  }
}

