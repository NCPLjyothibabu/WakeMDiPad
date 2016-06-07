//
//  MyLibrary.m
//  WakeMDiPad
//
//  Created by NCPL Inc on 01/06/16.
//  Copyright © 2016 NCPL Inc. All rights reserved.
//

#import "MyLibrary.h"
#import "MyLibCell.h"
#import "DetailsCell.h"
#import <MediaPlayer/MediaPlayer.h>

#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
#define IPHONE UIUserInterfaceIdiomPhone

@interface MyLibrary ()
@property (strong,nonatomic)NSMutableArray *mainArray;
@property (strong,nonatomic) NSArray *CArray;
@property (strong, nonatomic) NSMutableArray * cDueArray;
@property (strong, nonatomic) MPMoviePlayerController *mpPlayer;
@property (strong, nonatomic) NSMutableArray *VidDueArray;

@property BOOL Play;
@property int CVid;
@end

@implementation MyLibrary
@synthesize Videonamesarray,vimage,videodurationarr,Paktitlearray,Lessonsarray,Videoimagesarray,myLibTableView,DetailsTableView, mpPlayer,CVid, VidDueArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self gettingVedioContents];
    myLibTableView.delegate = self;
    myLibTableView.dataSource = self;
     self.CArray = [[NSArray alloc]initWithArray:self.mainArray[0]];
    self.cDueArray = [[NSArray alloc]initWithArray:self.mainArray[0]];
    _Play = NO;
    CGSize iOSScreenSize=[[UIScreen mainScreen]bounds].size;
    self.VideoPlayerView.hidden =YES;
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"savedPaks"]) {
        self.savedPacks = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"savedPaks"]];
        
    }else{
        self.savedPacks = [[NSMutableArray alloc]initWithObjects:@"0",@"1", nil];
    }
