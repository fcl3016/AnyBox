
//
//  DebugUtils.m
//  TwitterFon
//
//  Created by kaz on 7/21/08.
//  Copyright 2008 naan studio. All rights reserved.
//

#import "DebugUtils.h"

BOOL IS_TEST_URL = NO;

BOOL IS_OPEN_LOG = NO;

BOOL IS_WRITE_LOG_TO_FILE = NO;

void Write_Log_To_File(NSString *format, ...){
    if(IS_WRITE_LOG_TO_FILE){
        va_list ap;
        va_start (ap, format);
        format = [format stringByAppendingString:@"\n"];
        NSString *msgstr = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap]; 
        va_end (ap);
        NSLog(@"%@", msgstr);
//        [msgstr release];
    }
}
