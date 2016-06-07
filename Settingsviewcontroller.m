//
//  Settingsviewcontroller.m
//  WakeMD
//
//  Created by NCPL on 4/20/16.
//  Copyright © 2016 NCPL. All rights reserved.
//

#import "Settingsviewcontroller.h"

@interface Settingsviewcontroller ()

@end

@implementation Settingsviewcontroller


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









- (IBAction)termsaction:(id)sender
{
    [self.aboutbutton setBackgroundImage:[UIImage imageNamed:@"007 2732x2048_WakeMDiPad_HTU_abwnd_tab_btn off.png"] forState:UIControlStateNormal];
    [self.hopwtousebut setBackgroundImage:[UIImage imageNamed:@"007 2732x2048_WakeMDiPad_HTU_htu_tab_btn off.png"] forState:UIControlStateNormal];
    [self.termsandconditionsbut setBackgroundImage:[UIImage imageNamed:@"007 2732x2048_WakeMDiPad_HTU_tnc_tab_btn on.png"] forState:UIControlStateNormal];
    self.howtouseview.hidden=YES;
    
    self.termsview.hidden =NO;
    self.about.hidden=YES;
    
}

- (IBAction)howtouseaction:(id)sender
{
    
    
    [self.aboutbutton setBackgroundImage:[UIImage imageNamed:@"007 2732x2048_WakeMDiPad_HTU_abwnd_tab_btn off.png"] forState:UIControlStateNormal];
    [self.hopwtousebut setBackgroundImage:[UIImage imageNamed:@"007 2732x2048_WakeMDiPad_HTU_htu_tab_btn on.png"] forState:UIControlStateNormal];
    [self.termsandconditionsbut setBackgroundImage:[UIImage imageNamed:@"007 2732x2048_WakeMDiPad_HTU_tnc_tab_btn off.png"] forState:UIControlStateNormal];
    
    self.howtouseview.hidden= NO;
    self.about.hidden=YES;
    self.termsview.hidden=YES;
    
}
- (IBAction)aboutwakemdbut:(id)sender
{
    [self.aboutbutton setBackgroundImage:[UIImage imageNamed:@"007 2732x2048_WakeMDiPad_HTU_abwnd_tab_btn on.png"] forState:UIControlStateNormal];
    [self.hopwtousebut setBackgroundImage:[UIImage imageNamed:@"007 2732x2048_WakeMDiPad_HTU_htu_tab_btn off.png"] forState:UIControlStateNormal];
    [self.termsandconditionsbut setBackgroundImage:[UIImage imageNamed:@"007 2732x2048_WakeMDiPad_HTU_tnc_tab_btn off.png"] forState:UIControlStateNormal];
    
     self.howtouseview.hidden=YES;
    self.about.hidden=NO;
    self.termsview.hidden=YES;
}


-(void)facebook
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [tweet setInitialText:@"Hey there! I am using Wake MD App to learn Wake Boarding, you can also find the Application at below link: https://itunes.apple.com/us/app/wake-md/id517824555?mt=8 "];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wake MD"
                                                        message:@"Facebook integration is not available.  A Facebook account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)instagram
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweet setInitialText:@"Hey there! I am using Wake MD App to learn Wake Boarding, you can also find the Application at below link: https://itunes.apple.com/us/app/wake-md/id517824555?mt=8 "];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wake MD"
                                                        message:@"Twitter integration is not available.  A Twitter account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


- (IBAction)RootView:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Shareus:(id)sender

{
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
