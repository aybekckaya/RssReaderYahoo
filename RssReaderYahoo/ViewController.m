//
//  ViewController.m
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "ViewController.h"

#define CellMarginBottom 15

@interface ViewController ()

@end

@implementation ViewController
@synthesize CHUD;




-(void)awakeFromNib
{

   
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // For testing below part should be closed 
    
     
    RssURL=@"http://news.yahoo.com/rss/";
    
  
    
    CHUD=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:CHUD];
    CHUD.delegate=self;
   
    [self FetchRssInfo:YES];
    
}


-(void)FetchRssInfo:(BOOL) ProgressShow
{
    if(ProgressShow == YES)
    {
        [CHUD show:YES];
    }
    
    
    TotalNumEntriesHasReached=NO;
    
    RssItems=[[NSMutableArray alloc]init];
    XmlParser =[Parser SharedParser];
    XmlParser.delegate=self;
    XmlParser.DescFrame=CGRectMake(80, 88, 237, 65);
    XmlParser.HeaderFrame=CGRectMake(0, 0, 320, 42);
    XmlParser.ImageFrame=CGRectMake(4, 88, 72, 65);
    [XmlParser ParseXmlAtURL:RssURL];
}


#pragma mark ParserDelegate


-(void)ParserDidFetchRssItems:(NSArray *)RssArr
{
    if(RssArr == nil)
    {
        // An error occured
        [CHUD hide:YES];
    }
    TotalNumOfEntries=[RssArr count];
    [XmlParser CreateEntriesFromRssItems:0]; // init calls
}


-(void)ParserDidEndCreatingEntryObjects:(NSMutableArray *)EntryObjects
{
    [RssItems addObjectsFromArray:EntryObjects];
    
    [self.RssTable reloadData];
    [self.RssTable reloadInputViews];
   
      
    
   
    IsLoadingNewItems=NO;
    
    // CHUD has shown only at first query
    [CHUD hide:YES];
}

#pragma mark ParserDelegate END


#pragma mark PAGE Refresh

-(IBAction)RefreshPage:(id)sender
{
    [self FetchRssInfo:YES];
       
}


#pragma mark Page Refresh End


#pragma LoadingNewItems

-(void)LoadNewEntries
{
    IsLoadingNewItems=YES;
   
    
    int fromEntryNum=[RssItems count];
   // NSLog(@"Loading New Entries");
    [XmlParser CreateEntriesFromRssItems:fromEntryNum];
}



#pragma mark LoadingNewItems END



#pragma mark TableViewDelegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [RssItems count];
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Entry *theEntry=(Entry *)[RssItems objectAtIndex:indexPath.row];
    
    float heightForMiddleFrame=[theEntry DescLabelFrame].size.height > [theEntry ImageViewFrame].size.height ? [theEntry DescLabelFrame].size.height : [theEntry ImageViewFrame].size.height; // Sometimes the description label's height is more than image view's height.
    
    float heightRequired=[theEntry HeaderLabelFrame].size.height + heightForMiddleFrame+CellMarginBottom;
    
    return heightRequired;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
       
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        //NSLog(@"Cell Created NOW");
    }
    else
    {
       // NSLog(@"cell Created Befoe");
    }
    
    //set cell properties
    
    Entry *theEntry=(Entry *)[RssItems objectAtIndex:indexPath.row];
    
     ((UILabel *)[cell viewWithTag:1003]).text=[theEntry title];
    ((UILabel *)[cell viewWithTag:1003]).frame=[theEntry HeaderLabelFrame];
    //[((UILabel *)[cell viewWithTag:1003]) setBackgroundColor:[UIColor greenColor]];
    
    ((UILabel *)[cell viewWithTag:1002]).text=[theEntry description];
     ((UILabel *)[cell viewWithTag:1002]).frame=[theEntry DescLabelFrame];
   //  [((UILabel *)[cell viewWithTag:1002]) setBackgroundColor:[UIColor redColor]];
    
         
    [((UIImageView *)[cell viewWithTag:1001]) setImageWithURL:[NSURL URLWithString:[theEntry imageStr]] ];
    ((UIImageView *)[cell viewWithTag:1001]).frame=[theEntry ImageViewFrame];
    
    
    
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // Push To Detail View Controller
    DetailVC *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNewsView"];
    Entry *theEntry=(Entry *)[RssItems objectAtIndex:indexPath.row];
    newViewController.NewsURL=[theEntry link];
    [self.navigationController pushViewController:newViewController animated:YES];
    
}

#pragma mark TableViewDelegates END


#pragma mark ScrollviewDelegate (Scrollview that is insideTableView)

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Aim to use TotalNumEntriesHasReached value: Saving huge amount of time (about 4-5 ms)
     if(TotalNumEntriesHasReached == NO)
     {
         CGPoint tableBottomPt=CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+self.RssTable.frame.size.height-44);
         NSIndexPath *index= [self.RssTable indexPathForRowAtPoint:tableBottomPt];
    
    
      if( (index.row == [RssItems count]-1) && (IsLoadingNewItems == NO) && (index.row <TotalNumOfEntries-1))
        {
            [self LoadNewEntries];
        }
       else if(index.row == TotalNumOfEntries-1)
        {
            TotalNumEntriesHasReached=YES;
        }
         
     }
    
    
      
}




#pragma END ScrollView Delegate






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