//    if ( IDIOM == IPAD )
//        
//    {
//        /* do something specifically for iPad. */
//        //        [NSThread sleepForTimeInterval:5];
//        //        storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        
//        if (iOSScreenSize.width==1024) //7.9 inch
//        {
//            mpPlayer.view.frame = CGRectMake(360, 130, self.view.frame.size.width-360, 400);
//        }
//        
//        
//        if(iOSScreenSize.width==1366)//12.7 inch
//        {
//            mpPlayer.view.frame = CGRectMake(468, 150, self.view.frame.size.width-460, 550);
//        }
//    }
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"VImages"]) {
        Videoimagesarray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"VImages"]];
        Videonamesarray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"VNames"]];
        Paktitlearray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"PackTitle"]];
        Lessonsarray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"LessonsA"]];
        videodurationarr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"VDue"]];
        
    }else{
        
        Videoimagesarray = [NSMutableArray arrayWithObjects:@"Shaun.png",@"Pak_2_450x332pix.png",nil];
        
        Videonamesarray = [NSMutableArray arrayWithObjects:@"Default Pak",@"Sampler Pak [Free]", nil];
        
        Paktitlearray = [NSMutableArray arrayWithObjects: @"Introduction",@"Welcome to Wakeboarding",nil];
        // ,@"The Foundation",@"Press to Play",
        
        Lessonsarray = [NSMutableArray arrayWithObjects:@"1 Lessons",@"4 Lessons", nil];
        
        videodurationarr = [NSMutableArray arrayWithObjects:@"00:00:45",@"00:09:25",nil];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"savedPaks"]) {
        self.savedPacks = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"savedPaks"]];
        
    }else{
        self.savedPacks = [[NSMutableArray alloc]initWithObjects:@"0",@"1", nil];
    }
    
    NSArray*  introvideoarray = [NSArray arrayWithObjects:@"Intro",nil];
    NSArray* wakeboardingarray = [NSArray arrayWithObjects:@"Intro",@"GettingIntoTheWater",@"GettingIntoYourBindings",@"GettingUp",@"TakingYourBindingsOff",nil];
    NSArray * paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSArray * Docs = [[NSFileManager defaultManager] subpathsAtPath:documentsDirectory];

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
-(void)viewWillAppear:(BOOL)animated{
    NSMutableArray * videoimagesarrayLib = [NSMutableArray arrayWithObjects:@"Shaun.png",@"Pak_2_450x332pix.png",@"Pak_3_450x332pix.png",@"Pak_4_450x332pix.png",@"Pak_5_450x332pix.png",@"Pak_6_450x332pix.png",@"Pak_7_450x332pix.png",@"Pak_8_450x332pix.png",@"Pak_9_450x332pix.png",@"Pak_10_450x332pix.png",@"Pak_11_450x332pix.png",@"Pak_12_450x332pix.png",@"Pak_13_450x332pix.png",@"Pak_14_450x332pix.png",@"Pak_15_450x332pix.png",@"Pak_16_450x332pix.png",@"Pak_17_450x332pix.png",@"Pak_18_450x332pix.png",nil];
    
    NSMutableArray * VideotitlearrayLib = [NSMutableArray arrayWithObjects:@"Introduction",@"Welcome to Wakeboarding",@"The Foundation",@"Press to Play",@"Getting off the Bunny Slope",@"Hang Time",@"House of Style",@"You're Halfway There",@"Getting Around",@"Spin to Win",@"Get inverted like Maverick",@"Now You're a Player",@"As Seen on TV!",@"Suddenly People Know Your Name",@"It's Contest Time!",@"Tilt",@"For Social Networking",@"Going Pro",nil];
    
    
    NSMutableArray * NameofPakarrayLib = [NSMutableArray arrayWithObjects:@"Default Pak",@"Sampler Pak [ Free ]",@"Pak 1:Starter",@"Pak 2:Board Control",@"Pak 3:Ollies and Slides",@"Pak 4:Wake Jumps",@"Pak 5:First Airs and Grabs",@"Pak 6: 180's",@"Pak 7: 360's",@"Pak 8: 540's and Adv 180's",@"Pak 9: First Inverts",@"Pak 10: Next Inverts",@"Pak 11: First Raleys's",@"Pak 12: Advanced Inverts",@"Pak 13: Mobes",@"Pak 14: Off Axis",@"Pak 15: Tech Spins",@"Pak 16: Tech Raley's", nil];
    
    NSMutableArray * NumberoflessonsarrayLib = [NSMutableArray arrayWithObjects:@"1 Lesson",@"4 Lessons",@"6 Lessons",@"6 Lessons",@"5 Lessons",@"4 Lessons",@"3 Lessons",@"8 Lessons",@"5 Lessons",@"3 Lessons",@"6 Lessons",@"4 Lessons",@"3 Lessons",@"6 Lessons",@"9 Lessons",@"5 Lessons",@"6 Lessons",@"7 Lessons", nil];
    
    NSMutableArray *DurationarrayLib = [NSMutableArray arrayWithObjects:@"00:00:45",@"00:09:25",@"00:11:20",@"00:13:45",@"00:15:40",@"00:17:10",@"00:10:20", @"00:18:20",@"00:17:20",@"00:10:50",@"00:19:30",@"00:11:44",@"00:11:56",@"00:15:25",@"00:23:30",@"00:16:50",@"00:17:50",@"00:15:45", nil];
    
    //    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor whiteColor] size:20.0f];
    //    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    //    [self.view addSubview:activityIndicatorView];
    //    [activityIndicatorView startAnimating];
    
    BOOL Add=NO;
    
    
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"index"]) {
        
        int index= [[NSUserDefaults standardUserDefaults]integerForKey:@"index"];
        NSLog(@"index Is %d",index);
        if (index<18) {
            
            
            
            for (int i=0; i<Paktitlearray.count; i++) {
                if ([Paktitlearray[i] isEqualToString:VideotitlearrayLib[index]]) {
                    Add = NO;
                    break;
                }else{
                    Add = YES;
                }
            }
            if (Add) {
                [Videoimagesarray addObject:videoimagesarrayLib[index]];
                [Paktitlearray addObject:VideotitlearrayLib[index]];
                [Lessonsarray addObject:NumberoflessonsarrayLib[index]];
                [videodurationarr addObject:DurationarrayLib[index]];
                [Videonamesarray addObject:NameofPakarrayLib[index]];
                
                [[NSUserDefaults standardUserDefaults]setObject:Videoimagesarray forKey:@"VImages"];
                [[NSUserDefaults standardUserDefaults]setObject:Paktitlearray forKey:@"PackTitle"];
                [[NSUserDefaults standardUserDefaults]setObject:Lessonsarray forKey:@"LessonsA"];
                [[NSUserDefaults standardUserDefaults]setObject:videodurationarr forKey:@"VDue"];
                [[NSUserDefaults standardUserDefaults]setObject:Videonamesarray forKey:@"VNames"];
                [self.savedPacks addObject:[NSString stringWithFormat:@"%d",index]];
                [[NSUserDefaults standardUserDefaults]setObject:self.savedPacks forKey:@"savedPaks"];
            }
        }else{
            NSLog(@"index Is %d",index);
        }
    }else{
        
        
    }
    [myLibTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView== myLibTableView){
    return Paktitlearray.count;
    }
    else if (tableView == DetailsTableView){
        return  self.CArray.count;
    }else{
        return 0;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == myLibTableView) {
      
    NSString *identifier = @"Cell";
    MyLibCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[MyLibCell alloc]init];
    }
    
    
    cell.Image.image = [UIImage imageNamed:[Videoimagesarray objectAtIndex:indexPath.row]];
    
    
    
    [cell.Image.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [cell.Image.layer setBorderWidth:0.8];
    
    
    cell.pakName.text = [Videonamesarray objectAtIndex:indexPath.row];
    cell.title.text  = [Paktitlearray objectAtIndex:indexPath.row];
    cell.Duration.text = [videodurationarr objectAtIndex:indexPath.row];
    cell.lessons.text = [Lessonsarray objectAtIndex:indexPath.row];
    
    
    
//        if (indexPath.row>2)
//        {
//            cell.arrowImg.image = [UIImage imageNamed:@"011 1242x2208_WakeMD_Catalog defaultdownloaded.png"];
//        }
//        else
//        {
//            cell.arrowImg.image = [UIImage imageNamed:@"011 1242x2208_WakeMD_Catalog price tag.png"];
//        }
    return cell;
}
    else if( tableView == self.DetailsTableView){
        
        NSString *Idenf =@"cell";
        DetailsCell *dCell = [tableView dequeueReusableCellWithIdentifier:Idenf];
        
        if (dCell==nil) {
            dCell = [[DetailsCell alloc ]init];
        }
        dCell.VidName.text = [NSString stringWithFormat:@"%@",[self.CArray objectAtIndex:indexPath.row]];
        dCell.VidDue.text = [NSString stringWithFormat:@"%@",[self.cDueArray objectAtIndex:indexPath.row]];
        
        return dCell;
    }else{return nil;}
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView== myLibTableView){
    self.TitleLable.text = [Paktitlearray objectAtIndex:indexPath.row];
    self.DurationLable.text =[videodurationarr objectAtIndex:indexPath.row];
        self.Index = [self.savedPacks[indexPath.row] intValue];
        if (self.CArray!=NULL) {
            self.CArray = NULL;
            self.cDueArray = NULL;
            self.CArray = [[NSArray alloc]initWithArray:self.mainArray [self.Index]];
            self.cDueArray= [[NSMutableArray alloc]initWithArray:self.VidDueArray [self.Index]];
        }
        [DetailsTableView reloadData];
    }
    
   else if (tableView== DetailsTableView) {
        [self playvideo:self.CArray[indexPath.row]];
    }
    
    
    
}
- (IBAction)VideoBackBtn:(id)sender {
    mpPlayer.stop;
    [self dismissModalViewControllerAnimated:mpPlayer];
    self.VideoPlayerView.hidden= YES;
}

