//
//  SummaryViewController.h
//  xml and GPS
//
//  Created by Mark Harper on 12/9/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SummaryViewController;

@protocol SummaryViewControllerDelegate
-(void)didFinishViewingSummary:(SummaryViewController *)controller;
-(void)sendAlert;
-(NSString *) getCostString;
@end


@interface SummaryViewController : UIViewController



@property (weak,nonatomic) id <SummaryViewControllerDelegate> svcdelegate;

@property (strong, nonatomic) IBOutlet UILabel *labelCarInfo;

@property (strong, nonatomic) IBOutlet UILabel *labelDestinationInfo;
@property (strong, nonatomic) IBOutlet UILabel *labelMileageInfo;
@property (strong, nonatomic) IBOutlet UILabel *labelCostInfo;

@property (nonatomic,strong)NSString * mailText;
@property (nonatomic,strong)NSString * twitterText;
@property (nonatomic,strong)NSString * smsText;
@property (nonatomic,strong)NSString * facebookText;

@property (nonatomic,strong)NSString * textCarInfo;
@property (nonatomic,strong)NSString * textMileageInfo;
@property (nonatomic,strong)NSString * textDestinationInfo;
// the property below isn't needed if you use delegate method
@property (nonatomic,strong)NSString * textCostInfo;


- (IBAction)goBackToMainvViewButton:(id)sender;




- (IBAction)activityShareButton:(UIButton *)sender;
















@end
