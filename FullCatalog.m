//
//  FullCatalog.m
//  WakeMDiPad
//
//  Created by NCPL Inc on 01/06/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "FullCatalog.h"
#import <AWSCore/AWSCore.h>
#import <AWSS3/AWSS3.h>
#import <AWSDynamoDB/AWSDynamoDB.h>
#import <AWSSQS/AWSSQS.h>
#import <AWSSNS/AWSSNS.h>
#import <AWSCognito/AWSCognito.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MyLibCell.h"
#import "DetailsCell.h"
#import <Social/Social.h>
@interface FullCatalog ()
@property NSMutableArray *nestedArray;
@property NSMutableArray *currDueArray;
@property NSArray * CArray;
@property NSArray *ShawnSays;
@property int count;
@property NSString *Quality;
@property UIView *loadingView;
@property UILabel *loadingLabel;
@property int index;
@property UIActivityIndicatorView *activityView;
@property NSMutableArray* VidDueArray;
@property NSArray* InAppList;
@property NSMutableArray * Plist;
@property NSMutableArray *PriceArray;
@property(strong, nonatomic) SKPaymentQueue* sKPaymentQueue;
@end

@implementation FullCatalog
@synthesize loadingView,activityView,nestedArray,VidDueArray,VideotitlearrayLib,videoimagesarrayLib,DurationarrayLib,NameofPakarrayLib,NumberoflessonsarrayLib,refreshControl,sKPaymentQueue;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self gettingRequiredData];
    _DetailsTableView.delegate = self;
    _DetailsTableView.dataSource =self;
     self.PriceArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"$1.99",@"$2.99",@"$2.99",@"$2.99",@"$1.99",@"$3.99",@"$1.99",@"$1.99",@"$2.99",@"$2.99",@"$1.99",@"$2.99",@"3.99",@"$2.99",@"$2.99",@"$1.99", nil];
    
    refreshControl  = [[UIRefreshControl alloc]init];
    [self.FullCatTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"Plist"]){
        NSMutableArray *Plist = [[NSMutableArray alloc]initWithObjects:@"free",@"free",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no", nil];
        [[NSUserDefaults standardUserDefaults]setObject:Plist forKey:@"Plist"];
    }else{
        self.Plist = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Plist"]];
    }
}
-(void)refreshTable{
    [refreshControl endRefreshing];
    [_FullCatTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [pathArray lastObject];
    NSLog(@"Saved Video Url Is : %@",documentsDirectory);
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"Plist"]){
        NSMutableArray *Plist = [[NSMutableArray alloc]initWithObjects:@"free",@"free",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no", nil];
        [[NSUserDefaults standardUserDefaults]setObject:Plist forKey:@"Plist"];
    }else{
        self.Plist = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Plist"]];
    }
    NSLog(@"Plist in Fll cata is :%@",self.Plist);
    [_FullCatTableView reloadData];
    
    NSLog(@"Plist is :%@",self.Plist);
    if ([self.Plist[self.index] isEqualToString:@"free"]||[self.Plist[self.index] isEqualToString:@"yes"]) {
        [self.downBtn setTitle:@"Download" forState:UIControlStateNormal];
    } else {
        [self.downBtn setTitle:@"Buy" forState:UIControlStateNormal];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)restore:(id)sender {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}
- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"received restored transactions: %lu", (unsigned long)queue.transactions.count);
    NSLog(@"restored transactions are %@",queue.transactions);
    for(SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            //called when the user successfully restores a purchase
            NSLog(@"Transaction stateof %@ -> Restored",transaction.payment.productIdentifier);
            
            //if you have more than one in-app purchase product,
            //you restore the correct product for the identifier.
            //For example, you could use
            //if(productID == kRemoveAdsProductIdentifier)
            //to get the product identifier for the
            //restored purchases, you can use
            //
            NSString *productID = transaction.payment.productIdentifier;
            //            [self doRemoveAds];
            // [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            // break;
            for (int i=0; i<self.InAppList.count; i++) {
                if ([productID isEqualToString:self.InAppList[i]]) {
                    self.Plist[i] = @"yes";
                    [[NSUserDefaults standardUserDefaults]setObject:self.Plist forKey:@"Plist"];
                    //[catalogtableview reloadData];
                    
                    //break;
                }
            }
            
            [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
            [_FullCatTableView reloadData];
            [self stopSpinning];
        }
    }
    
}
- (IBAction)SocialShare:(id)sender {
    NSLog(@" List Of videos :%@",self.CArray);
    //[self downloadprocessVedioName:self.CArray[0]];
    
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share Wake MD"
                                                                 delegate:self
                                                        cancelButtonTitle:@"cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Facebook", @"Twitter", nil];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // In this case the device is an iPad.
            [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
        }
        else{
            // In this case the device is an iPhone/iPod Touch.
            [actionSheet showInView:self.view];
        }
        
        actionSheet.tag = 300;
        
   
  
}

- (IBAction)MyLIbBtn:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)FullCatBtn:(id)sender {
    [self.tabBarController setSelectedIndex:1];
}

