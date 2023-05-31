#import "RNDebugUrl.h"
#import <React/RCTBundleURLProvider.h>

@implementation RNDebugUrl

+ (NSString *) getAddress {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *storedString = [defaults stringForKey:@"RNDebugUrl"];
  if (storedString == nil) {
      storedString = @"";
  }
  return storedString;
}

+ (BOOL) verifyUrl:(NSURL *)url {
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  request.HTTPMethod = @"HEAD";
  request.timeoutInterval = 5; // 设置超时时间为 5 秒

  NSError *error = nil;
  NSURLResponse *response = nil;
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

  if (error) {
      NSLog(@"Cannot make request: %@", error);
  } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      if (httpResponse.statusCode == 200) {
        return YES;
      } else {
          NSLog(@"Request failed with status code: %ld", (long)httpResponse.statusCode);
      }
  }
  return NO;
}

+ (NSURL *) debugURL {
  NSString *address = [RNDebugUrl getAddress];
  NSLog(@"存储地址: %@", address);
  NSURL *url = [NSURL URLWithString:[address isEqualToString:@""] ? @"http://192.168.2.22:8081" : address];
  if([RNDebugUrl verifyUrl:url]) {
    NSLog(@"存储地址: 验证通过");
    url = [url URLByAppendingPathComponent:@""];
    url = [NSURL URLWithString:@"/index.bundle?platform=ios&dev=true&minify=false" relativeToURL:url];
    return url;
  }
  NSLog(@"存储地址: 验证不通过 使用本地代码");
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
}

RCT_EXPORT_MODULE(RNDebugUrl)

RCT_EXPORT_METHOD(getAddress:(RCTPromiseResolveBlock)resolve
                    rejecter:(RCTPromiseRejectBlock)reject)
{
  resolve(@{
    @"address": [RNDebugUrl getAddress]
  });
}

RCT_EXPORT_METHOD(setAddress:(NSString *)address)
{
  //创建系统单例 NSUserDefaults的实例对象
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  //存值
  [defaults setObject:address forKey:@"RNDebugUrl"];
}

@end
