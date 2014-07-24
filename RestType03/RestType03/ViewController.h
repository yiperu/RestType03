//
//  ViewController.h
//  RestType03
//
//  Created by Henry Antonio Ambicho Trujillo on 7/24/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblHumanReable;
@property (weak, nonatomic) IBOutlet UILabel *lblJsonSummary;

- (void)fetchedData:(NSData *)responseData;

@end
