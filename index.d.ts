declare module 'react-native' {
  interface NativeModulesStatic {
    RNDeubgUrl: {
      getAddress(): Promise<{ address: string }>;
      setAddress(url: string): void;
    };
  }
}

/**
 * 获取调试 URL 地址
 * @returns 调试 URL 地址
 */
export function getDebugUrl(): Promise<string>;

/**
 * 设置调试 URL 地址
 * @param url 调试 URL 地址
 */
export function setDebugUrl(url: string): void;