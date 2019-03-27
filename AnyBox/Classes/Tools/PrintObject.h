//
//  PrintObject.h
//
//  Created by zzg on 11-4-1.
//

#import <Foundation/Foundation.h>

@interface PrintObject : NSObject
//通过对象返回一个NSDictionary，键是属性名称，值是属性值。
+ (NSDictionary*)getObjectData:(id)obj;

//将使用getObjectData方法转化的字典  变成对象
+ (id)convertDictionary:(NSDictionary *)dic ToObject:(Class)targetCls;

//将getObjectData方法返回的NSDictionary转化成JSON
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;

//直接通过NSLog输出getObjectData方法返回的NSDictionary
+ (void)print:(id)obj;

@end
