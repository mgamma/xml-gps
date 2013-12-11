//
//  ViewController.m
//  xml and GPS
//
//  Created by Mark Harper on 11/28/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
#import "XMLParser.h"
#import "SummaryViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - view lifecycle
- (void)viewDidLoad
{
    NSLog(@"start");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.ourTrip = [[Trip alloc]init];
    });
    dispatch_queue_t ourQueue = dispatch_queue_create("com.nwktc.ourQueue", 0);
    dispatch_async(ourQueue, ^{
        
    
    
    if([self fetchTheCars]){
        
    
    self.carChoiceIndex = 2;
    

}else{
    Car * temp = [[Car alloc]init];
    temp.mileage = @"25";
    temp.name = @"Default";
    temp.people = @"4";
    temp.center = @"0";
    self.carChoiceIndex = 0;
    self.cars = [[NSMutableArray alloc]initWithObjects:temp, nil];
}
    
    [self.ourTrip setChosenCar:[self.cars objectAtIndex:self.carChoiceIndex]];
    self.labelNumberOfPassengers.text = [self.ourTrip howManyPassengers];
        
    }); 
    
    self.manager = [[CLLocationManager alloc]init];
    [self.manager setDelegate:self];
    [self.manager startUpdatingLocation];
        
        

    CLLocationCoordinate2D temp = CLLocationCoordinate2DMake(38.113843, -122.227308);
//    [self.map addAnnotation:[[MyAnnotation alloc]initWithCoordinate:temp]];
    [self addLocationToMapWithString:@"Vallejo CA"];
    
    MKCoordinateRegion ourView = MKCoordinateRegionMakeWithDistance(temp, 150000, 150000);
    
    MKCoordinateRegion adjustment = [self.map regionThatFits:ourView];
    
    [self.map setRegion:adjustment animated:YES];
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"end");
}


#pragma mark - core location methods...
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    

    


//    if (floor(newLocation.coordinate.latitude)!= floor(oldLocation.coordinate.latitude)) {
    
    CLLocation  * currentLocation = [locations lastObject];
    NSLog(@" you are currently at %f , %f",
        currentLocation.coordinate.latitude,
        currentLocation.coordinate.longitude);
        }



-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self setCarChoiceImageLayer:nil];
    [self.manager stopUpdatingLocation];
//    [self setLocationMenu:nil];
//    [self setMap:nil];
//    [self setLabelNumberPassengers:nil];
//    [self setLabelTotalCost:nil];
    
}
-(void)addLocationToMapWithString:(NSString *)addressString{
    
    
    CLGeocoder * geo = [[CLGeocoder alloc]init];
    [geo geocodeAddressString:addressString completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count ] > 0) {
            
            CLPlacemark * place = [placemarks objectAtIndex:0];
            
            
            [self.ourTrip addLocationString:addressString withLocation:place.location];
            [self.map addAnnotation:[[MyAnnotation alloc]initWithCoordinate:place.location.coordinate]];
            self.lableTotalCost.text = [self.ourTrip getCostOfTrip];
            
        }
        
        
    }];
    
}

# pragma mark - XML methods

-(BOOL)fetchTheCars{
    NSURL * url = [[NSURL alloc]initWithString:@"http://www.nwktc.edu/maed/data/cars.xml"];
    NSXMLParser * nsParser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    
    XMLParser * ourParser = [[XMLParser alloc]initXMLParser];
    
    [nsParser setDelegate:ourParser];
    
    if(![nsParser parse]){
        return NO;
    
    }
    
    self.cars = ourParser.allCars;
    
    for (int i = 0; i<[self.cars count]; i++) {
        [[self.cars objectAtIndex:i]printTheCar];
    }
    if ([self.cars count]<1)
    {return NO;}
    return YES;
}

