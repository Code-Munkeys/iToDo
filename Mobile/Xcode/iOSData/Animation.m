 /*
 Animation.m
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2022 Zonk Technology. All rights reserved.
 
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import "Animation.h"

@interface Animation ()

@end

@implementation Animation

NSString *DateFieldType = @"DATES", *TitleFieldType = @"TITLE";

+ (UIView*) SlideViewUp:(UIView*)view LabelType:(NSString*)voiLabelType
{
	[UIView beginAnimations:nil context:NULL];
	
    [UIView setAnimationDuration:0.3];
	
    CGRect rect = [view frame];
	
    if ([voiLabelType  isEqual: DateFieldType])
    {
        rect.origin.y -= 145;
    }
    
    if ([voiLabelType  isEqual: TitleFieldType])
    {
        rect.origin.y -= 0;
    }
    
    [view setFrame: rect];
    
	[UIView commitAnimations];
    
    return view;
}

+ (UIView*) SlideViewDown:(UIView*)view LabelType:(NSString*)voiLabelType
{
	[UIView beginAnimations:nil context:NULL];
	
    [UIView setAnimationDuration:0.3];
	
    CGRect rect = [view frame];
	
    if ([voiLabelType  isEqual: DateFieldType])
    {
        rect.origin.y += 145;
    }
    
    if ([voiLabelType  isEqual: TitleFieldType])
    {
        rect.origin.y -= 0;
    }
    
    [view setFrame: rect];
	
	[UIView commitAnimations];
    return view;
}

@end
