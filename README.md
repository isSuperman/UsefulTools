# UsefulTools

> 技术有限，写一些实用shell小脚本，方便数据处理

## commit_formate.sh

根据给定参数实现指定仓库commit信息的格式化

### 使用方法
```shell
./commit_formate.sh [user] [repo] *[date]
```
- 第一个参数 仓库所有者名字 *必填*
- 第二个参数 仓库名 *必填*
- 第三个参数 commit提交日期 格式 2021-01-01 选填

### 输出
```
- fix .....
- update .....
```

## spend_time_formate.sh

根据给定的起始时间和截止时间计算时间差，格式化为xx小时xx分xx秒

### 使用方法
```shell
./spend_time_formate.sh [Start time] [End time]
```
- Start time 起始时间戳 单位秒 date +%s
- End time 截止时间戳 单位秒 同上

### 输出
```shell
xx小时xx分xx秒
```
