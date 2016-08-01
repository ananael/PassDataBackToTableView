//
//  ThirdViewController.m
//  PassDataBackToTableView
//
//  Created by Michael Hoffman on 7/27/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@property (weak, nonatomic) IBOutlet UILabel *selectionLabel;
@property (weak, nonatomic) IBOutlet UIButton *scoreButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property NSArray *gameScores;
@property NSInteger randomScore;

- (IBAction)scoreTapped:(id)sender;
- (IBAction)backTapped:(id)sender;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.gameScores = @[@100, @200, @300, @400, @500, @150, @250, @350, @450, @550];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)scoreTapped:(id)sender
{
    self.randomScore = arc4random_uniform((u_int32_t)[self.gameScores count]);
    self.score = [self.gameScores objectAtIndex:self.randomScore];
    self.selectionLabel.text = [NSString stringWithFormat:@"%@", self.score];
}

- (IBAction)backTapped:(id)sender
{
    [self performSegueWithIdentifier:@"unwindThirdVC" sender:self];
}












@end
