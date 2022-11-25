 /*
 Task.m
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2022 Zonk Technology. All rights reserved.
  
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, strong) NSString *Guid;
@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *Uuid;
@property (nonatomic, strong) NSString *AssignedDate;
@property (nonatomic, strong) NSString *EstimatedDate;
@property (nonatomic, strong) NSString *CompletedDate;
@property (nonatomic, strong) NSString *Status;
@property (nonatomic, strong) NSString *Image;
@property (nonatomic, strong) NSString *Signature;

//{
//    "_id" : LUUID("6477c358-d154-9943-94b9-46ef263e9e97"),
//    "Title" : "Develop ToDo App For The iPhone",
//    "Description" : "Develop iOS7 client with Server side Csharp WebAPI using MongoDB",
//    "Uuid" : "1234567890",
//    "AssignedDate" : "01/02/2014",
//    "EstimatedDate" : "13/02/2014",
//    "CompletedDate" : "-",
//    "Status" : "In Progress",
//    "Image" : "-",
//    "Signature" : "-",
//    "Detail" : false
//}

- (NSData *)convertToJSONData;

@end
