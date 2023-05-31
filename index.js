import { NativeModules, Platform } from 'react-native'

export const getDebugUrl = async () => {
  if (Platform.OS === 'ios') {
    let { address } = await NativeModules.RNDebugUrl.getAddress()
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
      NativeModules.RNDebugUrl.setAddress('')
    } else {
      NativeModules.RNDebugUrl.setAddress(url.startsWith('http') ? url : ('http://' + url))
    }
  } else {
    console.error('安卓端暂不支持:setDebugUrl')
  }
}

