 /*
 DetailViewController.m
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2022 Zonk Technology. All rights reserved.
 
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import "DetailViewController.h"

@interface DetailViewController ()

{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
}

- (void)configureView;

@end

@implementation DetailViewController

@synthesize txtDescription, txtTitle, txtAssignedDate, txtCompletedDate,
            txtEstimatedDate, lblAssignedDate, lblEstimatedDate,
            lblCompletedDate, lblAdd, lblUpdate, lblNew, imgBlanking,
            lblGUID, lblGUIDsequence, txtUuid, btnInsertOutlet,
            btnUpdateOutlet, btnNewOutlet, PushThroughSegue;

#define TAG_INSERT 1
#define TAG_UPDATE 2

#pragma mark - Managing the detail item

NSString *locExistingRecord = @"";
NSString *locTextField;

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
        txtTitle.text = PushThroughSegue.Title;
        txtDescription.text = PushThroughSegue.Description;
        txtUuid.text = PushThroughSegue.Guid;
        txtAssignedDate.text = PushThroughSegue.AssignedDate;
        txtEstimatedDate.text = PushThroughSegue.EstimatedDate;
        txtCompletedDate.text = PushThroughSegue.CompletedDate;
    }
}

- (void)viewDidLoad
{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 5.0;
    opacity = 1.0;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    NSLog(@"Profile PushThroughSegue: %@",PushThroughSegue);
}

- (void)viewWillAppear:(BOOL)animated
{
    [self FourInchDetect];
    [self configureView];
    btnInsertOutlet.enabled = FALSE;
    btnUpdateOutlet.enabled = FALSE;
    locExistingRecord = @"Y";
}

-(void)FourInchDetect
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (height>550)
    {
        NSLog(@"4 Inch screen size is %f",height);
        
        int txtAssignedDateX;
        int txtEstimatedDateX;
        int txtCompletedDateX;
        int txtDatesY;
        int voiAdjustment = 75;
        
        txtAssignedDateX = txtAssignedDate.frame.origin.x + txtAssignedDate.frame.size.width / 2;
        txtEstimatedDateX = txtEstimatedDate.frame.origin.x + txtEstimatedDate.frame.size.width / 2;
        txtCompletedDateX = txtCompletedDate.frame.origin.x + txtCompletedDate.frame.size.width / 2;
        txtDatesY = txtAssignedDate.frame.origin.y + txtAssignedDate.frame.size.height / 2;
        txtDatesY = txtDatesY + voiAdjustment;
        
        [txtAssignedDate setCenter:CGPointMake(txtAssignedDateX, txtDatesY)];
        [txtEstimatedDate setCenter:CGPointMake(txtEstimatedDateX, txtDatesY)];
        [txtCompletedDate setCenter:CGPointMake(txtCompletedDateX, txtDatesY)];
        
        int lblAssignedDateX;
        int lblEstimatedDateX;
        int lblCompletedDateX;
        int lblDatesY;
        
        lblAssignedDateX = lblAssignedDate.frame.origin.x + lblAssignedDate.frame.size.width / 2;
        lblEstimatedDateX = lblEstimatedDate.frame.origin.x + lblEstimatedDate.frame.size.width / 2;
        lblCompletedDateX = lblCompletedDate.frame.origin.x + lblCompletedDate.frame.size.width / 2;
        lblDatesY = lblAssignedDate.frame.origin.y + lblAssignedDate.frame.size.height / 2;
        lblDatesY = lblDatesY + voiAdjustment;
        
        [lblAssignedDate setCenter:CGPointMake(lblAssignedDateX, lblDatesY)];
        [lblEstimatedDate setCenter:CGPointMake(lblEstimatedDateX, lblDatesY)];
        [lblCompletedDate setCenter:CGPointMake(lblCompletedDateX, lblDatesY)];

        int lblGuidX;
        int lblGuidSequenceX;
        int lblGuidY;
        
        lblGuidX = lblGUID.frame.origin.x + lblGUID.frame.size.width / 2;
        lblGuidSequenceX = lblGUIDsequence.frame.origin.x + lblGUIDsequence.frame.size.width / 2;
        lblGuidY = lblGUID.frame.origin.y + lblGUID.frame.size.height / 2;
        lblGuidY = lblGuidY + voiAdjustment;
        
        [lblGUID setCenter:CGPointMake(lblGuidX, lblGuidY)];
        [lblGUIDsequence setCenter:CGPointMake(lblGuidSequenceX, lblGuidY)];

        int btnAddX;
        int btnUpdateX;
        int btnNewX;
        int btnButtonsY;
        
        btnAddX = btnInsertOutlet.frame.origin.x + btnInsertOutlet.frame.size.width / 2;
        btnUpdateX = btnUpdateOutlet.frame.origin.x + btnUpdateOutlet.frame.size.width / 2;
        btnNewX = btnNewOutlet.frame.origin.x + btnNewOutlet.frame.size.width / 2;
        btnButtonsY = btnInsertOutlet.frame.origin.y + btnInsertOutlet.frame.size.height / 2;
        btnButtonsY = btnButtonsY + voiAdjustment;
        
        [btnInsertOutlet setCenter:CGPointMake(btnAddX, btnButtonsY)];
        [btnUpdateOutlet setCenter:CGPointMake(btnUpdateX, btnButtonsY)];
        [btnNewOutlet setCenter:CGPointMake(btnNewX, btnButtonsY)];

        int lblAddX;
        int lblUpdateX;
        int lblNewX;
        int lblButtonsY;
        
        lblAddX = lblAdd.frame.origin.x + lblAdd.frame.size.width / 2;
        lblUpdateX = lblUpdate.frame.origin.x + lblUpdate.frame.size.width / 2;
        lblNewX = lblNew.frame.origin.x + lblNew.frame.size.width / 2;
        lblButtonsY = lblAdd.frame.origin.y + lblAdd.frame.size.height / 2;
        lblButtonsY = lblButtonsY + voiAdjustment;
        
        [lblAdd setCenter:CGPointMake(lblAddX, lblButtonsY)];
        [lblUpdate setCenter:CGPointMake(lblUpdateX, lblButtonsY)];
        [lblNew setCenter:CGPointMake(lblNewX, lblButtonsY)];

        CGRect txtDescriptionRectangle = CGRectMake(txtDescription.frame.origin.x, txtDescription.frame.origin.y, txtDescription.frame.size.width, txtDescription.frame.size.height + voiAdjustment);
        [txtDescription setFrame:txtDescriptionRectangle];
        
        CGRect imgBlankingRectangle = CGRectMake(imgBlanking.frame.origin.x, imgBlanking.frame.origin.y + voiAdjustment, imgBlanking.frame.size.width, imgBlanking.frame.size.height);
        [imgBlanking setFrame:imgBlankingRectangle];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Use this method also if you want to hide keyboard when user touch in background

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtTitle resignFirstResponder];
    [txtDescription resignFirstResponder];
    [txtAssignedDate resignFirstResponder];
    [txtEstimatedDate resignFirstResponder];
    [txtCompletedDate resignFirstResponder];
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [txtTitle resignFirstResponder];
    [txtDescription resignFirstResponder];
    [txtAssignedDate resignFirstResponder];
    [txtEstimatedDate resignFirstResponder];
    [txtCompletedDate resignFirstResponder];
    return YES;
}

- (IBAction)btnKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)btnInsert:(id)sender
{
    if ((![txtTitle.text isEqual: @""]) && (![txtDescription.text isEqual: @""]))
    {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Job"
                                                   message: @"Insert Task, are you sure?"
                                                  delegate: self
                                         cancelButtonTitle: @"No"
                                         otherButtonTitles: @"Yes",nil];
    alert.tag = TAG_INSERT;
    [alert show];
    }
    else
    {
        UIAlertView *UserAlert = [[UIAlertView alloc] initWithTitle:@"New Job" message:@"Task Incomplete!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [UserAlert show];
    }
}

- (IBAction)btnUpdate:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Job"
                                                   message: @"Update Task, are you sure?"
                                                  delegate: self
                                         cancelButtonTitle: @"No"
                                         otherButtonTitles: @"Yes",nil];
    alert.tag = TAG_UPDATE;
    [alert show];
}

-(void)Clear
{
    txtTitle.text = @"";
    txtDescription.text = @"";
    txtEstimatedDate.text = @"-";
    txtCompletedDate.text = @"-";
        
    txtAssignedDate.text = [Formatting TodayDateFormatted];
}

- (IBAction)btnClear:(id)sender
{
    [self Clear];
    btnUpdateOutlet.enabled = FALSE;
    btnInsertOutlet.enabled = TRUE;
    locExistingRecord = @"N";
}

- (void)insertAPI {
    
    // create a new task object
    Task *newTask = [[Task alloc] init];
    [newTask setTitle:txtTitle.text];
    [newTask setDescription:txtDescription.text];
    [newTask setUuid:PushThroughSegue.Uuid];
    [newTask setAssignedDate:txtAssignedDate.text];
    [newTask setEstimatedDate:txtEstimatedDate.text];
    [newTask setCompletedDate:txtCompletedDate.text];
    [newTask setStatus:@""];
    [newTask setImage:@""];
    [newTask setSignature:@""];
    
    [WebAPI Insert:_detailItem new:newTask ShowAlert:1];
}

- (void)updateAPI {
    
    // create a new task object
    Task *newTask = [[Task alloc] init];
    [newTask setTitle:txtTitle.text];
    [newTask setDescription:txtDescription.text];
    [newTask setUuid:PushThroughSegue.Uuid];
    [newTask setAssignedDate:txtAssignedDate.text];
    [newTask setEstimatedDate:txtEstimatedDate.text];
    [newTask setCompletedDate:txtCompletedDate.text];
    [newTask setStatus:@""];
    [newTask setImage:@""];
    [newTask setSignature:@""];
    
    [WebAPI Update:_detailItem new:newTask ShowAlert:1];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == TAG_INSERT)
    {
        if (buttonIndex == 0)
        {
            //Do Nothing
        }
        else
        {
            [self insertAPI];
            [self Clear];
            [self dismissViewControllerAnimated:YES completion: nil];
        }
    }
    
    if (alertView.tag == TAG_UPDATE)
    {
        if (buttonIndex == 0)
        {
             //Do Nothing
        }
        else
        {
            [self updateAPI];
            [self dismissViewControllerAnimated:YES completion: nil];
        }
    }
}

- (IBAction)txtTitleEditingDidBegin:(id)sender
{
    locTextField = @"TITLE";
}

- (IBAction)txtTitleEditingDidEnd:(id)sender
{
  if([locExistingRecord  isEqual: @"Y"])
  {
      btnUpdateOutlet.enabled = TRUE;
  }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

- (IBAction)txtAssignedDateEditingDidBegin:(id)sender
{
    locTextField = @"DATES";
}

- (IBAction)txtAssignedDateEditingDidEnd:(id)sender
{
    if([locExistingRecord  isEqual: @"Y"])
    {
        btnUpdateOutlet.enabled = TRUE;
    }
}

- (IBAction)txtEstimatedDateEditingDidBegin:(id)sender
{
    locTextField = @"DATES";
}

- (IBAction)txtEstimatedDateEditingDidEnd:(id)sender
{
    if([locExistingRecord  isEqual: @"Y"])
    {
        btnUpdateOutlet.enabled = TRUE;
    }
}

- (IBAction)txtCompletedDateEditingDidBegin:(id)sender
{
    locTextField = @"DATES";
}

- (IBAction)txtCompletedDateEditingDidEnd:(id)sender
{
    if([locExistingRecord  isEqual: @"Y"])
    {
        btnUpdateOutlet.enabled = TRUE;
    }
}

- (void) keyboardWillShow: (NSNotification*) aNotification;
{	
    [Animation SlideViewUp:[self view] LabelType:locTextField];
}

- (void) keyboardWillHide: (NSNotification*) aNotification;
{
    [Animation SlideViewDown:[self view] LabelType:locTextField];
}

@end
