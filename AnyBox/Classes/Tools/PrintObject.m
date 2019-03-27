//
//  PrintObject.m
//
//  Created by zzg on 11-4-1.
//

#import "PrintObject.h"

#import "PrintObject.h"
#import <objc/runtime.h>

@implementation PrintObject

+ (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    Class cls = [obj class];
    
    while (cls!=[NSObject class]) {
        unsigned int propsCount;
        objc_property_t *props = class_copyPropertyList(cls, &propsCount);
        for(int i = 0;i < propsCount; i++)
        {
            objc_property_t prop = props[i];
            
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            
            id value = [obj valueForKey:propName];
            
            if(value == nil)
            {
                value = [NSNull null];
            }
            else
            {
                value = [self getObjectInternal:value];
            }
            [dic setObject:value forKey:propName];
        }
        free(props);
        //得到父类的信息
        cls = class_getSuperclass(cls);
    }
    
    return dic;
}

+ (id)convertDictionary:(NSDictionary *)dic ToObject:(Class)targetCls{
    
    id obj = [[targetCls alloc] init];
    
    Class cls = [obj class];
    unsigned int count;
    while (cls!=[NSObject class]) {
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        for (int i = 0; i<count; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            //得到属性名可以在这里做反射 反馈过来的dic 直接反射成一个model
            /**
             *  valueForKey: 是 KVC(NSKeyValueCoding) 的方法，在 KVC 里可以通过 property 同名字符串来获取对应的值
             *  这里的dic 的key 与 stu 的属性名一一对应
             */
            id propertyValue = [dic valueForKey:propertyName];
            if (propertyValue)
                [obj setValue:propertyValue forKey:propertyName];//属性get set赋值
            // NSLog(@"%@ = %@",propertyName,propertyValue);
        }
        if (properties){
            free(properties);
        }
        //得到父类的信息
        cls = class_getSuperclass(cls);
    }
    return obj;
}


+ (void)print:(id)obj
{
    NSLog(@"%@", [self getObjectData:obj]);
}


+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

@end
