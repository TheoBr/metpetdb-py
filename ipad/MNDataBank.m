//
//  MNDataBank.m
//  ImageMap
//
//  Created by Moo on 8/11/13.
//  Copyright (c) 2013 micmoo. All rights reserved.
//

#import "MNDataBank.h"
#import "MNPointDetail.h"

@interface MNDataBank ()

@end

@implementation MNDataBank

- (id)initWithData:(NSMutableDictionary *)data{
    self = [super init];
    
    [self setData:data];
    
    NSLog(@"InitWIthStyle %@", data);

    
    //d_data = [[NSMutableDictionary alloc] init];
    //a_data = [[NSMutableArray alloc] init];
    return self;
    
}

- (void)setData:(NSMutableDictionary *)data{
    for (id o in data){
        [samples setObject:[[NSMutableArray alloc] initWithArray:[data objectForKey:o]] forKey:o];
      //  [samples setObject:object forKey:o];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    samples = [[NSMutableDictionary alloc] init];
    queue  = [[NSMutableArray alloc] init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [samples count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == [samples count]) {     NSLog(@"Section: %d, rows: %d", section,[queue count]);
return [queue count];  }
    NSLog(@"Section: %d, rows: %d", section,[[[samples allValues] objectAtIndex:section] count]);

    return [[[samples allValues] objectAtIndex:section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    id pointN = [[[[samples allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"pointnumber"];
    
    cell.textLabel.text = [pointN stringValue];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    if (indexPath.section == [samples count]){ cell.showsReorderControl = true; }
    [cell addGestureRecognizer:longPress];

    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSLog(@"HEllo??");

    id ob = [[[samples allValues] objectAtIndex:fromIndexPath.section] objectAtIndex:fromIndexPath.row];
    [queue addObject:ob];
    [[[samples allValues] objectAtIndex:fromIndexPath.section] removeObject:ob];
    
    NSLog([queue description]);
    NSLog([[[samples allValues] objectAtIndex:fromIndexPath.section] description]);
    
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [samples count]) return NO;
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    UIViewController *pdvc = [[UIViewController alloc] initWithNibName:@"pointDetail" bundle:[NSBundle mainBundle]];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,100)];
    l.text = @"Test";
    [[pdvc view] addSubview:l];
    popover = [[UIPopoverController alloc] initWithContentViewController:pdvc];
    
    CGRect aFrame = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    [popover presentPopoverFromRect:[self.tableView convertRect:aFrame toView:self.view] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    
    
    NSLog(@"%@", [[[samples allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
}

-(void) handleLongPress: (UIGestureRecognizer *)longPress {
    if (longPress.state==UIGestureRecognizerStateBegan) {
        [self.tableView beginUpdates];
        CGPoint pressPoint = [longPress locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:pressPoint];

        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:[queue count] inSection:[samples count]]];
        id ob = [[[samples allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [queue addObject:ob];
        [[[samples allValues] objectAtIndex:indexPath.section] removeObject:ob];
        [self.tableView endUpdates];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    if (section == [samples count]) { return @"Queue"; }
    return [[samples allKeys] objectAtIndex:section];
}


@end
