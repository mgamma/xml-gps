//
//  SummaryViewController.m
//  xml and GPS
//
//  Created by Mark Harper on 12/9/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import "SummaryViewController.h"

@interface SummaryViewController ()

@end

@implementation SummaryViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.svcdelegate sendAlert];
    
    self.labelCarInfo.text = self.textCarInfo;
    self.labelDestinationInfo.text = self.textDestinationInfo;
    self.labelMileageInfo.text = self.textMileageInfo;
    
    
//    self.labelCostInfo.text = self.textCostInfo;
//     delegate method is below as an optional way of coding
    
    self.labelCostInfo.text = [self.svcdelegate getCostString];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToMainvViewButton:(id)sender {
    
    [self.svcdelegate didFinishViewingSummary:self];
}

- (IBAction)activityShareButton:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://www.raywenderlich.com/4817/how-to-integrate-cocoas2d-and-uikit"];
//    UIImage *imageToShare = [UIImage imageNamed:@"UIKitButton.png"];
    
    NSArray * activityStuff = @[@"Type your message here",  url,self.textCarInfo];
    
    
    
    UIActivityViewController * activityControl = [[UIActivityViewController alloc] initWithActivityItems:activityStuff applicationActivities:nil];
    
    
    activityControl.excludedActivityTypes = @[UIActivityTypeAddToReadingList,UIActivityTypeAssignToContact,UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypeSaveToCameraRoll,UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard];
    
    [self presentViewController:activityControl animated:YES completion:nil];

    
}












@end
