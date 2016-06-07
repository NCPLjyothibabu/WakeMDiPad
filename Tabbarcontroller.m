//
//  Tabbarcontroller.m
//  WakeMD
//
//  Created by NCPL on 4/15/16.
//  Copyright © 2016 NCPL. All rights reserved.
//

#import "Tabbarcontroller.h"
//#import "MY Library.h"

//#import "Full Catalog.h"

@interface Tabbarcontroller ()

@end

@implementation Tabbarcontroller

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    UITabBarItem *librarytab = [mytabbar.items objectAtIndex:0];
    UITabBarItem *catalogtab = [mytabbar.items objectAtIndex:1];


    for(UITabBarItem * tabBarItem in self.tabBar.items)
    {
        tabBarItem.title = @"";
        tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
    
    
    // My Library Tab
    
  librarytab.image = [[UIImage imageNamed:@"Mylibrary_off.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    librarytab.selectedImage = [[UIImage imageNamed:@"Mylibrary_on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];


   
   // Full Catalog Tab
   
    catalogtab.image = [[UIImage imageNamed:@"Fullcatalog_off1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    catalogtab.selectedImage = [[UIImage imageNamed:@"Fullcatalog_on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];

 [self.tabBar setTintColor:[UIColor clearColor]];

    
  
    
[[UITabBar appearance] setSelectionIndicatorImage:[[UIImage imageNamed:@"selected_item_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]];
    
    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:202.0f/255.0f green:201.0f/255.0f blue:201.0f/255.0f alpha:1.0] }
//                                             forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }
//                                             forState:UIControlStateSelected];
//    
//  //  UIImageView *tabBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,49)];
self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
