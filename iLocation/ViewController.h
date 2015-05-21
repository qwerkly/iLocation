//
//  ViewController.h
//  iLocation
//
//  Created by Ivan Babich on 17.05.15.
//  Copyright (c) 2015 Ivan Babich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "IBUIView.h"
#import "IBAnimation.h"
#import "IBMakeArrays.h"
#import "IBCells.h"

@interface ViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource> {
    BOOL isCurrentLocation;
    NSMutableArray * arrayM;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *view_UnderTableView;
@property (assign, nonatomic) BOOL isHistoryButton;

- (IBAction)tapGesture:(UITapGestureRecognizer *)sender;
- (IBAction)longPress:(UILongPressGestureRecognizer *)sender;
- (IBAction)button_ShowTableView:(id)sender;


@end

