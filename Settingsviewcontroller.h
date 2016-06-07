//
//  Settingsviewcontroller.h
//  WakeMD
//
//  Created by NCPL on 4/20/16.
//  Copyright © 2016 NCPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
@interface Settingsviewcontroller : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *hopwtousebut;

@property (strong, nonatomic) IBOutlet UIButton *termsandconditionsbut;
- (IBAction)termsaction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *aboutbutton;

- (IBAction)howtouseaction:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *howtouseview;
- (IBAction)aboutwakemdbut:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *termsview;
@property (strong, nonatomic) IBOutlet UIView *about;


@property (strong, nonatomic) IBOutlet UIButton *backbutton;

- (IBAction)RootView:(id)sender;

- (IBAction)Shareus:(id)sender;



@end
