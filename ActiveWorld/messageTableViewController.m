//
//  messageTableViewController.m
//  ActiveWorld
//
//  Created by Eric Cao on 10/16/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import "messageTableViewController.h"

@interface messageTableViewController ()

@end

@implementation messageTableViewController

@synthesize messageList;
- (void)viewDidLoad {
    [super viewDidLoad];

    messageList = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
   
    return  [messageArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    NSString *CellIdentifier = @"messageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Level:%@",[messageArray[indexPath.row] objectForKey:@"levelName"]];
    
    UIButton *levelIcon = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width * 250/320, 10, 60, 60)];
    [levelIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pic%d",[[messageArray[indexPath.row] objectForKey:@"levelNumber"] intValue]]] forState:UIControlStateNormal];
    [levelIcon addTarget:self action:@selector(jumpToLevel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *soundPlay = [[UIButton alloc] initWithFrame:CGRectMake(levelIcon.frame.origin.x - 70, levelIcon.frame.origin.y, 60, 60)];
    [soundPlay setTitle:@"PLAY" forState:UIControlStateNormal];
    [soundPlay setBackgroundColor:[UIColor grayColor]];
    soundPlay.tag = indexPath.row;
    [soundPlay addTarget:self action:@selector(playRecord:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [cell addSubview:soundPlay];
    [cell addSubview:levelIcon];
    

    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [messageArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Navigation logic may go here, for example:
//    // Create the next view controller.
//    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
//    [f setNumberStyle:NSNumberFormatterDecimalStyle];
//    
//    gameLevelController *messageFromGame = [[gameLevelController alloc] initWithNibName:@"gameLevelController" bundle:nil];
//    messageFromGame.levelNumber = [NSNumber numberWithInteger:[[messageArray[indexPath.row] objectForKey:@"levelNumber"] integerValue]];
//    
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    // Pass the selected object to the new view controller.
//    
//    // Push the view controller.
//    [self.navigationController pushViewController:messageFromGame animated:YES];
//}



#pragma mark - play record

-(void)playRecord:(UIButton *)btn
{
    NSString *URLstring = [messageArray[btn.tag] objectForKey:@"DIR"];
    NSURL *recordURL = [NSURL URLWithString:URLstring];
    
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recordURL error:nil];
//        NSLog(@"URL2:%@",recordURL);
        [btn setEnabled:NO];
        [player play];
    }
}

-(void)jumpToLevel:(UIButton *)btn
{
    NSString *levelString = [messageArray[btn.tag] objectForKey:@"levelNumber"];
    int level = [levelString intValue];
    
    gameLevelController *messageFromGame = [[gameLevelController alloc] initWithNibName:@"gameLevelController" bundle:nil];
    messageFromGame.levelNumber = [NSNumber numberWithInt:level];
    
    [self.navigationController pushViewController:messageFromGame animated:YES];
    
}

@end
