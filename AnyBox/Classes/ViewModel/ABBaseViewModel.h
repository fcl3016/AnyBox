//
//  ABBaseViewModel.h
//  yishengdaojia
//
//  Created by Kara on 15/9/25.
//  Copyright © 2015年 yisheng. All rights reserved.
//

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureVMBlock)(NSError *error);

#import <Foundation/Foundation.h>

@interface ABBaseViewModel : NSObject

@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureVMBlock failureBlock;

// 传入交互的Block块
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureVMBlock) failureBlock;

@end