- (IBAction)downloadOrPurchase:(id)sender {
    if ([self.Plist[self.index] isEqualToString:@"free"]||[self.Plist[self.index] isEqualToString:@"yes"]) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Wake MD"
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Download Hi Res", @"Download Medium Res",@"Download Low Res", nil];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // In this case the device is an iPad.
            [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
        }
        else{
            // In this case the device is an iPhone/iPod Touch.
            [actionSheet showInView:self.view];
        }
        
        actionSheet.tag = 300;
    } else{
        [self paymentinapppurchase];
        
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.FullCatTableView) {
        return videoimagesarrayLib.count;
    }else if(tableView == self.DetailsTableView){
        return self.CArray.count;
        
    }
    else{return 0;}
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.FullCatTableView) {
        NSString *identifier = @"FCCell";
        MyLibCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if(cell==nil){
            cell = [[MyLibCell alloc]init];
        }
        [cell.Image.layer setBorderColor:[[UIColor blackColor]CGColor]];
        [cell.Image.layer setBorderWidth:0.8];
        
        cell.Image.image = [UIImage imageNamed:[videoimagesarrayLib objectAtIndex:indexPath.row]];
        cell.title.text = [VideotitlearrayLib objectAtIndex:indexPath.row];
        cell.pakName.text =[NameofPakarrayLib objectAtIndex:indexPath.row];
        cell.lessons.text = [NumberoflessonsarrayLib objectAtIndex:indexPath.row];
        cell.Duration.text = [DurationarrayLib objectAtIndex:indexPath.row];
        
        if ([self.Plist[indexPath.row] isEqualToString:@"yes"]) {
            cell.arrowImg.image = [UIImage imageNamed:@"004 2732x2048_WakeMDiPad_Mycatalog_arrow 3.png"];
            
        }else {
            cell.arrowImg.image = [UIImage imageNamed:@"004 2732x2048_WakeMDiPad_Mycatalog_arrow 2.png"];
        }
        
        return cell;
        
    }
    else if( tableView == self.DetailsTableView){
        
        NSString *Idenf =@"cell";
        DetailsCell *dCell = [tableView dequeueReusableCellWithIdentifier:Idenf];
        
        if (dCell==nil) {
            dCell = [[DetailsCell alloc ]init];
        }
        dCell.VidName.text = [NSString stringWithFormat:@"%@",[self.CArray objectAtIndex:indexPath.row]];
        dCell.VidDue.text = [NSString stringWithFormat:@"%@",[self.currDueArray objectAtIndex:indexPath.row]];
        if ( [self.Plist[self.index] isEqualToString:@"yes"]) {
            dCell.vidImg.image = [UIImage imageNamed:@"004 2732x2048_WakeMDiPad_Mycatalog_arrow 3.png"];
            
        }else {
            dCell.vidImg.image = [UIImage imageNamed:@"004 2732x2048_WakeMDiPad_Mycatalog_arrow 2.png"];
        }
        return dCell;
    }else{return nil;}

    
