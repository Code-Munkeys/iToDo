 /*
 Task.m
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2014 Zonk Technology. All rights reserved.
  
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import "Task.h"

@implementation Task

- (NSString *)description {
    
    glbGuid = [self Guid];
    glbTitle = [self Title];
    glbDescription = [self Description];
    glbAssignedDate = [self AssignedDate];
    glbEstimatedDate = [self EstimatedDate];
    glbCompletedDate = [self CompletedDate];
    
    NSString *convertedString = [[NSString alloc] initWithData:glbJsonData encoding:NSUTF8StringEncoding];

    NSLog(@"%@",convertedString);
    
    //return convertedString;
    
	return [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@", [self Title], [self Description], [self Uuid], [self AssignedDate], [self EstimatedDate], [self CompletedDate], [self Status], [self Image], [self Signature]];
}

- (NSData *)convertToJSONData {
    
    // convert Task object to Foundation objects before attempting serialization
    NSMutableDictionary *newTask = [[NSMutableDictionary alloc] init];
    [newTask setObject:[self Title] forKey:@"Title"];
    [newTask setObject:[self Description] forKey:@"Description"];
    [newTask setObject:[self Uuid] forKey:@"Uuid"];
    [newTask setObject:[self AssignedDate] forKey:@"AssignedDate"];
    [newTask setObject:[self EstimatedDate] forKey:@"EstimatedDate"];
    [newTask setObject:[self CompletedDate] forKey:@"CompletedDate"];
    [newTask setObject:[self Status] forKey:@"Status"];
    [newTask setObject:[self Image] forKey:@"Image"];
    [newTask setObject:[self Signature] forKey:@"Signature"];
	
	NSData *jsonData;
    
    // verify that object graph is serializable
    if ([NSJSONSerialization isValidJSONObject:newTask]) {
		NSError* jsonError;
        // convert Foundation objects to an NSData object containing JSON
		jsonData = [NSJSONSerialization dataWithJSONObject:newTask options:NSJSONWritingPrettyPrinted error:&jsonError];
	}
    
    glbJsonData = jsonData;
    return jsonData;
}


@end
