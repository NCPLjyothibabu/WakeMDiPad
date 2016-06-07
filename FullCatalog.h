//
//  FullCatalog.h
//  WakeMDiPad
//
//  Created by NCPL Inc on 01/06/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
@interface FullCatalog : UIViewController <UITableViewDelegate,UITableViewDataSource,SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ImagePak;

@property (weak, nonatomic) IBOutlet UILabel *PakLable;

@property (weak, nonatomic) IBOutlet UILabel *titlePak;
@property (weak, nonatomic) IBOutlet UILabel *lessonsLable;
@property (weak, nonatomic) IBOutlet UILabel *duerationLable;
@property (weak, nonatomic) IBOutlet UITextView *shawnSaystext;
@property (weak, nonatomic) IBOutlet UITableView *FullCatTableView;
@property (weak, nonatomic) IBOutlet UITableView *DetailsTableView;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (strong, nonatomic) NSMutableArray *videoimagesarrayLib;
@property (strong, nonatomic) NSMutableArray *VideotitlearrayLib;
@property (strong, nonatomic) NSMutableArray *NameofPakarrayLib;
@property (strong, nonatomic) NSMutableArray *NumberoflessonsarrayLib;
@property (strong, nonatomic) NSMutableArray *DurationarrayLib;
@property UIRefreshControl* refreshControl;


- (IBAction)restore:(id)sender;
- (IBAction)SocialShare:(id)sender;

- (IBAction)MyLIbBtn:(id)sender;
- (IBAction)FullCatBtn:(id)sender;
- (IBAction)downloadOrPurchase:(id)sender;

@end
