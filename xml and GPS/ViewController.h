//
//  ViewController.h
//  xml and GPS
//
//  Created by Mark Harper on 11/28/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "Trip.h"
#import "SummaryViewController.h"

#warning want to have map expand to show added locations out of initial view range settings.

@interface ViewController : UIViewController<CLLocationManagerDelegate,UIAlertViewDelegate, SummaryViewControllerDelegate>

@property(nonatomic,strong)CLLocationManager * manager;
@property(nonatomic,strong)NSMutableArray * cars;
-(BOOL)fetchTheCars;
- (IBAction)changeCar:(UISwipeGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *carChoiceImageLayer;
@property int carChoiceIndex;
@property CGPoint currentCenter;
@property(nonatomic,strong) Trip * ourTrip;
- (IBAction)showLocationMenu:(id)sender;
- (IBAction)hideLocationMenu:(id)sender;
- (IBAction)addNewLocation:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *locationMenu;
@property (strong, nonatomic) IBOutlet UILabel *labelNumberOfPassengers;







@property (strong, nonatomic) IBOutlet MKMapView *map;

-(void)addLocationToMapWithString:(NSString *)addressString;

@property (strong, nonatomic) IBOutlet UILabel *lableTotalCost;






@end
