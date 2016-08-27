//
//  FirstViewController.m
//  PassDataBackToTableView
//
//  Created by Michael Hoffman on 7/27/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstVCTableViewCell.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property NSMutableArray *fruits;
@property NSMutableArray *openingScores;
@property NSMutableArray *levelScores;
@property NSInteger unlockValue;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //Removes unused cells from tableView.
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    //self.unlockValue = 0;
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"unlockedLevel"];
    
    self.fruits = [NSMutableArray arrayWithObjects:@"apple", @"orange", @"banana", @"lime", @"prune", @"lemon", @"pear", @"cantelope", @"blueberry", @"grape", nil];
    
    self.openingScores = [NSMutableArray arrayWithObjects:@0, @0, @0, @0, @0, @0, @0, @0, @0, @0, nil];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// **********  VERY IMPORTANT TO UPDATE TABEVIEW ON RETURN!! **********
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

-(UIColor*)colorWithHexString:(NSString*)hex alpha:(CGFloat)alpha
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.openingScores count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 FirstVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
 
 // Configure the cell...
    
    cell.backgroundColor = [UIColor clearColor];
    cell.cellView.backgroundColor = [self colorWithHexString:@"FFFFFF" alpha:0.5];
    cell.levelLabel.text = [NSString stringWithFormat:@"%@", self.openingScores[indexPath.row]];
    
//    if (self.levelScores == nil)
//    {
//        cell.levelLabel.text = [NSString stringWithFormat:@"%@", self.openingScores[indexPath.row]];
//    } else
//    {
//        cell.levelLabel.text = [NSString stringWithFormat:@"%@", self.levelScores[indexPath.row]];
//    }
    
    //Makes the cell nonresponsive until the unlockValue changes.
    //The userDefault value is initially set at "0" in viewDidLoad, so that the first cell is enabled.
    //The userDefault value is increased in new VC.
    cell.userInteractionEnabled = NO;
    
    if (indexPath.row <= [[NSUserDefaults standardUserDefaults]integerForKey:@"unlockedLevel"])
    {
        cell.userInteractionEnabled = YES;
    }
 
 return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // *** Specifies which cell will segue to ThirdVC while all the other cells segue to SecondVC. ***
    //When there are 2 (or more) segues tht the tableViewCells have to respond to, DO NOT create a Storyboard segue from the tableViewCell to the next VC, as you normally would do.
    //Instead, command-drag from the FirstVC's object navigator to the SecondVC and name the segue as normal. Repeat for segue to ThirdVC.
    //Doing this will prevent a second viewDidLoad call on the SecondVC when trying to segue to the ThirdVC.
    if (indexPath.row == 4)
    {
        [self performSegueWithIdentifier:@"thirdVCSegue" sender:self];
        
    } else
    {
        [self performSegueWithIdentifier:@"secondVCSegue" sender:self];
    }
    
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     //Uses the segue to call the appropriate VC then send selectedPath.row as an integer (it represents the index of the array object to be replaced)
     if ([segue.identifier isEqualToString:@"secondVCSegue"])
     {
         SecondViewController *secondVC = segue.destinationViewController;
         NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
         NSLog(@"Selected Path = %lu", (long)selectedPath.row);
         secondVC.selectedRow = selectedPath.row;
     }
     
     if ([segue.identifier isEqualToString:@"thirdVCSegue"])
     {
         ThirdViewController *thirdVC = segue.destinationViewController;
         NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
         NSLog(@"Selected Path = %lu", (long)selectedPath.row);
         thirdVC.selectedRow = selectedPath.row;
     }
     
 }
 

-(IBAction)returnToMainVC:(UIStoryboardSegue *)unwindSegue
{
    //The unwind segue sends back the selectedPath.row integer originally pushed to the SecondVC or ThirdVC so that the correct tableView cell (that initiated the push) will receive the replacement object.
    if ([unwindSegue.identifier isEqualToString:@"unwindSecondVC"])
    {
        SecondViewController *secondVC = unwindSegue.sourceViewController;
        
        NSLog(@"Number = %ld\nHero = %@", (long)secondVC.selectedRow, secondVC.hero);
        
        [self.openingScores replaceObjectAtIndex:secondVC.selectedRow withObject:secondVC.hero];
        
    } else if ([unwindSegue.identifier isEqualToString:@"unwindThirdVC"])
    {
        ThirdViewController *thirdVC= unwindSegue.sourceViewController;
        
        NSLog(@"Number = %ld\nScore = %@", (long)thirdVC.selectedRow, thirdVC.score);
        
        //This allows me to change the player's level score ONLY if the new value is higher than the old value.
        if (thirdVC.score > [self.openingScores objectAtIndex:thirdVC.selectedRow])
        {
            [self.openingScores replaceObjectAtIndex:thirdVC.selectedRow withObject:thirdVC.score];
        }
    }
    
}





@end
