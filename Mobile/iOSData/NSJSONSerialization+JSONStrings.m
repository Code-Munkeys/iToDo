 /*
 NSJSONSerialization+JSONStrings.m
 iToDo

 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2014 Zonk Technology. All rights reserved.
  
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import "NSJSONSerialization+JSONStrings.h"

@implementation NSJSONSerialization (JSONStrings)

+ (void)logJSONWithData:(NSData *)data label:(NSString *)dataLabel {
    
    NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@:  \n%@", dataLabel, jsonString);
    
}

@end
