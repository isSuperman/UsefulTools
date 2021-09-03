## commit_formate.sh

> 根据给定参数实现指定仓库commit信息的格式化

<details>
<summary>点击展开</summary>

### 使用方法
<details>
<summary>点击展开</summary>

```shell
./commit_formate.sh
```
</details>

### 输出
  
```shell
# - fix .....
# - update .....
```
</details>

## spend_time_formate.sh

> 根据给定的起始时间和截止时间计算时间差，格式化为xx小时xx分xx秒

<details>
<summary>点击展开</summary>
  
### 使用方法
<details>
<summary>点击展开</summary>

```shell
./spend_time_formate.sh [Start time] [End time] *[lang]
```
- Start time 起始时间戳 单位秒 date +%s
- End time 截止时间戳 单位秒 同上
- lang 输出语言 默认中文 选填'en' 英文
</details>

### 输出
```shell
# xx小时xx分xx秒
# 2h1m4s
```
</details>
  
## ETA_formate.sh

> 根据给定目标时期的日期（几号）给出目标时间人性化描述

<details>
<summary>点击展开</summary>

### 使用方法
<details>
<summary>点击展开</summary>
  
```shell
# 假设现在的日期为 2021-01-01,目标日期为2021-01-01
./ETA_formate.sh 01 15
./ETA_formate.sh 02 01
```
- 第一个参数 目标日期（几号）
- 第二个参数 目标时间（小时）
</details>

### 输出
```shell
# 今天下午 15:00
# 明天凌晨 01:00
```
</details>
