 /*
 MasterViewController.m
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2014 Zonk Technology. All rights reserved.
 
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    NSMutableArray *_guid;
}

@end

@implementation MasterViewController

@synthesize lblWebservice, lblUuid;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 22)];
    //[addButton setImage:[UIImage imageNamed:@"Refresh.png"] forState:UIControlStateNormal];
    
    //[addButton addTarget:self action:@selector(refreshTaskList:) forControlEvents:UIControlEventTouchUpInside];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    _objects = [[NSMutableArray alloc] init];
    _guid = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    lblUuid.textColor = [UIColor darkGrayColor];
    lblUuid.text = glbUuid;
    
    [_objects removeAllObjects];
    [_guid removeAllObjects];
    
    [WebAPI Get:self.tableView View:self.view WebserviceLabel:lblWebservice Objects:_objects Guid:_guid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTaskList:(id)sender
{
    [self.tableView setEditing:NO animated:YES];
    [WebAPI Get:self.tableView View:self.view WebserviceLabel:lblWebservice Objects:_objects Guid:_guid];
}

- (void)insertNewObject:(id)sender
{
    [self NewTask];
    [WebAPI Get:self.tableView View:self.view WebserviceLabel:lblWebservice Objects:_objects Guid:_guid];
    [self.tableView setEditing:NO animated:YES];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //Task *object2 = _objects[indexPath.row];
    //glbUuid = [object2 Guid];
    
    Task *object = _objects[indexPath.row];
    cell.textLabel.text = [object Title];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [WebAPI Delete: [_guid objectAtIndex:indexPath.row]];
        [_objects removeObjectAtIndex:indexPath.row];
        [_guid removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [WebAPI Get:self.tableView View:self.view WebserviceLabel:lblWebservice Objects:_objects Guid:_guid];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (void)NewTask
{
    // create a new task object
    Task *newTask = [[Task alloc] init];
    [newTask setTitle:@"New Task (Edit)"];
    [newTask setDescription:@"-"];
    [newTask setUuid:glbUuid];
    
    glbAssignedDate = [Formatting TodayDateFormatted];
    
    [newTask setAssignedDate:glbAssignedDate];
    [newTask setEstimatedDate:@"-"];
    [newTask setCompletedDate:@"-"];
    [newTask setStatus:@""];
    [newTask setImage:@""];
    [newTask setSignature:@""];
    
    [WebAPI Insert:_detailItem new:newTask ShowAlert:0];
}

@end
