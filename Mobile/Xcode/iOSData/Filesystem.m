/*
 Filesystem.h
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2014 Zonk Technology. All rights reserved.
 
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import "Filesystem.h"

@interface Filesystem()

@end

@implementation Filesystem

+ (NSString *) DirectoryListing:(NSString *)Name
{
    NSString *Directory = @"/n";
    
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent: Name];
    NSFileManager *localFileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnum =
    [localFileManager enumeratorAtPath:docsDir];
    NSError *error=nil;
    
    Directory = [NSString stringWithFormat:@"\n\n%@ Directory: %@", Name, docsDir];
    
    //NSLog(@" Documents Directory: %@", docsDir);
    
    NSString *file;
    while (file = [dirEnum nextObject]) {
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@", docsDir,file];
        NSDictionary *attrs = [localFileManager attributesOfItemAtPath:fullPath error:&error];
        if ( error ) {
            NSLog(@" error - %@", error);
        } else {
            //NSLog(@" file : %@", file);
            NSInteger fsiz = [attrs fileSize];
            NSString *ftyp = [attrs fileType];
            NSDate   *fmod = [attrs fileModificationDate];
            //NSLog(@"  %9d : %@ : %@ : %@",  fsiz, file, ftyp, fmod );
            
            Directory = [Directory stringByAppendingString:[NSString stringWithFormat:@"\nFilename: %@",file]];
            Directory = [Directory stringByAppendingString:[NSString stringWithFormat:@" Size: %9ld, ",(long)fsiz]];
            Directory = [Directory stringByAppendingString:[NSString stringWithFormat:@" Type: %@, ",ftyp]];
            Directory = [Directory stringByAppendingString:[NSString stringWithFormat:@" Date Modified: %@",fmod]];
        }
    }
    
    Directory = [Directory stringByAppendingString:@"\n======  End Documents Directory ========"];
    
    //NSLog(@" ======  End Documents Directory ========");
    
    return Directory;
}

+ (NSString*)readFromFile:(NSString*)voiFilename
{
    NSString *voiString = @"";
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = voiFilename;
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    if (filePath) {
        NSString *contentOfFile = [NSString stringWithContentsOfFile:fileAtPath encoding:NSUTF8StringEncoding error:nil];
        voiString = contentOfFile;
    }
    
    return voiString;
}

+ (void)writeToFile:(NSString*)voiString Filename:(NSString*)voiFilename
{
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = voiFilename;
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    // The main act.
    [[voiString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}

+ (NSString*)readFromFileDict:(NSString*)fileName identifier:(NSString*)voiIdentifier
{
    NSString *voiString = @"";
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    if (filePath) {
        NSDictionary *contentOfFile = [NSDictionary dictionaryWithContentsOfFile:fileAtPath];
        voiString = [contentOfFile objectForKey:voiIdentifier];
    }
    
    return voiString;
}

+ (NSString*)writeToFileDict:(NSString*)fileName identifier:(NSString*)voiIdentifier string:(NSString*)voiString
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict setValue:voiString forKey:voiIdentifier];
    
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    // The main act.
    [dict writeToFile:fileAtPath atomically:NO];
    
    return voiString;
}

+ (void) UserAlert:(NSString*)voiTitle Message:(NSString*)voiMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:voiTitle
                                                    message:voiMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

@end