//    if (cell==nil)
//    {
//        cell = [[Pakslistcell alloc]init];}
    
  
    
    
    //cell.introductionlab.text = [self.CArray objectAtIndex:indexPath.row];
  
   // cell.durlabel.text =[self.currDueArray objectAtIndex:indexPath.row];
    
    //    [cell.downloadbutton setTitle:@"Download" forState:UIControlStateNormal];
    //    [cell.downloadbutton addTarget:self action:@selector(downloadvideo) forControlEvents:UIControlEventTouchUpInside];
    // cell.introductionlab.text =@"Introduction";
    
   // cell.videopic.image = [UIImage imageNamed:@"004 1242x2208_WakeMD_Video_list icon.png"];
    
    
    
    
    //    if (self.indexvalues2 ==0)
    //    {
    //        cell.introductionlab.text = [introvideoarray objectAtIndex:indexPath.row];
    //    }
    //    else
    //    {
    //        cell.introductionlab.text = [wakeboardingarray objectAtIndex:indexPath.row];
    //    }
    
    // [cell.videopic.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    //[cell.videopic.layer setBorderWidth:0.8];
    
    
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.FullCatTableView) {
       // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
         //   dispatch_sync(dispatch_get_main_queue(), ^(void) {
            self.titlePak.text =[NSString stringWithFormat:@"%@",[VideotitlearrayLib objectAtIndex:indexPath.row]];
        self.PakLable.text = [NSString stringWithFormat:@"%@",[NameofPakarrayLib objectAtIndex:indexPath.row]];
        self.lessonsLable.text = [NSString stringWithFormat:@"%@",[NumberoflessonsarrayLib objectAtIndex:indexPath.row]];
        self.duerationLable.text = [NSString stringWithFormat:@" Duration : %@",[DurationarrayLib objectAtIndex:indexPath.row]];
        self.ImagePak.image =[UIImage imageNamed:[videoimagesarrayLib objectAtIndex:indexPath.row]];
        self.index = indexPath.row;

        NSLog(@"Selected Array in Selected %@",self.CArray );
        if (self.CArray!=NULL) {
            self.CArray = NULL;
            self.currDueArray =NULL;
            self.CArray =[[NSArray alloc]initWithArray:nestedArray[indexPath.row]];
            self.currDueArray =[[NSMutableArray alloc]initWithArray:VidDueArray[indexPath.row]];
    NSLog(@"Selected Array in Selected after nullified %@",self.CArray );
            NSLog(@"SLECTED Due array; %@",self.currDueArray);
        }
        NSLog(@"Plist is :%@",self.Plist);
        if ([self.Plist[indexPath.row] isEqualToString:@"free"]||[self.Plist[indexPath.row] isEqualToString:@"yes"]) {
            [self.downBtn setTitle:@"Download" forState:UIControlStateNormal];
        } else {
            [self.downBtn setTitle:@"Buy" forState:UIControlStateNormal];
        }
        self.priceLable.text = [self.PriceArray objectAtIndex:indexPath.row];
        self.shawnSaystext.text = [ self.ShawnSays objectAtIndex:indexPath.row];
            [_DetailsTableView reloadData];
           // });
 
       // });
    }else{
        
    }
}
-(void)downloadvideo
{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex!=-1) {
        
    
    NSString *buttontitle=[actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttontitle isEqualToString:@"Download Hi Res"])
    {
        NSLog(@"Butten pressed is: %@",buttontitle);
        self.Quality = @".mov";
        [self downloadprocessVedioName:self.CArray];
    }
    else if ([buttontitle isEqualToString:@"Download Medium Res"])
    {
        NSLog(@"Butten pressed is: %@",buttontitle);
        self.Quality = @"-standard.mov";
        [self downloadprocessVedioName:self.CArray];
    }
    else if ([buttontitle isEqualToString:@"Download Low Res"])
    {
        NSLog(@"Butten pressed is: %@",buttontitle);
        self.Quality = @"-lowres.mov";
        [self downloadprocessVedioName:self.CArray];
        
    }else if ([buttontitle isEqualToString:@"Facebook"])
    {
        NSLog(@"Butten pressed is: %@",buttontitle);
        [self Facebook];
        
    }else if ([buttontitle isEqualToString:@"Twitter"])
    {
        NSLog(@"Butten pressed is: %@",buttontitle);
        [self Twitter];
    }
    }else{
        [actionSheet cancelButtonIndex];
    }
}
-(void)downloadprocessVedioName:(NSArray*)Name
{
    
    //[activityView startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            //UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
            self.count=0;
            self.loadingLabel.text=[NSString stringWithFormat:@"%d/%lu Downloading",self.count,(unsigned long)Name.count];
            [self StartSpinning];
            
            NSLog(@"vedios Queued to Download are :%@",Name);
        });
        
        
        
        for (int i=0; i<Name.count; i++) {
            
            
            
            // [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(AddtoArray) userInfo:nil repeats:YES];
            
            //    NSURL*url=[NSURL URLWithString:@"wakemd-iphone-videos.s3.amazonaws.com"];
            //    AWSEndpoint*endpoint=[[AWSEndpoint alloc]initWithRegion:AWSRegionUSWest2 service:AWSServiceS3 URL:url];
            NSString * name = [NSString stringWithFormat:@"%@.mov",Name[i]];
            // NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"GettingIntoTheWater-lowres.mov"];
            NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
            // NSString *homeDir = [NSHomeDirectory() stringByAppendingString:name];
            
            // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSArray * paths = NSSearchPathForDirectoriesInDomains (NSLibraryDirectory,NSUserDomainMask, YES);
            NSString * documentsDirectory = [paths objectAtIndex:0];
            NSError * error;
            if (![[NSFileManager defaultManager] fileExistsAtPath: documentsDirectory])
            {
                [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&error];
            }
            //NSString *libraryDirectory = [paths objectAtIndex:0];
            //NSString *LibDirStgPath = [libraryDirectory stringByAppendingString:name];
            
            NSLog(@" Temp Path is :%@",downloadingFilePath);
            
            AWSS3TransferManager *transferManager = [AWSS3TransferManager S3TransferManagerForKey:@"USWest2S3TransferManager"];
            
            
            NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
            
            AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
            if (self.index==0) {
                downloadRequest.bucket = @"wakemd-iphone-videos/Videos/Intro";
                downloadRequest.key = name;
                
            }else if (self.index==1) {
                downloadRequest.bucket = @"wakemd-iphone-videos/Videos/Free Pak";
                downloadRequest.key = name;
            } else {//if(self.index<17){
                NSString *pkstrng = [NSString stringWithFormat:@"wakemd-iphone-videos/Videos/Pak %d",self.index-1];
                //downloadRequest.bucket = @"wakemd-iphone-videos/Videos/Free Pak";
                NSLog(@" In AWS Bucketpath %@ and File Name %@",pkstrng, name);
                downloadRequest.bucket = pkstrng;
                if (![self.Quality isEqualToString:@""]) {
                    
                    
                    //downloadRequest.key = @"GettingIntoTheWater-lowres.mov";
                    NSString *KeyName = [NSString stringWithFormat:@"%@%@",Name[i],self.Quality];
                    downloadRequest.key = KeyName;
                }else{
                    NSString *KeyName = [NSString stringWithFormat:@"%@-lowres.mov",Name[i]];
                    downloadRequest.key = KeyName;
                }
                
            }
            
            downloadRequest.downloadingFileURL = downloadingFileURL;
            // self.txtLabel.text = @"Download started, please wait...";
            [[transferManager download:downloadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
             
                                                                   withBlock:^id(AWSTask *task) {
                                                                       //[activityView startAnimating];
                                                                       if (task.error){
                                                                           if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                               switch (task.error.code) {
                                                                                   case AWSS3TransferManagerErrorCancelled:
                                                                                   case AWSS3TransferManagerErrorPaused:
                                                                                       break;
                                                                                       
                                                                                   default:
                                                                                       NSLog(@"Error: %@", task.error);
                                                                                       break;
                                                                               }
                                                                           } else {
                                                                               // Unknown error.
                                                                               NSLog(@"Error: %@", task.error);
                                                                               if (i==Name.count-1) {
                                                                                   //    dispatch_sync(dispatch_get_main_queue(), ^(void) {
                                                                                   [self stopSpinning];
                                                                                   //                                                                           [self performSelector:@selector(stopSpinning) withObject:self afterDelay:5];
                                                                                   UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Wake MD" message:@"Please check your Internet connection" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                                                                                   [al show];
                                                                                   // });
                                                                                   
                                                                               }
                                                                           }
                                                                       }
                                                                       
                                                                       if (task.result) {
                                                                           AWSS3TransferManagerDownloadOutput *downloadOutput = task.result;
                                                                           self.count++;
                                                                           if (self.count==Name.count) {
                                                                               self.loadingLabel.text=[NSString stringWithFormat:@"%d/%lu Downloading",self.count,(unsigned long)Name.count];
                                                                               NSLog(@"completed downloads : %dform total:%lu ",self.count,(unsigned long)Name.count);
                                                                               // dispatch_sync(dispatch_get_main_queue(), ^(void) {
                                                                               
                                                                               NSLog(@"completed downloads : %dform total:%lu ",self.count,(unsigned long)Name.count);
                                                                               [self stopSpinning];
                                                                               [self showAlert:@"Download completed"];
                                                                               
                                                                               [[NSUserDefaults standardUserDefaults]setInteger:self.index forKey:@"index"];
                                                                               // });
                                                                           }else{
                                                                               NSLog(@"completed downloads : %dform total:%lu ",self.count,(unsigned long)Name.count);
                                                                               self.loadingLabel.text=[NSString stringWithFormat:@"%d/%lu Downloading.",self.count,(unsigned long)Name.count];
                                                                           }
                                                                           
                                                                           NSLog(@"download output of %@ is %@",Name[i],downloadOutput);
                                                                           [[NSUserDefaults standardUserDefaults] setURL:downloadOutput.body forKey:@"Down"];
                                                                           NSLog(@" In Obj :%@ ",downloadOutput.body);
                                                                           // NSString*path= [NSString stringWithFormat:@"%@",downloadOutput.body];
                                                                           // Saving to NSMoviesDirectory
                                                                           [[NSFileManager defaultManager] copyItemAtPath:downloadOutput.body toPath:[documentsDirectory stringByAppendingPathComponent:name] error:nil];
                                                                           NSLog(@" File is Saved in else %@",documentsDirectory);
                                                                           NSArray *directoryContent = [[NSFileManager defaultManager] directoryContentsAtPath: documentsDirectory];
                                                                           NSLog(@" contents of file %@",directoryContent);
                                                                           
                                                                           
                                                                           //self.down = downloadOutput;
                                                                           NSString *filePath = [documentsDirectory stringByAppendingPathComponent:name];
                                                                           //[SavedVid addObject:filePath];
                                                                           
                                                                           NSURL* captured = [NSURL fileURLWithPath:filePath];
                                                                           
                                                                           
                                                                           //NSString *Vlist = [NSString stringWithFormat:@"Pak %d",self.index];
                                                                           //[[NSUserDefaults standardUserDefaults]setObject:SavedVid forKey:Vlist];
                                                                           
                                                                           NSLog(@" Sedning Index is %d",self.index);
                                                                           //File downloaded successfully.
                                                                       }
                                                                       return nil;
                                                                   }];
            
        }
    });//end of Global Thread,
    
}

