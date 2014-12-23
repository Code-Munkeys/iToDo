 /*
 DetailViewController.h
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2014 Zonk Technology. All rights reserved.
 
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import <UIKit/UIKit.h>
#import "Task.h"

@interface DetailViewController : UIViewController
{
    IBOutlet UITextField *txtTitle;
    IBOutlet UITextView *txtDescription;
    IBOutlet UITextField *txtAssignedDate;
    IBOutlet UITextField *txtEstimatedDate;
    IBOutlet UITextField *txtCompletedDate;
    IBOutlet UIScrollView *scrollView;
}

- (IBAction)textFieldReturn:(id)sender;

- (IBAction)btnInsert:(id)sender;
- (IBAction)btnUpdate:(id)sender;
- (IBAction)btnClear:(id)sender;
- (IBAction)txtTitleEditingDidBegin:(id)sender;
- (IBAction)txtTitleEditingDidEnd:(id)sender;
- (IBAction)txtAssignedDateEditingDidBegin:(id)sender;
- (IBAction)txtAssignedDateEditingDidEnd:(id)sender;
- (IBAction)txtEstimatedDateEditingDidBegin:(id)sender;
- (IBAction)txtEstimatedDateEditingDidEnd:(id)sender;
- (IBAction)txtCompletedDateEditingDidBegin:(id)sender;
- (IBAction)txtCompletedDateEditingDidEnd:(id)sender;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, retain) IBOutlet UITextField *txtTitle;
@property (nonatomic, retain) IBOutlet UITextView *txtDescription;
@property (nonatomic, retain) IBOutlet UITextField *txtAssignedDate;
@property (nonatomic, retain) IBOutlet UITextField *txtEstimatedDate;
@property (nonatomic, retain) IBOutlet UITextField *txtCompletedDate;
@property (strong, nonatomic) IBOutlet UITextField *txtUuid;
@property (strong, nonatomic) IBOutlet UIButton *btnUpdateOutlet;
@property (strong, nonatomic) IBOutlet UIButton *btnInsertOutlet;
@property (strong, nonatomic) IBOutlet UIButton *btnNewOutlet;
@property (strong, nonatomic) IBOutlet UILabel *lblAssignedDate;
@property (strong, nonatomic) IBOutlet UILabel *lblEstimatedDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCompletedDate;
@property (strong, nonatomic) IBOutlet UILabel *lblGUID;
@property (strong, nonatomic) IBOutlet UITextField *lblGUIDsequence;
@property (strong, nonatomic) IBOutlet UILabel *lblAdd;
@property (strong, nonatomic) IBOutlet UILabel *lblUpdate;
@property (strong, nonatomic) IBOutlet UILabel *lblNew;
@property (strong, nonatomic) IBOutlet UIImageView *imgBlanking;

@property (strong, nonatomic) Task *PushThroughSegue;

@end