- (IBAction)socialShare:(id)sender {
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

- (IBAction)settings:(id)sender {
    [self performSegueWithIdentifier:@"Details" sender:self];
}

- (IBAction)PlayPause:(id)sender {
    if (_Play) {
        [mpPlayer pause];
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"002 2732x2048_WakeMDiPad_MyLibrary_video_play btn.png" ]forState:UIControlStateNormal];
        
        _Play = NO;
    }else{
        [mpPlayer play];
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"002 2732x2048_WakeMDiPad_MyLibrary_video_pause btn.png"] forState:UIControlStateNormal];
        _Play = YES;
    }
    
}

- (IBAction)forward:(id)sender {
    [mpPlayer beginSeekingForward];
    [mpPlayer endSeeking];
}

- (IBAction)backward:(id)sender {
    [mpPlayer beginSeekingBackward];
    [self performSelector:@selector(endseeking) withObject:self afterDelay:1];
}
-(void)endseeking{
[mpPlayer endSeeking];
}
- (IBAction)nextVideo:(id)sender {
    NSLog(@"List of Videos : %@",self.CArray);
    if (CVid < self.CArray.count-1) {
        CVid++;
        [self playvideo:self.CArray[CVid]];
    }else{
        [self playvideo:self.CArray[CVid]];
    }
    
}

- (IBAction)PervVideo:(id)sender {
    NSLog(@"List of Videos : %@",self.CArray);
    if (CVid >self.CArray.count-1) {
        
        [self playvideo:self.CArray[CVid]];
    }else{
        CVid--;
        [self playvideo:self.CArray[CVid]];
    }
}

- (IBAction)TabMLibBtn:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)FullCatBtn:(id)sender {
    [mpPlayer stop];
    
    [self.tabBarController setSelectedIndex:1];
}

