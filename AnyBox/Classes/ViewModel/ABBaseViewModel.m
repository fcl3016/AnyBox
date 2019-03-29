//
//  ABBaseViewModel.m
//  yishengdaojia
//
//  Created by Kara on 15/9/25.
//  Copyright © 2015年 yisheng. All rights reserved.
//

#import "ABBaseViewModel.h"

@implementation ABBaseViewModel

#pragma 接收穿过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureVMBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}

@end