-(void)CreateActivityView{
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y,150,150)];
    
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(55, 40, activityView.bounds.size.width, activityView.bounds.size.height);
    //cgrectma
    loadingView.center = activityView.center;
    [loadingView addSubview:activityView];
    self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 110, 130, 22)];
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.textColor = [UIColor whiteColor];
    self.loadingLabel.adjustsFontSizeToFitWidth = YES;
    self.loadingLabel.textAlignment = UITextAlignmentCenter;
    self.loadingLabel.text = @"Downloading";
    [loadingView addSubview:self.loadingLabel];
}
-(void)StartSpinning{
    loadingView.center = self.view.center;
    [self.view addSubview:loadingView];
    [activityView startAnimating];
}
-(void)stopSpinning{
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
}
-(void)gettingRequiredData{
    self.titlePak.text = @"Intorduction";
    self.PakLable.text = @"starter pak";
    self.lessonsLable.text = @"1 lesson";
    self.duerationLable.text = @" Duration : 00:00:45";
    self.ImagePak.image =[UIImage imageNamed:@"Shaun.png"];
    self.index =0;
    // NSString * js =@"{(GettingIntoTheWater,GettingIntoYourBindings,GettingUp,TakingYourBinding),(BoardControl,BodyPosition,FlippingOver,GettingUpProStyle,ShorteningTheRope,WakeboardTerms)}";
    
    //NSMutableDictionary *dict=[NSJSONSerialization JSONObjectWithData:[js dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
   NSArray* introvideoarray = [NSArray arrayWithObjects:@"Intro",nil];
   NSArray* wakeboardingarray = [NSArray arrayWithObjects:@"GettingIntoTheWater",@"GettingIntoYourBindings",@"GettingUp",@"TakingYourBindingsOff",nil];
    
    nestedArray = [[NSMutableArray alloc]init];
    NSArray *pak1 = [[NSArray alloc]initWithObjects:@"GettingUpProStyle",@"FlippingOver",@"ShorteningTheRope",@"BodyPosition",@"BoardControl",@"WakeboardTerms", nil];
    NSArray *pak2 = [[NSArray alloc]initWithObjects:@"SideSlide",@"GettingBackInsideTheWakeTS",@"GettingOutsideTheWakeTS",@"TSWakesurfingRhythm", @"GettingOutsideTheWakeHS",@"HSWakesurfing", nil];
    NSArray *pak3 = [[NSArray alloc]initWithObjects:@"GoingOverRollers",@"Ollies",@"OlliesOverRollers",@"PowerSlide",@"LipSlidesButterSlides", nil];
    NSArray *pak4 = [[NSArray alloc]initWithObjects:@"CrossingTheWakes",@"SingleWakeJumpShortApproach",@"SingleWakeJumpLongApproach",@"HSWakeToWakeJump", nil];
    NSArray *pak5 = [[NSArray alloc]initWithObjects:@"Re-entryAir",@"GrabbingYourTricks-GraphicOfDifferentGrabs",@"HittingTheDoubleUp", nil];
    NSArray *pak6 = [[NSArray alloc]initWithObjects:@"180sFS",@"Ollie180s",@"WakeToWakeTS180",@"PowerslideBS180",@"OlliesBS180",@"SingleWakeBS180",@"WakeToWakeBS180",@"WakeToWakeHS180", nil];
    NSArray *pak7 = [[NSArray alloc]initWithObjects:@"FS360Techniques",@"HSFs360",@"TSFS360",@"GrabbingYourSpins",@"HSBS360", nil];
    NSArray *pak8 = [[NSArray alloc]initWithObjects:@"HSFS540",@"TSFS540",@"TSBS180", nil];
    NSArray *pak9 = [[NSArray alloc]initWithObjects:@"HSBackroll",@"HSFrontrollNotATrick",@"Tantrum",@"TSBackroll",@"TSFrontroll",@"HSFrontFlip", nil];
    NSArray *pak10 = [[NSArray alloc]initWithObjects:@"HSRollToReMaltOMeal",@"TSBackrollToRev",@"TantrumToFakie",@"Scarecrow", nil];
    NSArray *pak11 = [[NSArray alloc]initWithObjects:@"TSRaley",@"HSRaley",@"GrabbingYourInverts", nil];
    NSArray *pak12 = [[NSArray alloc]initWithObjects:@"IndyTSBackroll",@"GrabbingTheTantrum",@"HSFrontToFakie",@"HSRollToBlind",@"TantrumToBlind",@"TootsieRoll", nil];
    NSArray *pak13 = [[NSArray alloc]initWithObjects:@"WhirlyBird",@"MobyDick",@"CrowMobe",@"WrappedKGB",@"HandlePassKGB",@"PeteRose",@"HSMobe",@"Whirly5",@"Crow5", nil];
    NSArray *pak14 = [[NSArray alloc]initWithObjects:@"OAHSFS360",@"OATSFS360",@"OAHSFS540",@"OATSFS540",@"HSBS5ShouldBeIn15",nil];
    NSArray *pak15 = [[NSArray alloc]initWithObjects:@"TSBS360",@"OAHSBS180",@"OAHSBS360",@"OAHSFS720",@"OATSFS7",@"OATSFS9", nil];
    NSArray *pak16 = [[NSArray alloc]initWithObjects:@"HSKrypt",@"TSKrypt",@"GlidesIndy",@"BlindJudge-HSRaleyBS180",@"313",@"TheName313",@"TumbleTurn-WormTurnTurtleSpin", nil];
    
    
    [nestedArray addObject:introvideoarray];
    [nestedArray addObject:wakeboardingarray];
    [nestedArray addObject:pak1];
    [nestedArray addObject:pak2];
    [nestedArray addObject:pak3];
    [nestedArray addObject:pak4];
    [nestedArray addObject:pak5];
    [nestedArray addObject:pak6];
    [nestedArray addObject:pak7];
    [nestedArray addObject:pak8];
    [nestedArray addObject:pak9];
    [nestedArray addObject:pak10];
    [nestedArray addObject:pak11];
    [nestedArray addObject:pak12];
    [nestedArray addObject:pak13];
    [nestedArray addObject:pak14];
    [nestedArray addObject:pak15];
    [nestedArray addObject:pak16];
    
    self.CArray =[[NSArray alloc]initWithArray:nestedArray[self.index]];
    NSLog(@"Nested array %@",nestedArray);
    NSLog(@"Selected array %@",self.CArray);
    
    VidDueArray= [[NSMutableArray alloc]init];
    NSArray *Inte= [[NSArray alloc]initWithObjects:@"00:00:46", nil];
    NSArray *free2= [[NSArray alloc]initWithObjects:@"00:00:47",@"00:01:30",@"00:05:20",@"00:01:43", nil];
    NSArray *Pak1= [[NSArray alloc]initWithObjects:@"00:01:35",@"00:01:30",@"00:01:15",@"00:03:03",@"00:02:48",@"00:01:46", nil];
    NSArray *Pak2= [[NSArray alloc]initWithObjects:@"00:06:57",@"00:01:06",@"00:02:12",@"00:01:29",@"00:02:34",@"00:00:26", nil];
    NSArray *Pak3= [[NSArray alloc]initWithObjects:@"00:02:58",@"00:02:57",@"00:01:57",@"00:02:02",@"00:04:33", nil];
    NSArray *Pak4= [[NSArray alloc]initWithObjects:@"00:04:15",@"00:07:15",@"00:02:37",@"00:04:20", nil];
    NSArray *Pak5= [[NSArray alloc]initWithObjects:@"00:02:16",@"00:04:39",@"00:03:43", nil];
    NSArray *Pak6= [[NSArray alloc]initWithObjects:@"00:05:02",@"00:02:42",@"00:03:08",@"00:04:42",@"00:01:47",@"00:01:32",@"00:02:28",@"00:02:58", nil];
    NSArray *Pak7= [[NSArray alloc]initWithObjects:@"00:07:40",@"00:02:47",@"00:02:36",@"00:02:48",@"00:02:58", nil];
    NSArray *Pak8= [[NSArray alloc]initWithObjects:@"00:03:26",@"00:03:55",@"00:03:35", nil];
    NSArray *Pak9= [[NSArray alloc]initWithObjects:@"00:04:09",@"00:04:53",@"00:03:40",@"00:01:55",@"00:04:55",@"00:02:23", nil];
    NSArray *Pak10= [[NSArray alloc]initWithObjects:@"00:02:59",@"00:02:40",@"00:03:03",@"00:03:04", nil];
    NSArray *Pak11= [[NSArray alloc]initWithObjects:@"00:03:02",@"00:07:10",@"00:01:44", nil];
    NSArray *Pak13= [[NSArray alloc]initWithObjects:@"00:02:30",@"00:03:38",@"00:03:24",@"00:02:58",@"00:03:21",@"00:03:05",@"00:02:33",@"00:01:24",@"00:00:58", nil];
    NSArray *Pak12= [[NSArray alloc]initWithObjects:@"00:00:53",@"00:01:51",@"00:01:31",@"00:04:02",@"00:03:57",@"00:02:51", nil];
    NSArray *Pak14= [[NSArray alloc]initWithObjects:@"00:05:05",@"00:01:32",@"00:00:45",@"00:06:06",@"00:03:21", nil];
    NSArray *Pak15= [[NSArray alloc]initWithObjects:@"00:02:54",@"00:02:33",@"00:02:33",@"00:04:04",@"00:003:44",@"00:01:58", nil];
    NSArray *Pak16= [[NSArray alloc]initWithObjects:@"00:01:16",@"00:01:57",@"00:04:11",@"00:02:03",@"00:01:07",@"00:02:14",@"00:03:06", nil];
    
    [VidDueArray addObject:Inte];
    [VidDueArray addObject:free2];
    [VidDueArray addObject:Pak1];
    [VidDueArray addObject:Pak2];
    [VidDueArray addObject:Pak3];
    [VidDueArray addObject:Pak4];
    [VidDueArray addObject:Pak5];
    [VidDueArray addObject:Pak6];
    [VidDueArray addObject:Pak7];
    [VidDueArray addObject:Pak8];
    [VidDueArray addObject:Pak9];
    [VidDueArray addObject:Pak10];
    [VidDueArray addObject:Pak11];
    [VidDueArray addObject:Pak12];
    [VidDueArray addObject:Pak13];
    [VidDueArray addObject:Pak14];
    [VidDueArray addObject:Pak15];
    [VidDueArray addObject:Pak16];
    self.currDueArray  =[[NSMutableArray alloc]initWithArray:VidDueArray[self.index]];
     NSLog(@"Selected DueArray %@",self.CArray);
    // NSString *Five= ;
   self.ShawnSays =[[NSArray alloc]initWithObjects: @"I can’t even count the number of times people have told me that they’ve spent days and even weeks trying to get up on a board. That’s so crazy because with proper instruction it should easily happen (again and again) your first day out. I mean, there is no reason to sit in the boat and let everyone else have all the fun. The thing about Wakeboarding is that it’s really easy to get up and ride around. So, let’s do it! Get the board on…get in the water and let’s get you riding already!",@"The harder you try, the harder wakeboarding is.  I recommend that every rider review this section no matter what your current level is. Even if you’re throwing inverts and spins you need to be sure you are maximizing the way that the water, rope and physics of these things are working for you, rather than against you. We will also review common terms in this section.Teaching goes much faster when we are all using the same language (and it’s also good to know when you’re hanging in a shop or shooting the breeze with locals).This section will also give you techniques and a foundation to teach people that come on your boat. ",@" Rather than just saying “If you wanna go left on a wakeboard, cut left.”  I give you a basic understanding on why the board does what it does when you lean from one side to the other.Learn how minimal movement can make your riding look and feel effortless and not to mention, a lot cooler.",@"I know you wanna get into the air, but slow down my friend.  Sure, you can just grip it and rip it, so don’t let me stop you.  BUT, if you wanna minimize those diggers, get a good basic understanding of how to keep your riding smooth upon landing.First, let’s get you over the rollers with no stress and effort…then let’s get you to see rollers as part of “the park.” Many people skip these tricks because they think they either can’t do them or they are not important.  This is not true at all!  I will teach you the easiest and fastest way to get these tricks under your belt.Your personal style starts right here! Slides and Ollies…yea, that’s right!",@"When I was younger I was doing a couple flips and a 360 before I learned how to properly jump the wake.  Then I made the trip to Florida and learned how to get proper “Pop,” that’s when things really started to happen for me.This section is a must, even if you are getting wake to wake consistently already. Sure, makes me sound like a salesman, but you are probably checking this out because you want my opinion on some wakeboarding tips.  I teach jumping the wake properly to more riders than any other trick on a wakeboard.If you haven’t mastered the 3 sections before this, I suggest you take the time so you understand a lot of the terms and techniques I will be using in this section.  Take your time with this section and be patient moving from one drill to the next because this is what most tricks off the wake will be based upon.",@"Earn some cool points with your friends and entertain yourself at the same time.  The re-entry air is something most people don’t think of, but every person that I teach it to, loves it and puts it to use often.Grabs are something that nearly every rider tries, but few are successful with it because of some simple misconceptions.  Be the rider who is able to grab the board and do it with style.  This section also gives you a basic understanding of the different grabs you may want to give a whirl.",@"If you want to get into 3’s, the 180 section is a must, and you’ll be glad you did because 180’s are surprisingly fun.In this section I take you through some exercises to learn Frontside and Backside 180’s and you’ll know the difference between the two.  Taking the time to learn your 180’s certainly pays off in the long run because you will be able to move past just jumping the wake and get into 3’s and not to mention some mad respect from other riders when you pop off some Backside 180’s.",@"“I can get around on my 3’s, but I can’t get the handle!”  I have been hearing this from so many riders over the years so I’ve broken down the 3’s so you will understand how a true 360 happens on the wakeboard.  Once you see this and then put the exercises into practice, you will be so pumped at how much bigger you comfort zone gets.",@"Obviously having your 3’s down is a must before moving into this section.  But, taking your 3’s to 5’s isn’t just adding a 180 and I explain why in this section.  Gain instant respect from the beginners and advanced riders when you pop off some 5’s or a Toeside Backside 180.  ",@" Your first invert is closer than you think.  These first flips are a foundation that can keep you coming back to the lake for years.  When I landed my first flip I had to process that I actually made it and was so pumped that I rode that adrenaline for days.  I want you to get that same feeling I had years ago and continue to get every time I ride because doing a flip, never gets old.",@" Now you’re not just going upside down, you’re doing it with some flare!  This section will get you ready for that local competition or for the boat full of people you are gonna bust a trick by.",@"The signature trick of wakeboarding.  Every rider wants to do a Raley. There are some huge misconceptions about how this trick is done.  Let me give you some nuggets of info that will help you take your riding into a new dimension and make that dream trick a reality. Let ‘er rip!",@"Don’t just get around on your flips, do em with style.  Grabbing your inverts is all about control and in this section I teach you how to have that control and why grabbing an invert doesn’t just come from doing your flip like normal and then grabbing the board.",@"There’s a lot going on here but let me show you how to break these tricks down so they finally make sense to you.  One of the more expensive packs because of how much you are getting.  I mean, just look at it.  It’s like you are getting a section of flips, 3’s and 5’s all in one.  Bargain basement prices with fun quality riding entertainment you won’t get anywhere else! Ok…back to work…pay attention…this stuff gets a little tricky!",@"I had to really beat myself up to teach myself how to do these so let me save you the trouble!Off axis spins are some of the most fun, yet easiest ways to spin fast. Do you want 7’s in your future?  Start with off axis spins and you’ll see how much quicker your spins become.Ever see the pros doing 900’s and 1080’s?  Nearly every time they are off axis because it is the easiest way to spin quickly.",@"Want to get noticed by sponsors?  Pull these bad boys out. Allow me to show you the way.",@"You’ve made it, not just to the end, but in the sport of wakeboarding.Start your contest run with one of these and you’re sure to get noticed.",@"You’ve made it, not just to the end, but in the sport of wakeboarding.Start your contest run with one of these and you’re sure to get noticed.", nil];
    self.shawnSaystext.text = [self.ShawnSays objectAtIndex:self.index];
   
     videoimagesarrayLib = [NSMutableArray arrayWithObjects:@"Shaun.png",@"Pak_2_450x332pix.png",@"Pak_3_450x332pix.png",@"Pak_4_450x332pix.png",@"Pak_5_450x332pix.png",@"Pak_6_450x332pix.png",@"Pak_7_450x332pix.png",@"Pak_8_450x332pix.png",@"Pak_9_450x332pix.png",@"Pak_10_450x332pix.png",@"Pak_11_450x332pix.png",@"Pak_12_450x332pix.png",@"Pak_13_450x332pix.png",@"Pak_14_450x332pix.png",@"Pak_15_450x332pix.png",@"Pak_16_450x332pix.png",@"Pak_17_450x332pix.png",@"Pak_18_450x332pix.png",nil];
    
     VideotitlearrayLib = [NSMutableArray arrayWithObjects:@"Introduction",@"Welcome to Wakeboarding",@"The Foundation",@"Press to Play",@"Getting off the Bunny Slope",@"Hang Time",@"House of Style",@"You're Halfway There",@"Getting Around",@"Spin to Win",@"Get inverted like Maverick",@"Now You're a Player",@"As Seen on TV!",@"Suddenly People Know Your Name",@"It's Contest Time!",@"Tilt",@"For Social Networking",@"Going Pro",nil];
    
    
     NameofPakarrayLib = [NSMutableArray arrayWithObjects:@"Default Pak",@"Sampler Pak [ Free ]",@"Pak 1:Starter",@"Pak 2:Board Control",@"Pak 3:Ollies and Slides",@"Pak 4:Wake Jumps",@"Pak 5:First Airs and Grabs",@"Pak 6: 180's",@"Pak 7: 360's",@"Pak 8: 540's and Adv 180's",@"Pak 9: First Inverts",@"Pak 10: Next Inverts",@"Pak 11: First Raleys's",@"Pak 12: Advanced Inverts",@"Pak 13: Mobes",@"Pak 14: Off Axis",@"Pak 15: Tech Spins",@"Pak 16: Tech Raley's", nil];
    
     NumberoflessonsarrayLib = [NSMutableArray arrayWithObjects:@"1 Lesson",@"4 Lessons",@"6 Lessons",@"6 Lessons",@"5 Lessons",@"4 Lessons",@"3 Lessons",@"8 Lessons",@"5 Lessons",@"3 Lessons",@"6 Lessons",@"4 Lessons",@"3 Lessons",@"6 Lessons",@"9 Lessons",@"5 Lessons",@"6 Lessons",@"7 Lessons", nil];
    
    DurationarrayLib = [NSMutableArray arrayWithObjects:@"00:00:45",@"00:09:25",@"00:11:20",@"00:13:45",@"00:15:40",@"00:17:10",@"00:10:20",@"00:18:20",@"00:17:20",@"00:10:50",@"00:19:30",@"00:11:44",@"00:11:56",@"00:15:25",@"00:23:30",@"00:16:50",@"00:17:50",@"00:15:45", nil];
   // NSLog(@"%@ print arraytitles", self.catalogvideotitle);
    [_FullCatTableView reloadData];
    [_DetailsTableView reloadData];
    
    self.InAppList = [[NSArray alloc]initWithObjects:@"",@"",@"com.detention.wakemd.starterpak1",
                      @"com.detention.wakemd.starterpak2",
                      @"com.detention.wakemd.pak3",
                      @"com.detention.wakemd.pak4",
                      @"com.detention.wakemd.pak5",
                      @"com.detention.wakemd.pak6",
                      @"com.detention.wakemd.pak7",
                      @"com.detention.wakemd.pak8",
                      @"com.detention.wakemd.pak9",
                      @"com.detention.wakemd.pak10",
                      @"com.detention.wakemd.pak11",
                      @"com.detention.wakemd.pak12",
                      @"com.detention.wakemd.pak13",
                      @"com.detention.wakemd.pak14",
                      @"com.detention.wakemd.pak15",
                      @"com.detention.wakemd.pak16",nil];
    [self CreateActivityView];
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"Plist"]){
        
        NSMutableArray *Plist = [[NSMutableArray alloc]initWithObjects:@"free",@"free",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no",@"no", nil];
        [[NSUserDefaults standardUserDefaults]setObject:Plist forKey:@"Plist"];
        
        
    }else{
        self.Plist = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Plist"]];
        
    }
}

