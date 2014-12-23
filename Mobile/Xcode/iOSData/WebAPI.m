 /*
 WebAPI.m
 iToDo
 
 Developed by Franz Ayestaran on 10/2/14.
 Copyright (c) 2014 Zonk Technology. All rights reserved.
  
 You may use this code in your own projects and upon doing so, you the programmer are solely
 responsible for determining it's worthiness for any given application or task. Here clearly
 states that the code is for learning purposes only and is not guaranteed to conform to any
 programming style, standard, or be an adequate answer for any given problem.
 */

#import "WebAPI.h"

@interface WebAPI ()

@end

@implementation WebAPI

NSString *WebAPIservice = @"https://secure.webapiservice.com:8080/todowebservice/api/ToDo/";

NSString *BasicAuthenticationCredentials = @"user:P455w0rd"; // <username:password>

+(NSString*)EncryptCredentials:(NSString *)UsernamePassword
{
    NSString *decodeString = UsernamePassword;
    //Encode String
    NSData *encodeData = [decodeString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [encodeData base64EncodedStringWithOptions:0];
    return base64String;
}

+(void)Get:(UITableView*)tableView View:(UIView*)view WebserviceLabel:(UILabel*)lblWebservice Objects:(NSMutableArray*)objects Guid:(NSMutableArray*)guid  Uuid:(NSString*)uuid
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [view addSubview:spinner];
    [spinner startAnimating];

    NSString *voiEncryptedCredentials = [self EncryptCredentials:BasicAuthenticationCredentials];
    NSLog(@"Encrypted Login: %@", voiEncryptedCredentials);

    // create HTTP request and download JSON from the service
    NSURL *url = [NSURL URLWithString:[WebAPIservice stringByAppendingString:uuid]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[@"Basic " stringByAppendingString:voiEncryptedCredentials] forHTTPHeaderField:@"Authorization"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        
        // parse the JSON into Foundation objects
        NSError* jsonError;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (json) {
            
            // convert Foundation objects into an array of Task objects
            for (NSDictionary* jsonDict in json) {
                
                Task *task = [[Task alloc] init];
                [task setGuid:[jsonDict objectForKey:@"Id"]];
                [task setTitle:[jsonDict objectForKey:@"Title"]];
                [task setDescription:[jsonDict objectForKey:@"Description"]];
                [task setUuid:[jsonDict objectForKey:@"Uuid"]];
                [task setAssignedDate:[jsonDict objectForKey:@"AssignedDate"]];
                [task setEstimatedDate:[jsonDict objectForKey:@"EstimatedDate"]];
                [task setCompletedDate:[jsonDict objectForKey:@"CompletedDate"]];
                [task setStatus:[jsonDict objectForKey:@"Status"]];
                [task setImage:[jsonDict objectForKey:@"Image"]];
                [task setStatus:[jsonDict objectForKey:@"Signature"]];
                
                
                [objects addObject:task];
                [guid addObject:[jsonDict objectForKey:@"Id"]];
                
            }
            
            // return to the main thread and update the table view
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [tableView reloadData];
                [spinner stopAnimating];
                lblWebservice.hidden = TRUE;
            });
        }
        else {
            NSLog(@"An error occurred: %@", jsonError);
            lblWebservice.hidden = FALSE;
            lblWebservice.textColor = [UIColor redColor];
            lblWebservice.text = @"Connection Error!";
        }
    }];
}

+ (void)Insert:(id)detailItem new:(Task*)voiTask ShowAlert:(int)voiShowAlert
{    
    // convert object to an NSData object containing JSON
    NSData *jsonData = [voiTask convertToJSONData];
   
    NSString *voiEncryptedCredentials = [self EncryptCredentials:BasicAuthenticationCredentials];
    NSLog(@"Encrypted Login: %@", voiEncryptedCredentials);

    // create an HTTP request to send JSON to the server
    
    NSString* urlFormatted = [NSString stringWithFormat:@"%@%@", WebAPIservice, [detailItem Guid]];
    
    NSURL *url = [NSURL URLWithString:urlFormatted];
	
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[@"Basic " stringByAppendingString:voiEncryptedCredentials] forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:jsonData];
    
    NSLog(@"URL Formatted: %@", urlFormatted);
    NSLog(@"URL: %@", url);
	
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        //
        //        // do something with the response here
        //
    }];
    
    // print JSON to the console
    [NSJSONSerialization logJSONWithData:jsonData label:@"New Task"];
    
    if (voiShowAlert == 1)
    {
    UIAlertView *UserAlert = [[UIAlertView alloc] initWithTitle:@"Add" message:@"Successful!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [UserAlert show];
    }
}

+ (void)Update:(id)detailItem new:(Task*)voiTask ShowAlert:(int)voiShowAlert
{
    // convert object to an NSData object containing JSON
    NSData *jsonData = [voiTask convertToJSONData];
    
    // create an HTTP request to send JSON to the server
    
    NSString *voiEncryptedCredentials = [self EncryptCredentials:BasicAuthenticationCredentials];
    NSLog(@"Encrypted Login: %@", voiEncryptedCredentials);

    NSString* urlFormatted = [NSString stringWithFormat:@"%@%@", WebAPIservice, [detailItem Guid]];
    
    NSURL *url = [NSURL URLWithString:urlFormatted];
	
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[@"Basic " stringByAppendingString:voiEncryptedCredentials] forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:jsonData];
    
    NSLog(@"URL Formatted: %@", urlFormatted);
    NSLog(@"URL: %@", url);
	
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        //
        //        // do something with the response here
        //
    }];
    
    // print JSON to the console
    [NSJSONSerialization logJSONWithData:jsonData label:@"New Task"];
    
    UIAlertView *UserAlert = [[UIAlertView alloc] initWithTitle:@"Update" message:@"Successful!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [UserAlert show];
}

+ (void)Delete:(NSString *)Guid
{
    NSString* urlFormatted = [NSString stringWithFormat:@"%@%@", WebAPIservice, Guid];

    // create an HTTP request to send JSON to the server
    
    NSString *voiEncryptedCredentials = [self EncryptCredentials:BasicAuthenticationCredentials];
    NSLog(@"Encrypted Login: %@", voiEncryptedCredentials);

    NSURL *url = [NSURL URLWithString:urlFormatted];
	
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"DELETE"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[@"Basic " stringByAppendingString:voiEncryptedCredentials] forHTTPHeaderField:@"Authorization"];
    
    NSLog(@"URL Formatted: %@", urlFormatted);
    NSLog(@"URL: %@", url);
	
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        //
        //        // do something with the response here
        //
    }];
}

@end