- (IBAction)changeCar:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.carChoiceIndex == 0) {
            // Do The Bounce Animation
            CGPoint currentCenter = self.carChoiceImageLayer.center;
                        
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        // car goes further to the right
                self.carChoiceImageLayer.center = CGPointMake(self.carChoiceImageLayer.center.x + 40, 40);
            } completion:^(BOOL finished) {
                //the car snaps back
        [UIView animateWithDuration:.3 animations:^{
            self.carChoiceImageLayer.center = currentCenter;
                }];
                
            }];
            
        }else{
            self.carChoiceIndex--;
            Car * temp = [self.cars objectAtIndex:self.carChoiceIndex];
            [UIView animateWithDuration:.3 animations:^{
                // create a new center for our car as it is selected
                self.carChoiceImageLayer.center = CGPointMake([[temp center] floatValue], 40);
            }];
        }
        
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.carChoiceIndex == 3) {
            // Do The Bounce Animation
            CGPoint currentCenter = self.carChoiceImageLayer.center;
            
            [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                // car goes further to the left
                self.carChoiceImageLayer.center = CGPointMake(self.carChoiceImageLayer.center.x - 40, 40);
            } completion:^(BOOL finished) {
                //the car snaps back
                [UIView animateWithDuration:.3 animations:^{
                    self.carChoiceImageLayer.center = currentCenter;
                }];
                
            }];
            
        }else{
            self.carChoiceIndex++;
            Car * temp = [self.cars objectAtIndex:self.carChoiceIndex];
            [UIView animateWithDuration:.3 animations:^{
                // create a new center for our car 
                self.carChoiceImageLayer.center = CGPointMake([[temp center] floatValue], 40);
            }];
        }
    }
    
    [self.ourTrip setChosenCar:[self.cars objectAtIndex:self.carChoiceIndex]];
    self.labelNumberOfPassengers.text = [self.ourTrip howManyPassengers];
    self.lableTotalCost.text = [self.ourTrip getCostOfTrip];
}

#pragma mark - Menu item calls

- (IBAction)showLocationMenu:(id)sender {
    [UIView animateWithDuration:.4 animations:^{
        self.locationMenu.center = CGPointMake(160, 331);
    }];
   
}


- (IBAction)hideLocationMenu:(id)sender {
    [UIView animateWithDuration:.4 animations:^{
        self.locationMenu.center = CGPointMake(160, 390);
    }];
}

- (IBAction)addNewLocation:(id)sender {
    UIAlertView * addALocationView = [[UIAlertView alloc]initWithTitle:@"Enter a Location" message:@"Example - Valdez Alaska" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
    [addALocationView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [addALocationView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [alertView buttonTitleAtIndex:buttonIndex];
    NSString * buttonClicked = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonClicked isEqualToString:@"Submit"]) {
         NSString * address = [alertView textFieldAtIndex:0].text;
        [self addLocationToMapWithString:address];
            }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"finalize"]) {
        
        
        NSMutableArray * locations = self.ourTrip.locationStrings;
        NSString * destination = [locations lastObject];

        
        Car * temp = [self.cars objectAtIndex:self.carChoiceIndex];
        
//        [[segue destinationViewController] setTextCarInfo:temp.name];
//        [[segue destinationViewController]setTextDestinationInfo:destination];
//        [[segue destinationViewController]setTextMileageInfo:temp.mileage];
//        [[segue destinationViewController] setTextCostInfo:self.lableTotalCost.text];
//        [[segue destinationViewController]setSvcdelegate:self];
        
        // alternate method with dot notation
        SummaryViewController * summary = segue.destinationViewController;
        summary.svcdelegate = self;
        
        summary.textCarInfo = temp.name;
        summary.textDestinationInfo = destination;
        summary.textMileageInfo = temp.mileage;
//        summary.textCostInfo = self.lableTotalCost.text;
        
    
        
    }
    
}
-(NSString *)getCostString{
    return self.lableTotalCost.text;}

#pragma mark - Summary view controller method
-(void)didFinishViewingSummary:(SummaryViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"summary back button pushed");
    }];
}

-(void)sendAlert{
    NSLog(@" Summary sent this");
}


@end