-(void)showAlert:(NSString*)message{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"WakeMD" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertViewStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [self.tabBarController setSelectedIndex:0];
    }]; //You can use a block here to handle a press on this button
    [alert addAction:actionOk];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)Facebook
{
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [tweet setInitialText:@"Hey there! I am using Wake MD App to learn Wake Boarding, u can also find the Application at below link: https://itunes.apple.com/us/app/wake-md-for-iphone/id645675125?mt=8 "];
        [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultCancelled)
             {
                 NSLog(@"The user cancelled.");
             }
             else if (result == SLComposeViewControllerResultDone)
             {
                 NSLog(@"The user sent the tweet");
             }
         }];
        [self presentViewController:tweet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WakeMD"
                                                        message:@"Facebook integration is not available.  A Facebook account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
-(void)Twitter
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweet setInitialText:@"Hey there! I am using Wake MD App to learn Wake Boarding, you can also find the Application at below link: https://itunes.apple.com/us/app/wake-md-for-iphone/id645675125?mt=8 "];
        [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultCancelled)
             {
                 NSLog(@"The user cancelled.");
             }
             else if (result == SLComposeViewControllerResultDone)
             {
                 NSLog(@"The user sent the tweet");
             }
         }];
        [self presentViewController:tweet animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WakeMD"
                                                        message:@"Twitter integration is not available.  A Twitter account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma In App Purchase
-(void)paymentinapppurchase
{
    NSLog(@"User requests to remove ads");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        
        //If you have more than one in-app purchase, and would like
        //to have the user purchase a different product, simply define
        //another function and replace kRemoveAdsProductIdentifier with
        //the identifier for the other product
        
        NSLog(@"selectd object to purchase is %@",self.InAppList[self.index]);
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.InAppList[self.index]]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments due to parental controls");
        //this is called the user cannot make payments, most likely due to parental controls
    }
    
}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

