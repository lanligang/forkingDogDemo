### 删除原有的fd高度计算，使用系统的预估高度来进行计算，并加入缓存


简书地址  https://www.jianshu.com/p/67b0e83d2d71

![ForkingDogDemo](forkingDogDemo.gif)
*  缓存高度代码 在cell内部 设置从上到下 完美约束就可以 
| 使用效果      | 如何使用          | 怎么使用 |
| -----------  |:-------------:| -----:|
| 制表符号   | 制表符号 |制表符号 |
| 制表符号   | 制表符号      |   制表符号 |
| 制表符号   | are neat      |    制表符号 |
> 你有你的自由，我有我的快乐！开心最重要！

```
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//如果想要预估区头和区尾同样的方法
NSString *key = [NSString stringWithFormat:@"%@_%ld",indexPath,(long)tableView.tag];
NSNumber * heightNum = self.autoHeightCache[key];
if(heightNum)return heightNum.floatValue;
return 44.0f;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
NSString *key = [NSString stringWithFormat:@"%@_%ld",indexPath,(long)tableView.tag];
CGFloat height =  CGRectGetHeight(cell.frame);
self.autoHeightCache[key] = @(height);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
return UITableViewAutomaticDimension;
}
```
```
QQ 1176281703  QQ群 637387838
```