-(void)gettingVedioContents{
    
    self.mainArray = [NSMutableArray new];
   NSArray* firstvideoarray = [NSArray arrayWithObjects:@"Intro",nil];
    
    
   NSArray* secondvideoarray = [NSArray arrayWithObjects:@"GettingIntoTheWater",@"GettingIntoYourBindings",@"GettingUp",@"TakingYourBindingsOff",nil];
    
    
    // NSDictionary *dict = @{@"firstobj":firstvideoarray,@"secondobj":secondvideoarray};
    //  NSLog(@"%@ print array in dict",dict);
    
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
    NSArray *pak12 = [[NSArray alloc]initWithObjects:@"IndyTSbBackroll",@"GrabbingTheTantrum",@"HSFrontToFakie",@"HSRollToBlind",@"TantrumToBlind",@"TootsieRoll", nil];
    NSArray *pak13 = [[NSArray alloc]initWithObjects:@"WhirlyBird",@"MobyDick",@"CrowMobe",@"WrappedKGB",@"HandlePassKGB",@"PeteRose",@"HSMobe",@"Whirly5",@"Crow5", nil];
    NSArray *pak14 = [[NSArray alloc]initWithObjects:@"OAHSFS360",@"OATSFS360",@"OAHSFS540",@"OATSFS540",@"HSBS5ShouldBeIn15",nil];
    NSArray *pak15 = [[NSArray alloc]initWithObjects:@"TSBS360",@"OAHSBS180",@"OAHSBS360",@"OAHSFS720",@"OATSFS7",@"OATSFS9", nil];
    NSArray *pak16 = [[NSArray alloc]initWithObjects:@"HSKrypt",@"TSKrypt",@"GlidesIndy",@"BlindJudge-HSRaleyBS180",@"313",@"TheName313",@"TumbleTurn-WormTurnTurtleSpin", nil];
    
    self.mainArray = [NSMutableArray new];
    [self.mainArray addObject:firstvideoarray];
    [self.mainArray addObject:secondvideoarray];
    [self.mainArray addObject:pak1];
    [self.mainArray addObject:pak2];
    [self.mainArray addObject:pak3];
    [self.mainArray addObject:pak4];
    [self.mainArray addObject:pak5];
    [self.mainArray addObject:pak6];
    [self.mainArray addObject:pak7];
    [self.mainArray addObject:pak8];
    [self.mainArray addObject:pak9];
    [self.mainArray addObject:pak10];
    [self.mainArray addObject:pak11];
    [self.mainArray addObject:pak12];
    [self.mainArray addObject:pak13];
    [self.mainArray addObject:pak14];
    [self.mainArray addObject:pak15];
    [self.mainArray addObject:pak16];
    
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
    //self.cDueArray  =[[NSMutableArray alloc]initWithArray:VidDueArray[]];
}

-(void)playvideo:(NSString *)name{
    
    //NSString *Vname = name;
    self.VideoPlayNamelab.text = [NSString stringWithFormat:@"%@",name];
    NSArray * paths = NSSearchPathForDirectoriesInDomains (NSLibraryDirectory,NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *directoryContent = [[NSFileManager defaultManager] directoryContentsAtPath: documentsDirectory];
    NSLog(@" Saved files In NSMoviesDir %@",directoryContent);
   // NSLog(@"Selected :%@",self.selectedName);
    NSString *Ser = [NSString stringWithFormat:@"%@.mov",name];
   // NSString *Ser = [NSString stringWithFormat:@"%@.mov",self.selectedName];
    
    if ([name isEqualToString:@"Intro"]||[name isEqualToString:@"GettingUp"]||[name isEqualToString:@"GettingIntoTheWater"]||[name isEqualToString:@"GettingIntoYourBindings"]||[name isEqualToString:@"TakingYourBindingsOff"]) {
         NSURL*UrlV = [[NSBundle mainBundle]URLForResource:name withExtension:@"mov"];
        mpPlayer = [[MPMoviePlayerController alloc]initWithContentURL:UrlV];
        
       
        _Play = YES;
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"002 2732x2048_WakeMDiPad_MyLibrary_video_pause btn.png"] forState:UIControlStateNormal];
    }else if ([documentsDirectory stringByAppendingPathComponent:Ser]) {
        NSString *st = [documentsDirectory stringByAppendingPathComponent:Ser];
        NSURL *UrlV = [NSURL fileURLWithPath:st];
        NSLog(@"Url is: %@",UrlV);
        mpPlayer = [[MPMoviePlayerController alloc]initWithContentURL:UrlV];
        _Play  =YES;
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"002 2732x2048_WakeMDiPad_MyLibrary_video_pause btn.png"] forState:UIControlStateNormal];
//        mpPlayer = [[MPMoviePlayerController alloc]initWithContentURL:UrlV];
//        [mpPlayer play];
    }
    mpPlayer.view.frame = CGRectMake(0, 49, self.VideoPlayerView.frame.size.width, self.VideoPlayerView.frame.size.height-49);
    [self.VideoPlayerView addSubview:mpPlayer.view];
    [self presentMoviePlayerViewControllerAnimated:mpPlayer];
    self.VideoPlayerView.hidden= NO;
    
    //[self.view addSubview:mpPlayer];
    [mpPlayer play];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex!=-1) {
        
        
        NSString *buttontitle=[actionSheet buttonTitleAtIndex:buttonIndex];
        if ([buttontitle isEqualToString:@"Facebook"])
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


@end