- (void)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    sKPaymentQueue = [SKPaymentQueue defaultQueue];
    [sKPaymentQueue addTransactionObserver:self];
    [sKPaymentQueue addPayment:payment];
}



- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                self.loadingLabel.text = @"Purchase";
                [self StartSpinning];
                break;
            case SKPaymentTransactionStatePurchased:
                //inapppurchasecompleted=YES;
                self.Plist[self.index]= @"yes";
                [self.downBtn setTitle:@"Download" forState:UIControlStateNormal];
                NSLog(@"perchased is %@",self.Plist);
                [[NSUserDefaults standardUserDefaults]setObject:self.Plist forKey:@"Plist"];
                [self.view layoutSubviews];
                //NSString *identifier = @"categorycell";
                
                //cell = [[Categorycell alloc]init];
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                //                [self doRemoveAds]; //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                [self stopSpinning];
                [sKPaymentQueue finishTransaction:transaction];
                [_FullCatTableView reloadData];
                NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                [self stopSpinning];
                [sKPaymentQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //called when the transaction does not finish
                if(transaction.error.code == SKErrorPaymentCancelled){
                    NSLog(@"Transaction state -> Cancelled");
                    [self stopSpinning];
                    //the user cancelled the payment ;(
                    
                    [sKPaymentQueue finishTransaction:transaction];
                    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                }
                [self stopSpinning];
                [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                [sKPaymentQueue finishTransaction:transaction];
                break;
        }
    }
}


@end
