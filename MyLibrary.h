//
//  MyLibrary.h
//  WakeMDiPad
//
//  Created by NCPL Inc on 01/06/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLibCell.h"
#import <Social/Social.h>
@interface MyLibrary : UIViewController <UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *myLibTableView;
@property (weak, nonatomic) IBOutlet UITableView *DetailsTableView;
@property int Index;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;
@property (weak, nonatomic) IBOutlet UILabel *DurationLable;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property(nonatomic,strong)NSMutableArray *Videonamesarray;
@property(nonatomic,strong)NSMutableArray *Paktitlearray;
@property(nonatomic,strong)NSMutableArray *Lessonsarray;
@property(nonatomic,strong)NSMutableArray *videodurationarr;
@property(nonatomic,strong)NSString *vimage;
@property(nonatomic,strong)NSMutableArray *savedPacks;
@property(nonatomic,strong)NSMutableArray *Videoimagesarray;
@property (weak, nonatomic) IBOutlet UILabel *VideoPlayNamelab;
@property (weak, nonatomic) IBOutlet UIView *VideoPlayerView;

- (IBAction)VideoBackBtn:(id)sender;

- (IBAction)socialShare:(id)sender;

- (IBAction)settings:(id)sender;

- (IBAction)PlayPause:(id)sender;
- (IBAction)forward:(id)sender;
- (IBAction)backward:(id)sender;

- (IBAction)nextVideo:(id)sender;
- (IBAction)PervVideo:(id)sender;

- (IBAction)TabMLibBtn:(id)sender;
- (IBAction)FullCatBtn:(id)sender;

@end
