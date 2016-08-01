//
//  SecondViewController.m
//  PassDataBackToTableView
//
//  Created by Michael Hoffman on 7/27/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *selectionLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property NSArray *heroes;

- (IBAction)chooseTapped:(id)sender;
- (IBAction)backTapped:(id)sender;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.heroes = @[@"Cyborg", @"Flash", @"Jubilee", @"Storm", @"Manhunter", @"Falcon", @"Speedy", @"Guardian", @"Bouncing Boy", @"Captain Britain"];
    
    //Experiment: switch-case uses the selected row value to execute a condition.
    //Using the elipses tells the case to use the numbers "to ... from" inclusively, so 0 ... 3 is the same as 0, 1, 2, and 3.
    switch (self.selectedRow)
    {
        case 0 ... 3:
            self.selectionLabel.backgroundColor = [UIColor redColor];
            break;
        case 6 ... 8:
            self.selectionLabel.backgroundColor = [UIColor blueColor];
            break;
            
        default:
            break;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseTapped:(id)sender
{
    //self.randNumber = self.selectedRow;
    self.hero = [self.heroes objectAtIndex:self.selectedRow];
    self.selectionLabel.text = self.hero;
}

- (IBAction)backTapped:(id)sender
{
    [self performSegueWithIdentifier:@"unwindSecondVC" sender:self];
}













@end
