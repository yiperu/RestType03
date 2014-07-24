//
//  ViewController.m
//  RestType03
//
//  Created by Henry Antonio Ambicho Trujillo on 7/24/14.
//  Copyright (c) 2014 Apps4s. All rights reserved.
//

#import "ViewController.h"


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //Esto es una Macro
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    dispatch_async(kBgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:kLatestKivaLoansURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          options:kNilOptions
                          error:&error];
    
    NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    
    NSLog(@"loans: %@", latestLoans); //3
    // ==========================================
    // 1) Get the latest loan
    NSDictionary* loan = [latestLoans objectAtIndex:0];
    
    // 2) Get the funded amount and loan amount
    NSNumber* fundedAmount = [loan objectForKey:@"funded_amount"];
    NSNumber* loanAmount = [loan objectForKey:@"loan_amount"];
    float outstandingAmount = [loanAmount floatValue] - [fundedAmount floatValue];
    
    // 3) Set the label appropriately
//    @property (weak, nonatomic) IBOutlet UILabel *lblHumanReable;
//    @property (weak, nonatomic) IBOutlet UILabel *lblJsonSummary;
    self.lblHumanReable.text = [NSString stringWithFormat:@"Latest loan: %@from %@ needs another $%.2f to pursue their entrepreneural dream",
                                [loan objectForKey:@"name"],
                                [(NSDictionary*)[loan objectForKey:@"location"]objectForKey:@"country"],
                                outstandingAmount];
    
}



@end
