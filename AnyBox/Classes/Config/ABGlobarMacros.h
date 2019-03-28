//
//  ABGlobarMacros.h
//
//  Created by Kara on 15/9/21.
//  Copyright © 2015年 yisheng. All rights reserved.
//

#ifndef ABGlobarMacros_h
#define ABGlobarMacros_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//加载资源里面的图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//单例定义
#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \

//定义一个单例
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;
#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}

#define fontWithSize(x) [UIFont systemFontOfSize:(x)]
#define boldFontWithSize(x) [UIFont boldSystemFontOfSize:(x)]

#define IMAGENAMED(NAME)        [UIImage imageNamed:NAME]

#define nsnull [NSNull null]
#define DoubleValueIsNotEuqal(a, b)  (ABS(a-b) < 0.000000000001) ? 0 : 1

#ifndef vformat
#define vformat(fmt,args...) [NSString stringWithFormat:fmt,args]
#endif

#pragma mark - Methods
#define     URL(urlString)    [NSURL URLWithString:urlString]
#define     NoNilString(str)  (str.length > 0 ? str : @"")
#define     TimeStamp(date)   ([NSString stringWithFormat:@"%lf", [date timeIntervalSince1970]])
#define     Color(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
#define IS_IPHONE_SIMULATOR   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone Simulator" ] )
#define IS_IPAD ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define IS_IPHONE5 ( (IS_IPHONE || IS_IPHONE_SIMULATOR) && IS_WIDESCREEN )
#define IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IOS7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define IS_IOS8  [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define IS_IOS9  [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define IS_IOS10 [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0
#define IS_IOS11 [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0


#pragma mark - SIZE
#define     SIZE_SCREEN                 [UIScreen mainScreen].bounds.size
#define     SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define     SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
#define     STATUSBAR_HEIGHT            (IS_IPHONEX?44.0f:20.0f)
#define     TABBAR_HEIGHT               49.0f
#define     NAVBAR_HEIGHT               44.0f
#define     NAVBAR_ITEM_FIXED_SPACE     5.0f
#define     TOOLBAR_HEIGHT 50
#define     SAFE_AREA_BOTTOM_HEIGHT (IS_IPHONEX ? 34 : 0)
#define     CONTENT_VIEW_HEIGHT_NO_BOTTOM_SAFE (SCREEN_HEIGHT - NAVBAR_HEIGHT - STATUSBAR_HEIGHT)
#define     CONTENT_VIEW_HEIGHT (SCREEN_HEIGHT - NAVBAR_HEIGHT - STATUSBAR_HEIGHT - SAFE_AREA_BOTTOM_HEIGHT)
#define     CONTENT_VIEW_WITHTOOBARNAV_HEIGHT (SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVBAR_HEIGHT - TOOLBAR_HEIGHT - SAFE_AREA_BOTTOM_HEIGHT)

#define     IS_LANDSCAPE ((UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))? YES:NO)

//设计意义上的1像素的线
#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#endif /* GlobarDefine_h */
