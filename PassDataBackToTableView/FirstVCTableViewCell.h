//
//  FirstVCTableViewCell.h
//  PassDataBackToTableView
//
//  Created by Michael Hoffman on 7/28/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstVCTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;


@end
