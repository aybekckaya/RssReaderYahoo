//
//  ViewController.m
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController





-(void)awakeFromNib
{
    /*
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:nil options:nil];
    UILabel *NavBarTitleView=(TitleViewCL *)[views objectAtIndex:0];
    UINavigationItem *navItem=self.navigationController.navigationItem;
    [self.navigationController.navigationItem setTitleView:NavBarTitleView];
     */
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    CHUD=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:CHUD];
    CHUD.delegate=self;
    [CHUD show:YES];
    
    [self.LoadingIndicator setHidden:YES];
    
    
    TotalNumEntriesHasReached=NO;
    // asdad
    RssItems=[[NSMutableArray alloc]init];
    XmlParser =[Parser SharedParser];
    XmlParser.delegate=self;
    [XmlParser ParseXmlAtURL:@"http://news.yahoo.com/rss/"];
    
    
    
}


#pragma mark ParserDelegate


-(void)ParserDidFetchRssItems:(NSArray *)RssArr
{
    TotalNumOfEntries=[RssArr count];
    [XmlParser CreateEntriesFromRssItems:0]; // init callas
}


-(void)ParserDidEndCreatingEntryObjects:(NSMutableArray *)EntryObjects
{
    [RssItems addObjectsFromArray:EntryObjects];
    
    [self.RssTable reloadData];
    [self.RssTable reloadInputViews];
   
      
    
    [self.LoadingIndicator stopAnimating];
    [self.LoadingIndicator setHidden:YES];
    IsLoadingNewItems=NO;
    
    // CHUD has shown only at first query
    [CHUD hide:YES];
}

#pragma mark ParserDelegate END




#pragma LoadingNewItems

-(void)LoadNewEntries
{
    IsLoadingNewItems=YES;
    [self.LoadingIndicator setHidden:NO];
    [self.LoadingIndicator startAnimating];
    
    int fromEntryNum=[RssItems count];
    NSLog(@"Loading New Entries");
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
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"RssCell" owner:nil options:nil];
    
    RssCellCL *tableCell=(RssCellCL *)[views objectAtIndex:0];
    
  
    return tableCell.frame.size.height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    const NSInteger HEADERLABELTAG=1000; // Takilmalari onlemek icin
    const NSInteger RSSIMAGETAG=1001;
    const NSInteger NEWSLABELTAG=1002;
    
    
    static NSString *reuseIdentifier = @"Celli";
    //asdeewe
    RssCellCL *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(cell == nil)
    {
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"RssCell" owner:nil options:nil];
        
        cell =(RssCellCL *)[views objectAtIndex:0];
        cell.NewsLbl.tag=NEWSLABELTAG;
        cell.HeaderLbl.tag=HEADERLABELTAG;
        cell.EntryImageView.tag=RSSIMAGETAG;
        
        NSLog(@"Cell Created NOW: %d",indexPath.row);
    }
    else
    {
        cell.NewsLbl=(UILabel *)[cell viewWithTag:NEWSLABELTAG];
        cell.HeaderLbl=(UILabel *)[cell viewWithTag:HEADERLABELTAG];
        cell.EntryImageView=(UIImageView *)[cell viewWithTag:RSSIMAGETAG];
     
        NSLog(@"Cell Created BEFORE : %d",indexPath.row);
    }
    
    Entry *theEntry=[RssItems objectAtIndex:indexPath.row];
    [cell SetNewsLblText:[theEntry description]];
    [cell SetHeaderLblText:[theEntry title]];
    [cell SetEntryImageStr:[theEntry imageStr]];
    cell.EntryLink=[theEntry link];
    
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
