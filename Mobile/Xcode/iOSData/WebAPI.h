 /*
 WebAPI.h
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2022 Zonk Technology. All rights reserved.
 
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import <UIKit/UIKit.h>
#import "Task.h"

@interface WebAPI : NSObject

@property (strong, nonatomic) id detailItem;

+(void)Get:(UITableView*)tableView View:(UIView*)view WebserviceLabel:(UILabel*)lblWebservice Objects:(NSMutableArray*)objects Guid:(NSMutableArray*)guid  Uuid:(NSString*)uuid;
+ (void)Insert:(id)detailItem new:(Task*)voiTask ShowAlert:(int)voiShowAlert;
+ (void)Update:(id)detailItem new:(Task*)voiTask ShowAlert:(int)voiShowAlert;
+ (void)Delete:(NSString *)Guid;

@end
