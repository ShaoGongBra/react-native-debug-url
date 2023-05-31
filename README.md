# react-native-debug-url

react-native IOS端可以手动输入调试地址

## 安装

`$ yarn add react-native-debug-url`

## 使用
```javascript
import { getDebugUrl, setDebugUrl } from 'react-native-debug-url';

// 获取当前地址
const url = async getDebugUrl()

// 设置地址
setDebugUrl('192.168.1.2:8081')
// 设置成功后reload即可使用设置的地址
```