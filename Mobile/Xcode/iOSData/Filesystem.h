/*
 Filesystem.h
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2022 Zonk Technology. All rights reserved.
 
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import <UIKit/UIKit.h>

@interface Filesystem : NSObject

+ (NSString *) DirectoryListing:(NSString *)Name;
+ (NSString*) readFromFile:(NSString*)voiFilename;
+ (void) writeToFile:(NSString*)voiString Filename:(NSString*)voiFilename;
+ (NSString*) readFromFileDict:(NSString*)fileName identifier:(NSString*)voiIdentifier;
+ (NSString*) writeToFileDict:(NSString*)fileName identifier:(NSString*)voiIdentifier string:(NSString*)voiString;
+ (void) UserAlert:(NSString*)voiTitle Message:(NSString*)voiMessage;

@end
