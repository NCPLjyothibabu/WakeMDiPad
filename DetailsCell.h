//
//  DetailsCell.h
//  WakeMDiPad
//
//  Created by NCPL Inc on 02/06/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *VidName;
@property (weak, nonatomic) IBOutlet UILabel *VidDue;
@property (weak, nonatomic) IBOutlet UIImageView *vidImg;

@end
