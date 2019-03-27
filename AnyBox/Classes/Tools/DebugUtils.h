//
//  DebugUtils.h
//  TwitterFon
//
//  Created by kaz on 7/21/08.
//  Copyright 2008 naan studio. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
#  define LOG(...) NSLog(__VA_ARGS__)
#  define LOGRECT(r) NSLog(@"(%.1fx%.1f)-(%.1fx%.1f)", r.origin.x, r.origin.y, r.size.width, r.size.height)
#else
#  define LOG(...) ;
#  define LOGRECT(r) ;
#endif

#define __FUNC_NAME__ NSLog(NSStringFromSelector(_cmd)); 

extern BOOL IS_TEST_URL;//切换正式测试环境

extern BOOL IS_OPEN_LOG;//是否打开log

extern BOOL IS_WRITE_LOG_TO_FILE;//是否打开写文件

void Write_Log_To_File(NSString *format, ...);



#ifdef DEBUG
#define DLog(...) GGLog(__VA_ARGS__)

#elif (IS_OPEN_LOG == YES) //必须加（） 与YES 进行判断    宏默认没有进行比较操作
#define DLog(...) GGLog(__VA_ARGS__)

#elif (IS_WRITE_LOG_TO_FILE == YES)
#define DLog(...) Write_Log_To_File(__VA_ARGS__)

#else
#define DLog(...)

#endif






