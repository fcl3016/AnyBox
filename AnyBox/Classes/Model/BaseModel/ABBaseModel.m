//
//  ABBaseModel.m
//
//  Created by Stark on 16/12/20.
//  Copyright (c) 2016年 Stark. All rights reserved.
//

#import "ABBaseModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation ABBaseModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount = 0;
    Ivar *vars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        if (value) {
            [aCoder encodeObject:value forKey:key];
        }
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int outCount = 0;
        Ivar *vars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            Ivar var = vars[i];
            const char *name = ivar_getName(var);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
    }
    return self;
}

-(id)initWithJSONDic:(NSDictionary*)json
{
    self = [super init];
    
    if (self)
    {
        [self _setValueForJSONKeysWithDictionary:json];
        [self instanceValue];
        [self resetDataWith:json];
    }
    return self;
}

-(void)_setValueForJSONKeysWithDictionary:(NSDictionary*)json
{
    //建立model和JSON的对应关系
    NSDictionary *relationship = [self _setUpRelationship:json];
    for (id jsonKey in relationship)
    {
        //根据value生成setter方法
        id modelValue = relationship[jsonKey];
    
        //生成SEL变量，指向一个方法
        SEL sel = [self _makeSELWithName:modelValue];
        
        //增强程序的健壮性
        if ([self respondsToSelector:sel])
        {
            
            //获取真正的数据
            id jasonValue = json[jsonKey];
            
            //设置属性值x
            [self performSelector:sel withObject:jasonValue];
        }
    }
    
}//设置model的Value



-(SEL)_makeSELWithName:(NSString*)modelValue
{
    //image - > setImage
    //取出首字母,转化成大写
    NSString *capital = [[modelValue substringToIndex:1]uppercaseString];
    
    //获取剩下的字母
    NSString *end = [modelValue substringFromIndex:1];
    
    //拼接字符串
    NSString *setterMethod = [NSString stringWithFormat:@"set%@%@:",capital,end];
    
    //根据字符创生成方法
    SEL sel = NSSelectorFromString(setterMethod);
    
    //返回生成的setter
    return sel;
    
}//合成setter方法


-(NSMutableDictionary*)_setUpRelationship:(NSDictionary*)json
{
    /*
     relationship
     key :JSON  KEY
     value: Model 属性值
     */
    NSMutableDictionary *relationship = [NSMutableDictionary dictionaryWithCapacity:json.count];
    
    for (id jsonKey in json)
    {
        
        if ([jsonKey isEqualToString:@"id"])
        {
            
            //id拼接  例如：BaseModel -> BaseModelID
            NSString *className = NSStringFromClass([self class]);
            
            NSString *newModeValue = [className stringByAppendingFormat:@"%@",[jsonKey uppercaseString]];
            
            [relationship setObject:newModeValue forKey:jsonKey];
            
        }else
        {
            //model :iamge  json :image
            [relationship   setObject:jsonKey forKey:jsonKey];
        }
        
    }
    
    return  relationship;
    
}//建立映射关系



/**
 *  判断解析出来的字段是否有值
 *
 *  @param keyString 字段名
 *  @param dict   解析出来的数据
 *
 *  @return 是否满足
 */

- (BOOL)targetKey:(NSString *)keyString IsExsitInJsonDictionary:(NSDictionary *) dict{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return NO;
    } else {
        return dict && keyString && [dict objectForKey:keyString] && ![[dict objectForKey:keyString] isKindOfClass:[NSNull class]];
    }
}

- (BOOL)objectIsTure:(NSString *) string AndDict:(NSDictionary *) dict
{
    return dict && string && [dict objectForKey:string] && ![[dict objectForKey:string] isKindOfClass:[NSNull class]];
}



-(void)instanceValue{

}

-(void)resetDataWith:(NSDictionary*)dic{
    
}




@end




