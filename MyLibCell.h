//
//  MyLibCell.h
//  WakeMDiPad
//
//  Created by NCPL Inc on 01/06/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLibCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *pakName;
@property (weak, nonatomic) IBOutlet UILabel *Duration;
@property (weak, nonatomic) IBOutlet UILabel *lessons;

@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;

@end
