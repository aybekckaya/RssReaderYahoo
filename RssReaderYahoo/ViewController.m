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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CHUD=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:CHUD];
    CHUD.delegate=self;
    [CHUD show:YES];
    
    [self.LoadingIndicator setHidden:YES];
    
    currentSelection=-1;
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
    
    if(indexPath.row == currentSelection)
    {
        return tableCell.frame.size.height;
    }

    return tableCell.frame.size.height-40;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    const NSInteger TABLECELLTAG=1000;
    const NSInteger TwitterBtnTag=1071;
    const NSInteger DetailBtnTag=1072;
    
    static NSString *reuseIdentifier = @"Cell";
    //asdeewe
    RssCellCL *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(cell == nil)
    {
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"RssCell" owner:nil options:nil];
        
        cell =(RssCellCL *)[views objectAtIndex:0];
        cell.delegate=self;
      
         
        cell.twitterBtn.tag=TwitterBtnTag;
        cell.detailsBtn.tag=DetailBtnTag;
        
        NSLog(@"Cell Created NOW: %d",indexPath.row);
    }
    else
    {
        // [cell CloseCell];
        cell.twitterBtn=(UIButton *)[cell viewWithTag:TwitterBtnTag];
        cell.detailsBtn=(UIButton *)[cell viewWithTag:DetailBtnTag];
      //  [cell CloseCell];
        // cell has created Beforej
        NSLog(@"Cell Created BEFORE : %d",indexPath.row);
    }
    
    Entry *theEntry=[RssItems objectAtIndex:indexPath.row];
    [cell SetNewsLblText:[theEntry description]];
    [cell SetHeaderLblText:[theEntry title]];
    [cell SetEntryImageStr:[theEntry imageStr]];
    cell.EntryLink=[theEntry link];
    
    if(indexPath.row != currentSelection)
    {
     
        [cell CloseCell];
    }
    else
    {
        [cell OpenCell];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RssCellCL *OldSelectedCell;
    if(currentSelection != -1)
    {
        
        //OldSelectedCell=(RssCellCL *)[tableView viewWithTag:currentSelection+1];
        OldSelectedCell=(RssCellCL *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelection inSection:0]];
    }
       
    
    int row = [indexPath row];
    currentSelection = row;
    
   // RssCellCL *NewSelectedCell=(RssCellCL *)[tableView viewWithTag:row+1];
    RssCellCL *NewSelectedCell=(RssCellCL *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSelection inSection:0]];
 
    [tableView beginUpdates];
    
        [NewSelectedCell OpenCell];
        if(OldSelectedCell != nil)
        {
            [OldSelectedCell CloseCell];
        }
    
    [tableView endUpdates];
  
}

#pragma mark TableViewDelegates END


#pragma mark ScrollviewDelegate (Scrollview that is insideTableView)

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Aim to use TotalNumEntriesHasReached value: Savign huge amount of time (about 4-5 ms)
     if(TotalNumEntriesHasReached == NO)
     {
         CGPoint tableBottomPt=CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+self.RssTable.frame.size.height-44);
         NSIndexPath *index= [self.RssTable indexPathForRowAtPoint:tableBottomPt];
    // NSLog(@"%f",tableBottomPt.y);
    //NSLog(@"%d",index.row);
    
      if( (index.row == [RssItems count]-1) && (IsLoadingNewItems == NO) && (index.row <TotalNumOfEntries-1))
        {
            //NSLog(@"Should Load New Items");
            [self LoadNewEntries];
        }
       else if(index.row == TotalNumOfEntries-1)
        {
            TotalNumEntriesHasReached=YES;
        }
         
     }
    
}




#pragma END ScrollView Delegate




#pragma mark RssCell Delegate

/*
     @ push to detailview or share news on the twitter 
 */
-(void)RssCellButtonDidClicked:(UIButton *)button Link:(NSString *)_link
{
    if([button tag] == 1071)
    {
        // Twitter Btn
    }
    else if([button tag] == 1072)
    {
        // details Btn
    }
}


#pragma mark End RssCell Delegate



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
