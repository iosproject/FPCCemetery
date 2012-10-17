//
//  SearchViewController.m
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{    
    NSArray *tableData;
}
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@end

@implementation SearchViewController
@synthesize searchTableView = _searchTableView;
@synthesize searchBar = _searchBar;

-(void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context,0,0);
    CGContextAddLineToPoint(context,20,20);
    CGContextStrokePath(context);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    tableData = [NSArray arrayWithObjects:@"John Doe", @"Mushroom Risotto",  nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setSearchTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)getJsonData:(id)sender {
    //Connect to the JSON file on the server
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://131.125.78.212/result.json"]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    //Dictionary will be used to store the JSON data
    NSDictionary *data;
    if(jsonArray)
    {
        NSString *field = @"";
        //Check if the search is numeric
        if([self.searchBar.text intValue] > 0)
        {
            //If the number length is 4 then we are looking for a DOD of DOB
            //we are looking for an ID
            if(self.searchBar.text.length == 4)
            {
                //return DOD and DOB
                field = @"DOD";
            }
            else
            {
                //return ref or id
                field = @"Ref";
            }
            
            for(int i=0; i<[jsonArray count];i++)
            {
                data= [jsonArray objectAtIndex:i];
                NSString *fieldData = (NSString *)[data objectForKey:field];
                if(!([fieldData isKindOfClass:[NSNull class]]) && [SearchViewController regEx:self.searchBar.text:fieldData])
                {
                    NSLog(@"%@", fieldData);
                }
                
            }
        }
        else
        {
            for(int i=0; i<[jsonArray count];i++)
            {
                data= [jsonArray objectAtIndex:i];
                //[JSONTestViewController regEx:[data objectForKey:self.search.text]];
                NSString* firstName = (NSString*)[data objectForKey:@"FirstName"];
                NSString* lastName = (NSString*)[data objectForKey:@"LastName"];
                
                
                //If the first and last names are not null and match the search then display it
                //and add to the NSArray which is being returned
                if((!([firstName isKindOfClass:[NSNull class]])&&!([lastName isKindOfClass:[NSNull class]])) && ([SearchViewController regEx:self.searchBar.text: firstName] || [SearchViewController regEx:self.searchBar.text: lastName]))
                {
                    NSLog(@"%@ %2@", firstName, lastName);
                    
                }
                
            }
        }
        //convert to NSArray
        NSArray *dataArray = [data allValues];
    }
    else
    {
        NSLog(@"Could Not Retrieve Data");
    }

    + (BOOL)regEx:(NSString *)searchBar: (NSString *)toBeSearched
    {
        //The regular expression which is used to match the text in the search field
        NSString *regExStr = [@"(" stringByAppendingString:search];
        regExStr = [regExStr stringByAppendingString:@"(\\S)++)"];
        
        NSError* error = nil;
        NSRegularExpression* regex = [NSRegularExpression
                                      regularExpressionWithPattern:regExStr
                                      options:NSRegularExpressionCaseInsensitive
                                      error:&error];
        
        NSTextCheckingResult *regexResult = [regex firstMatchInString:toBeSearched options:0 range:NSMakeRange(0, [toBeSearched length])];
        
        //If the name matches the search text than return true
        if(regexResult)
        {
            return true;
        }
        return false;
    }
}
@end
